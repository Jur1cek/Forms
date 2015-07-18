package document

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured
import org.springframework.security.acls.model.Permission

import static java.util.UUID.randomUUID
import static org.springframework.security.acls.domain.BasePermission.*

@Secured(['ROLE_WORKER'])
class DocumentController {
    static allowedMethods = [delete: 'DELETE', upload: 'POST', description: 'POST']


    def aclUtilService
    def springSecurityService

    def documentService
    def userService

    private static final Permission[] HAS_READ = [READ, ADMINISTRATION]
    private static final Permission[] HAS_WRITE = [WRITE, ADMINISTRATION]
    private static final Permission[] HAS_DELETE = [DELETE, ADMINISTRATION]
    private static final Permission[] HAS_ADMIN = [ADMINISTRATION]

    def index() {
        if (!params?.max) {
            params.max = 10
        }

        List<Document> allDocuments
        int documentCount

        if (params.userId) {
            def user = userService.getById(params.long('userId'))
            allDocuments = documentService.getAll(user, params)
            documentCount = documentService.getAll(user).size()
        } else {
            allDocuments = documentService.getAll(params)
            documentCount = documentService.getAll().size()
        }

        Map<Document, Boolean> hasRead = [:]
        Map<Document, Boolean> hasWrite = [:]
        Map<Document, Boolean> hasDelete = [:]
        Map<Document, Boolean> hasAdmin = [:]

        def currentAuth = springSecurityService.authentication
        for (Document document : allDocuments) {
            hasRead[document] = aclUtilService.hasPermission(currentAuth, document, HAS_READ)
            hasWrite[document] = aclUtilService.hasPermission(currentAuth, document, HAS_WRITE)
            hasDelete[document] = aclUtilService.hasPermission(currentAuth, document, HAS_DELETE)
            hasAdmin[document] = aclUtilService.hasPermission(currentAuth, document, HAS_ADMIN)
        }

        [documents          : allDocuments, documentCount: documentCount,
         hasWriteRead       : hasRead,
         hasWritePermission : hasWrite,
         hasDeletePermission: hasDelete,
         hasAdminPermission : hasAdmin, max: params.max, userId: params.userId]
    }

    def create() {
    }

    def upload() {
        try {
            def file = request.getFile('file')
            Document document

            if (file.empty) {
                //flash.error = "Document can not be empty!"
                render "Error"
                //redirect (action: 'index')
            } else {
                Document.withTransaction {
                    String uuid
                    while (true) {
                        uuid = randomUUID() as String
                        File fileTest = new File(grailsApplication.config.uploadFolder + file.originalFilename + "_" + uuid);
                        if (!fileTest.exists())
                            break;
                    }
                    document = documentService.createDocument(file, grailsApplication.config.uploadFolder, uuid);
                }
                //flash.success = "File $document.filename has been succesfully uploaded"
                render(contentType: "application/json") {
                    [
                            "id": document.id
                    ]
                }
            }
        } catch (Exception e) {
            log.error "Error: ${e.message}", e
            render(status: 500, text: "Nastala chyba")
        }
    }

    def delete(long id) {
        def document = documentService.getById(id)
        documentService.delete(document, grailsApplication.config.uploadFolder)
        flash.success = "Súbor #$document.id - $document.filename bol zmazaný!"
        redirect(action: 'index')
    }

    def download(long id) {
        Document documentInstance = documentService.getById(id)
        if (documentInstance == null) {
            flash.error = "Document not found."
            redirect(action: 'list')
        } else {
            render(file: new File(grailsApplication.config.uploadFolder + documentInstance.path), fileName: documentInstance.filename, contentType: 'application/octet-stream')
        }
    }

    def description(long id) {
        Document documentInstance = documentService.getById(id)
        if (documentInstance == null) {
            flash.error = "Document not found."
            redirect(action: 'list')
        } else {
            documentService.addDescription(documentInstance, params.description)
        }

        render documentInstance as JSON
    }
}
