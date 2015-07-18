package user

import form.Form
import form.FormType
import grails.plugin.springsecurity.annotation.Secured
import org.springframework.security.acls.domain.BasePermission
import org.springframework.security.acls.model.Permission
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken

import static org.springframework.security.acls.domain.BasePermission.*

@Secured(['ROLE_WORKER'])
class UserController {
    static allowedMethods = [save: 'POST']

    private static final Permission[] HAS_WRITE = [WRITE, ADMINISTRATION]
    private static final Permission[] HAS_DELETE = [DELETE, ADMINISTRATION]
    private static final Permission[] HAS_CREATE = [CREATE, ADMINISTRATION]
    private static final Permission[] HAS_ADMIN = [ADMINISTRATION]

    def springSecurityService
    def aclUtilService

    def userService

    def show(long id) {
        def user = userService.getById(id)

        [user: user, xhr: request.xhr, updateTree: params.updateTree]
    }

    def create(long id) {
        def currentAuth = springSecurityService.authentication

        if (!id) {
            id = springSecurityService.currentUser.id
        }

        def parent = userService.getById(id)

        List<FormType> formTypes = FormType.list(sort: "shortcut");
        Map<Form, Boolean> hasCreate = [:]
        for (FormType formType : formTypes) {
            hasCreate[formType] = aclUtilService.hasPermission(currentAuth, formType, HAS_CREATE)
        }

        render(view: "update", model: [formTypes: formTypes, formTypeCreatePermission: hasCreate, isAdmin: hasCreate, parent: parent, xhr: request.xhr])
    }

    def update(long id) {
        def currentAuth = springSecurityService.authentication

        if (!id) {
            id = springSecurityService.currentUser.id
        }

        def user = userService.getById(id)
        def userAuth = new UsernamePasswordAuthenticationToken(user.username, user.password)

        List<FormType> formTypes = FormType.list(sort: "shortcut");
        Map<FormType, Boolean> hasCreate = [:]
        Map<FormType, Boolean> isAdmin = [:]
        def admin = aclUtilService.hasPermission(currentAuth, user, BasePermission.ADMINISTRATION)

        for (FormType formType : formTypes) {
            hasCreate[formType] = aclUtilService.hasPermission(userAuth, formType, HAS_CREATE)
            if (admin)
                isAdmin[formType] = aclUtilService.hasPermission(currentAuth, formType, HAS_CREATE)
            else
                isAdmin[formType] = false
        }

        [user: user, formTypes: formTypes, formTypeCreatePermission: hasCreate, isAdmin: isAdmin, parent: user.parent, xhr: request.xhr]
    }

    def updatePassword() {
    }

    // FIXME ROLES
    @Secured(['ROLE_WORKER', 'ROLE_ADMIN'])
    def save(long userId, long parentId) {
        def user
        def parent
        if (userId)
            user = userService.getById(userId)
        else
            parent = userService.getById(parentId)

        if (params.password1 || params.password2) {
            if (params.password1 != params.password2) {
                flash.error = "Heslá sa nezhodujú!"

                redirect(action: "update", id: userId)

                return
            }

            if (userId) {
                userService.update(user, params.name, params.university, params.faculty, params.email, params.comment, params.password1, params.formTypes);
                flash.success = "Zmeny boli uložené"
            } else {
                userService.create(parent, params.username, params.name, params.university, params.faculty, params.email, params.comment, params.password1, params.formTypes);
                flash.success = "Používateľ bol vytvorený"
            }

            redirect(action: "update", id: userId)

            return
        }

        if (userId) {
            userService.update(user, params.name, params.university, params.faculty, params.email, params.comment, params.formTypes);
            flash.success = "Zmeny boli uložené"
        } else
            flash.error "Chyba hesla!"

        redirect(action: "update", id: userId)
    }

    def permissions() {
        User user = springSecurityService.currentUser
        [userInstance: user]
    }

    def getChildrenJSON(long id) {
        User user = userService.getById(id)

        response.setContentType "application/json"
        response.setCharacterEncoding("UTF-8")
        render userService.getAllChildrenJSON(user)
    }

    @Secured(['ROLE_ADMIN'])
    def switchUser() {
        [users: userService.getAll()]
    }

}
