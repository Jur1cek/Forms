package user

import form.FormType
import grails.transaction.Transactional
import org.springframework.security.access.prepost.PostFilter
import org.springframework.security.access.prepost.PreAuthorize
import org.springframework.security.acls.domain.BasePermission
import org.springframework.security.acls.domain.PrincipalSid
import org.springframework.security.acls.model.Permission
import org.springframework.security.acls.model.Sid

@Transactional
class UserService {

    def aclService
    def aclUtilService
    def springSecurityService

    def formTypeService

    @PreAuthorize("hasPermission(#user, admin)")
    void addPermission(User user, Sid userSid, Permission permission) {
        aclUtilService.addPermission User, user.id, userSid, permission
    }

    @PreAuthorize("hasPermission(#user, admin)")
    void deletePermission(User user, Sid userSid, Permission permission) {
        def acl = aclUtilService.readAcl(user)

        acl.entries.eachWithIndex { entry, i ->
            if (entry.sid.equals(user) && entry.permission.equals(permission)) {
                acl.deleteAce i
            }
        }

        aclService.updateAcl acl
    }

    @PreAuthorize("hasPermission(#user, write) or hasPermission(#user, admin)")
    void update(User user, String name, String university, String faculty, String email, String comment,
                def formTypes) {
        UserProfile userProfile = user.userProfile

        userProfile.name = name
        userProfile.university = university
        userProfile.faculty = faculty
        userProfile.email = email
        userProfile.comment = comment

        userProfile.save()

        def allFormTypes = FormType.list()
        allFormTypes.each { formType ->
            try {
                aclUtilService.deletePermission(formType, new PrincipalSid(user.username), BasePermission.CREATE)
            } catch (Exception e) {
                e.printStackTrace()
            }
        }

        formTypes.each { formTypeId ->
            def formType = formTypeService.getById(Long.parseLong(formTypeId))
            formTypeService.addPermission(formType, new PrincipalSid(user.username), BasePermission.CREATE)
        }
    }

    @PreAuthorize("hasPermission(#user, write) or hasPermission(#user, admin)")
    void update(User user, String name, String university, String faculty, String email, String comment, String password,
                def formTypes) {
        UserProfile userProfile = user.userProfile

        userProfile.name = name
        userProfile.university = university
        userProfile.faculty = faculty
        userProfile.email = email
        userProfile.comment = comment

        user.setPassword(password)

        userProfile.save()
        user.save()

        def allFormTypes = FormType.list()
        allFormTypes.each { formType ->
            try {
                aclUtilService.deletePermission(formType, new PrincipalSid(user.username), BasePermission.CREATE)
            } catch (Exception e) {

            }
        }

        formTypes.each { formTypeId ->
            def formType = formTypeService.getById(Long.parseLong(formTypeId))
            formTypeService.addPermission(formType, new PrincipalSid(user.username), BasePermission.CREATE)
        }
    }

    void create(User parent, String username, String name, String university, String faculty, String email, String comment, String password,
                def formTypes) {

        def user = new User(parent: parent, username: username, password: password, userProfile: new UserProfile(name: name, university: university, faculty: faculty, email: email, comment: comment))
        user.save()

        parent.addToChildren(user)

        addRole(user)

        addPermissionsToParents(user, user, BasePermission.ADMINISTRATION)

        addPermission(user, new PrincipalSid(user.username), BasePermission.READ)
        addPermission(user, new PrincipalSid(user.username), BasePermission.WRITE)

        formTypes.each { formTypeId ->
            def formType = formTypeService.getById(Long.parseLong(formTypeId))
            formTypeService.addPermission(formType, new PrincipalSid(user.username), BasePermission.CREATE)
        }
    }

    /* @PreAuthorize("hasPermission(#user, admin)")
     private def getAllChildrenP(User user, result = []) {
         user.children.each { child ->
             result << child
             getAllChildrenP(child, result)
         }
     }

     @PreAuthorize("hasPermission(#user, admin)")
     List<User> getAllChildren(User user) {
         def children = []
         getAllChildrenP(user, children)
         children
     }*/

