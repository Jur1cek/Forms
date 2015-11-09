package form

import grails.transaction.Transactional
import org.springframework.security.access.prepost.PostFilter
import org.springframework.security.access.prepost.PreAuthorize
import org.springframework.security.acls.domain.BasePermission
import org.springframework.security.acls.domain.PrincipalSid
import org.springframework.security.acls.model.Permission
import org.springframework.security.acls.model.Sid
import user.User

@Transactional
class FormService {

    def aclService
    def aclUtilService
    def springSecurityService

    def formTypeService
    def userService

    @PreAuthorize("hasPermission(#form, admin)")
    void addPermission(Form form, Sid user, Permission permission) {
        aclUtilService.addPermission Form, form.id, user, permission
    }

    @PreAuthorize("hasPermission(#form, admin)")
    void deletePermission(Form form, Sid user, Permission permission) {
        def acl = aclUtilService.readAcl(form)

        acl.entries.eachWithIndex { entry, i ->
            if (entry.sid.equals(user) && entry.permission.equals(permission)) {
                acl.deleteAce i
            }
        }

        aclService.updateAcl acl

        log.debug "Deleted form $form ACL permissions for user $user"
    }

    Form createForm(String type, String name, Map fields) {
        def user = springSecurityService.currentUser

        Form form = new Form()

        FormType formType = formTypeService.getById(Long.parseLong(type))

        form.type = formType
        form.creator = user
        form.updater = user

        if (form.type.shortcut == 'IL') {
            form.name = fields?.form_kod_predmetu_1 + " " + fields?.form_nazov_predmetu_1
        } else if (form.type.shortcut == 'VPCH') {
            form.name = fields?.form_meno + " " + fields?.form_rok_narodenia
        }

        //fields.each { it.value = StringEscapeUtils.escapeHtml(it.value) }


        def version = new FormFieldsVersion(creator: user);
        Map<String, FormField> fieldsC = [:]
        fields.each { key, value ->
            fieldsC.put(key, new FormField(values: value, fieldsVersion: version))
        }
        version.fields = fieldsC
        form.addToFieldsVersion version

        form.save()

        String username = springSecurityService.authentication.name
        addPermission form, new PrincipalSid(username), BasePermission.READ
        addPermission form, new PrincipalSid(username), BasePermission.WRITE
        addPermission form, new PrincipalSid(username), BasePermission.DELETE

        userService.addPermissionsToParents(user, form, BasePermission.ADMINISTRATION)

        log.debug "Created form $form by $username"

        return form
    }

    @PreAuthorize("hasPermission(#form, write) or hasPermission(#form, admin)")
    void updateForm(Form form, String name, Map fields) {
        def user = springSecurityService.currentUser

        if (form.type.shortcut == 'IL') {
            form.name = fields?.form_kod_predmetu_1 + " " + fields?.form_nazov_predmetu_1
        } else if (form.type.shortcut == 'VPCH') {
            form.name = fields?.form_meno + " " + fields?.form_rok_narodenia
        }

        form.status = Form.ApprovalStatus.NONE

        form.updater = user
        form.updateDate = new Date()

        def version = new FormFieldsVersion(creator: user);
        Map<String, FormField> fieldsC = [:]
        fields.each { key, value ->
            fieldsC.put(key, new FormField(values: value, fieldsVersion: version))
        }
        version.fields = fieldsC
        form.addToFieldsVersion version

        form.save()

        log.debug "Updated form $form"
    }

    @PreAuthorize("hasPermission(#form, read) or hasPermission(#form, admin)")
    def getFormAsXml(Form form, def version) {
        def s_xml = new StringWriter()
        s_xml.write("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n")
        def builder = new groovy.xml.MarkupBuilder(s_xml)
        builder.form {
            form.fields?.get(version).fields.each() { key, value ->
                "${key}" "${value}"
            }
        }

        return s_xml.toString()
    }

    @PreAuthorize("hasPermission(#form, delete) or hasPermission(#form, admin)")
    void delete(Form form) {
        form.delete()

        aclUtilService.deleteAcl form

        log.debug "Deleted form $form including ACL permissions"
    }

    @PreAuthorize("hasPermission(#form, admin) or hasRole('ROLE_UNIVERSITY')")
    void approve(Form form) {
        form.status = Form.ApprovalStatus.APPROVED
        form.save()

        log.debug "Deleted form $form including ACL permissions"
    }

    @PreAuthorize("hasPermission(#form, admin) or hasRole('ROLE_UNIVERSITY')")
    void reject(Form form) {
        form.status = Form.ApprovalStatus.REJECTED
        form.save()

        log.debug "Deleted form $form including ACL permissions"
    }

    @PreAuthorize("hasPermission(#form, write) or hasPermission(#form, admin)")
    void startApproval(Form form) {
        form.status = Form.ApprovalStatus.PENDING
        form.save()

        log.debug "Deleted form $form including ACL permissions"
    }

    @PreAuthorize("hasPermission(#form, write) or hasPermission(#form, admin)")
    void stopApproval(Form form) {
        form.status = Form.ApprovalStatus.NONE
        form.save()

        log.debug "Deleted form $form including ACL permissions"
    }

    @PostFilter("hasPermission(filterObject, 'read') or hasPermission(filterObject, admin)")
    List<Form> getAll(params) {
        log.debug 'Returning all forms with params'
        Form.list(params)
    }

    @PostFilter("hasPermission(filterObject, 'read') or hasPermission(filterObject, admin)")
    List<Form> getAll() {
        log.debug 'Returning all forms'
        Form.list()
    }

    @PostFilter("hasPermission(filterObject, 'read') or hasPermission(filterObject, admin)")
    List<Form> getAll(params, FormType formType) {
        log.debug 'Returning all forms with params'
        Form.findAllByType(formType, params)
    }

    @PostFilter("hasPermission(filterObject, 'read') or hasPermission(filterObject, admin)")
    List<Form> getAll(FormType formType) {
        log.debug 'Returning all forms'
        Form.findAllByType(formType)
    }

    @PostFilter("hasPermission(filterObject, 'read') or hasPermission(filterObject, admin)")
    List<Form> getAll(User user, params) {
        log.debug 'Returning all forms with params'
        Form.findAllByCreator(user, params)
    }

    @PostFilter("hasPermission(filterObject, 'read') or hasPermission(filterObject, admin)")
    List<Form> getAll(User user) {
        log.debug 'Returning all forms'
        Form.findAllByCreator(user)
    }

    @PreAuthorize("hasPermission(#id, 'form.Form', read) or hasPermission(#id, 'form.Form', admin)")
    Form getById(Long id) {
        log.debug "Returning form with id: $id"
        Form.get id
    }

    @PreAuthorize("hasPermission(#form, write) or hasPermission(#form, admin)")
    void addComment(Form form, String text) {
        log.debug "Adding comment to form ${form.id}: ${text}"
        def user = springSecurityService.currentUser

        form.addToComments(new Comment(creator: user, text: text))
        form.save()
    }
}
