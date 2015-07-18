package collation

import document.Document
import form.Form
import form.FormType
import grails.plugin.springsecurity.annotation.Secured
import org.springframework.security.acls.model.Permission

import java.util.zip.ZipEntry
import java.util.zip.ZipOutputStream

import static org.springframework.security.acls.domain.BasePermission.*

@Secured(['ROLE_WORKER'])
class CollationController {
    static allowedMethods = [delete: 'DELETE', save: 'POST']

    def aclPermissionFactory
    def aclUtilService
    def springSecurityService

    def collationService
    def formService
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

        List<Collation> allCollations
        int collationCount

        if (params.userId) {
            def user = userService.getById(params.long('userId'))
            allCollations = collationService.getAll(user, params)
            collationCount = collationService.getAll(user).size()
        } else {
            allCollations = collationService.getAll(params)
            collationCount = collationService.getAll().size()
        }

        Map<Collation, Boolean> hasRead = [:]
        Map<Collation, Boolean> hasWrite = [:]
        Map<Collation, Boolean> hasDelete = [:]
        Map<Collation, Boolean> hasAdmin = [:]

        def currentAuth = springSecurityService.authentication
        for (Collation collation : allCollations) {
            hasRead[collation] = aclUtilService.hasPermission(currentAuth, collation, HAS_READ)
            hasWrite[collation] = aclUtilService.hasPermission(currentAuth, collation, HAS_WRITE)
            hasDelete[collation] = aclUtilService.hasPermission(currentAuth, collation, HAS_DELETE)
            hasAdmin[collation] = aclUtilService.hasPermission(currentAuth, collation, HAS_ADMIN)
        }

        [collations         : allCollations, collationCount: collationCount,
         hasWriteRead       : hasRead,
         hasWritePermission : hasWrite,
         hasDeletePermission: hasDelete,
         hasAdminPermission : hasAdmin, max: params.max, userId: params.userId]
    }

    def getZip(long id) {
        def collation = collationService.getById(id)

        String zipFileName = "file.zip"

        FileOutputStream fos = new FileOutputStream(zipFileName);
        ZipOutputStream zipFile = new ZipOutputStream(fos)

        zipFile.putNextEntry(new ZipEntry(collation.mainForm.id + "-" + collation.mainForm.name + ".xml"))
        zipFile << formService.getFormAsXml(collation.mainForm, collation.mainForm.fields.size() - 1).bytes
        zipFile.closeEntry()

        collation.forms.each { Form form ->
            zipFile.putNextEntry(new ZipEntry("formulare/" + form.id + "-" + form.name + ".xml"))
            zipFile << formService.getFormAsXml(form, form.fields.size() - 1).bytes
            zipFile.closeEntry()
        }

        collation.documents.each { Document document ->
            zipFile.putNextEntry(new ZipEntry("prilohy/" + document.id + "-" + document.filename))
            zipFile << new File(grailsApplication.config.uploadFolder + document.path).bytes
            zipFile.closeEntry()
        }

        zipFile.close()

        response.setContentType("application/octet-stream") // or or image/JPEG or text/xml or whatever type the file is
        response.setHeader("Content-disposition", "attachment;filename=\"${collation.id}.zip\"")
        response.outputStream << new File(zipFileName).bytes
    }

    def create() {
        def forms = formService.getAll()
        def documents = documentService.getAll()

        def types = FormType.findAllByCollationMain(true)
        def mainForms = []
        for (FormType type : types) {
            mainForms.addAll(formService.getAll(type))
        }
        //TODO mainForms
        render(view: "update", model: [mainForms: forms, forms: forms, documents: documents])
    }

    def delete(long id) {
        try {
            Collation collation = collationService.getById(id)
            collationService.delete(collation)
            flash.success = "Vymazaná žiadosť #$collation.id - $collation.name"
        } catch (Exception e) {
            flash.error = "Nastala chyba, žiadosť nebola vymazaná"
        }

        redirect(action: "index")
    }

    def update(long id) {
        def collation = collationService.getById(id)
        def forms = formService.getAll()
        def documents = documentService.getAll()

        def types = FormType.findAllByCollationMain(true)
        def mainForms = []
        for (FormType type : types) {
            mainForms.addAll(formService.getAll(type))
        }
        //TODO mainForms
        [collation: collation, mainForms: forms, forms: forms, documents: documents]
    }

    def save() {
        Collation collation
        try {
            if (params.collationId) {
                collation = collationService.getById(params.long('collationId'))
                collationService.updateCollation(collation, params.long('mainForm'), params.name, params.documents as List, params.forms as List)
                flash.success = "Žiadosť bola aktualizovaná"
            } else {
                collation = collationService.createCollation(params.long('mainForm'), params.name, params.documents as List, params.forms as List)
                flash.success = "Žiadosť bola vytvorená"
            }
        } catch (Exception e) {
            flash.error = "Nastala chyba, kontaktuje administrátora"
            log.error(e)
        }

        redirect(action: "index")
    }
}