    private List<User> getParentsTooRootP(User user, parents) {
        user.parent.each { parent ->
            parents << parent
            getParentsTooRootP(parent, parents)
        }

        parents
    }

    List<User> getParentsToRoot(User user) {
        List<User> parents = []
        getParentsTooRootP(user, parents)
        parents
    }

    void addPermissionsToParents(User user, def object, def permission) {
        def parents = getParentsToRoot(user)
        parents.each { parent ->
            aclUtilService.addPermission(object, new PrincipalSid(parent.username), permission)

        }
    }

    @PreAuthorize("hasPermission(#user, admin) or hasPermission(#user, read)")
    private def getAllChildrenJSONP(User user, result) {
        user.children.sort { it.userProfile.name }.eachWithIndex { child, i ->
            if (i > 0)
                result << ","
            String icon = getTreeIcon(child)
            result << "{\"id\": \"$child.id\", \"text\": \"$child.userProfile.name\", \"icon\": \"$icon\", \"children\": ["
            getAllChildrenJSONP(child, result)
            result << "]}"
        }

        result
    }

    @PreAuthorize("hasPermission(#user, admin) or hasPermission(#user, read)")
    String getAllChildrenJSON(User user) {
        def json = new StringBuffer()
        String icon = getTreeIcon(user)

        json << "{\"id\": \"$user.id\", \"text\": \"$user.userProfile.name\", \"icon\": \"$icon\", \"children\": ["
        getAllChildrenJSONP(user, json)
        json << "]}"

        json
    }

    private String getTreeIcon(User user) {
        def icon

        if (!user.enabled)
            return "fa fa-times"

        if (user.authorities.authority.contains('ROLE_ADMIN')) {
            icon = "fa fa-user-secret"
        } else if (user.authorities.authority.contains('ROLE_USER')) {
            icon = "fa fa-random"
        } else if (user.authorities.authority.contains('ROLE_UNIVERSITY')) {
            icon = "fa fa-university"
        } else if (user.authorities.authority.contains('ROLE_SPECIAL')) {
            icon = "fa fa-asterisk"
        } else if (user.authorities.authority.contains('ROLE_FACULTY')) {
            icon = "fa fa-building"
        } else if (user.authorities.authority.contains('ROLE_WORKER')) {
            icon = "fa fa-user"
        } else {
            icon = "fa fa-question"
        }

        return icon
    }

    private void addRole(User user) {
        if (user.parent.authorities.authority.contains('ROLE_ADMIN')) {
            def role = Role.findByAuthority('ROLE_UNIVERSITY')
            UserRole.create(user, role, true)
        } else if (user.parent.authorities.authority.contains('ROLE_USER')) {
            def role = Role.findByAuthority('ROLE_WORKER')
            UserRole.create(user, role, true)
        } else if (user.parent.authorities.authority.contains('ROLE_UNIVERSITY')) {
            def role = Role.findByAuthority('ROLE_FACULTY')
            UserRole.create(user, role, true)
        } else if (user.parent.authorities.authority.contains('ROLE_SPECIAL')) {
            def role = Role.findByAuthority('ROLE_WORKER')
            UserRole.create(user, role, true)
        } else if (user.parent.authorities.authority.contains('ROLE_FACULTY')) {
            def role = Role.findByAuthority('ROLE_WORKER')
            UserRole.create(user, role, true)
        } else if (user.parent.authorities.authority.contains('ROLE_WORKER')) {
            def role = Role.findByAuthority('ROLE_WORKER')
            UserRole.create(user, role, true)
        } else {
            throw new Exception("Unknown parent role!")
        }
    }

    @PostFilter("hasPermission(filterObject, 'read') or hasPermission(filterObject, admin)")
    List<User> getAll(params) {
        User.list(params)
    }

    @PostFilter("hasPermission(filterObject, 'read') or hasPermission(filterObject, admin)")
    List<User> getAll() {
        User.list()
    }

    @PreAuthorize("hasPermission(#id, 'user.User', read) or hasPermission(#id, 'user.User', admin)")
    User getById(Long id) {
        User.get id
    }
}
