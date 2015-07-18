package collation

import grails.transaction.Transactional

import org.springframework.security.access.prepost.PostFilter
import org.springframework.security.access.prepost.PreAuthorize
import org.springframework.security.acls.domain.BasePermission
import org.springframework.security.acls.domain.PrincipalSid
import org.springframework.security.acls.model.Permission
import org.springframework.security.acls.model.Sid

import user.User

@Transactional
class CollationService {
	def aclService
	def aclUtilService
	def springSecurityService

	def documentService
	def formService
    def userService

	@PreAuthorize("hasPermission(#collation, admin)")
	void addPermission(Collation collation, Sid user, Permission permission) {
		aclUtilService.addPermission Collation, collation.id, user, permission
	}

	@PreAuthorize("hasPermission(#collation, admin)")
	void deletePermission(Collation collation, Sid user, Permission permission) {
		def acl = aclUtilService.readAcl(collation)

		acl.entries.eachWithIndex { entry, i ->
			if (entry.sid.equals(user) && entry.permission.equals(permission)) {
				acl.deleteAce i
			}
		}

		aclService.updateAcl acl

		log.debug "Deleted collation $collation ACL permissions for user $user"
	}

	Collation createCollation(long mainFormId, String name, def documents, def forms) {
		def user = springSecurityService.currentUser

		Collation collation = new Collation()

		collation.name = name
		collation.creator = user
		collation.updater = user
		//TODO check if really main
		collation.mainForm = formService.getById(mainFormId)

		documents.each() {
			def document = documentService.getById(it as long)
			collation.addToDocuments(document)
		}

		forms.each() {
			def form = formService.getById(it as long)
			collation.addToForms(form)

		}

		collation.save()

		println collation.errors

		String username = springSecurityService.authentication.name
		addPermission collation, new PrincipalSid(username), BasePermission.ADMINISTRATION

        userService.addPermissionsToParents(user, collation, BasePermission.ADMINISTRATION)

        log.debug "Created form $collation by $username"

		return collation
	}

	@PreAuthorize("hasPermission(#collation, write) or hasPermission(#collation, admin)")
	Collation updateCollation(Collation collation, long mainFormId, String name, def documents, def forms) {
		def user = springSecurityService.currentUser
		
		collation.name = name
		collation.updateDate = new Date()
		collation.updater = user
		// TODO check if really main
		collation.mainForm = formService.getById(mainFormId)

		collation.documents.clear()
		documents.each() {
			def document = documentService.getById(it as long)
			collation.addToDocuments(document)
		}

		collation.forms.clear()
		forms.each() {
			def form = formService.getById(it as long)
			collation.addToForms(form)

		}

		collation.save()
		
		println collation.errors
		
		log.debug "Updated collation $collation"

		return collation
	}

	@PreAuthorize("hasPermission(#collation, delete) or hasPermission(#collation, admin)")
	void delete(Collation collation) {
		collation.delete()

		aclUtilService.deleteAcl collation

		log.debug "Deleted collation $collation including ACL permissions"
	}

	@PostFilter("hasPermission(filterObject, 'read') or hasPermission(filterObject, admin)")
	List<Collation> getAll(params) {
		log.debug 'Returning all collations with params'
		Collation.list(params)
	}

	@PostFilter("hasPermission(filterObject, 'read') or hasPermission(filterObject, admin)")
	List<Collation> getAll() {
		log.debug 'Returning all collations'
		Collation.list()
	}

	@PostFilter("hasPermission(filterObject, 'read') or hasPermission(filterObject, admin)")
	List<Collation> getAll(User user, params) {
		log.debug 'Returning all collations with params'
		Collation.findAllByCreator(user, params)
	}

	@PostFilter("hasPermission(filterObject, 'read') or hasPermission(filterObject, admin)")
	List<Collation> getAll(User user) {
		log.debug 'Returning all collations'
		Collation.findAllByCreator(user)
	}

	@PreAuthorize("hasPermission(#id, 'collation.Collation', read) or hasPermission(#id, 'collation.Collation', admin)")
	Collation getById(Long id) {
		log.debug "Returning collation with id: $id"
		Collation.get id
	}
}
