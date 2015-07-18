package document

import grails.transaction.Transactional
import org.springframework.security.access.prepost.PostFilter
import org.springframework.security.access.prepost.PreAuthorize
import org.springframework.security.acls.domain.BasePermission
import org.springframework.security.acls.domain.PrincipalSid
import org.springframework.security.acls.model.Permission
import org.springframework.security.acls.model.Sid
import user.User

@Transactional
class DocumentService {

    def aclService
    def aclUtilService
    def springSecurityService

    def userService

    @PreAuthorize("hasPermission(#document, admin)")
    void addPermission(Document document, Sid user, Permission permission) {
        aclUtilService.addPermission Document, document.id, user, permission
    }

    @PreAuthorize("hasPermission(#document, admin)")
    void deletePermission(Document document, Sid user, Permission permission) {
        def acl = aclUtilService.readAcl(document)

        acl.entries.eachWithIndex { entry, i ->
            if (entry.sid.equals(user) && entry.permission.equals(permission)) {
                acl.deleteAce i
            }
        }

        aclService.updateAcl acl

        log.debug "Deleted document $document ACL permissions for user $user"
    }

    Document createDocument(def file, String basePath, String path) {
        def user = springSecurityService.currentUser

        Document document = new Document()

        document.filename = file.originalFilename
        document.path = path
        document.size = file.getSize()
        document.creator = user

        File saveFile = new File(basePath + document.path);

        file.transferTo(saveFile)

        document.md5 = getMd5(saveFile)
        document.sha1 = getSha1(saveFile)

        document.save()

        String username = springSecurityService.authentication.name
        addPermission document, new PrincipalSid(username), BasePermission.ADMINISTRATION

        userService.addPermissionsToParents(user, document, BasePermission.ADMINISTRATION)

        log.debug "Created document $document by $username"

        return document
    }

    @PreAuthorize("hasPermission(#document, delete) or hasPermission(#document, admin)")
    void delete(Document document, String basePath) {
        def file = new File(basePath + document.path)
        file.delete();

        document.delete()

        aclUtilService.deleteAcl document

        log.debug "Deleted document $document including ACL permissions"
    }

    @PostFilter("hasPermission(filterObject, 'read') or hasPermission(filterObject, admin)")
    List<Document> getAll(params) {
        log.debug 'Returning all documents with params'
        Document.list(params)
    }

    @PostFilter("hasPermission(filterObject, 'read') or hasPermission(filterObject, admin)")
    List<Document> getAll() {
        log.debug 'Returning all documents'
        Document.list()
    }

    @PostFilter("hasPermission(filterObject, 'read') or hasPermission(filterObject, admin)")
    List<Document> getAll(User user, params) {
        log.debug 'Returning all documents with params'
        Document.findAllByCreator(user, params)
    }

    @PostFilter("hasPermission(filterObject, 'read') or hasPermission(filterObject, admin)")
    List<Document> getAll(User user) {
        log.debug 'Returning all documents'
        Document.findAllByCreator(user)
    }

    @PreAuthorize("hasPermission(#id, 'document.Document', read) or hasPermission(#id, 'document.Document', admin)")
    Document getById(Long id) {
        log.debug "Returning document with id: $id"
        Document.get id
    }

    @PreAuthorize("hasPermission(#document, read) or hasPermission(#document, admin)")
    def getMd5(File file) {
        new AntBuilder().with {
            checksum(file: file, algorithm: 'md5', property: 'result')
            it.project.properties.result
        }
    }

    @PreAuthorize("hasPermission(#document, read) or hasPermission(#document, admin)")
    def getSha1(File file) {
        new AntBuilder().with {
            checksum(file: file, algorithm: 'sha1', property: 'result')
            it.project.properties.result
        }
    }

    @PreAuthorize("hasPermission(#document, write) or hasPermission(#document, admin)")
    void addDescription(Document document, String description) {
        document.description = description
        document.save()
    }
}