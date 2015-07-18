package form

import grails.transaction.Transactional
import org.springframework.security.access.prepost.PostFilter
import org.springframework.security.access.prepost.PreAuthorize
import org.springframework.security.acls.model.Permission
import org.springframework.security.acls.model.Sid

@Transactional
class FormTypeService {

    def aclService
    def aclUtilService
    def springSecurityService

    //@PreAuthorize("hasPermission(#formType, admin)")
    void addPermission(FormType formType, Sid user, Permission permission) {
        aclUtilService.addPermission FormType, formType.id, user, permission
    }

    //@PreAuthorize("hasPermission(#formType, admin)")
    void deletePermission(FormType formType, Sid user, Permission permission) {
        def acl = aclUtilService.readAcl(formType)

        acl.entries.eachWithIndex { entry, i ->
            if (entry.sid.equals(user) && entry.permission.equals(permission)) {
                acl.deleteAce i
            }
        }

        aclService.updateAcl acl

        log.debug "Deleted formType $formType ACL permissions for user $user"
    }

    @PostFilter("hasPermission(filterObject, 'read') or hasPermission(filterObject, admin) or hasPermission(filterObject, create)")
    List<FormType> getAll(boolean collationMain) {
        FormType.findAllByCollationMain collationMain
    }

    @PreAuthorize("hasPermission(#id, 'form.FormType', read) or hasPermission(#id, 'form.FormType', admin) or hasPermission(#id, 'form.FormType', create)")
    FormType getById(Long id) {
        FormType.get id
    }
}
