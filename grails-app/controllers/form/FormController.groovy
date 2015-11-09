package form

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured
import org.springframework.security.acls.model.Permission

import static org.springframework.security.acls.domain.BasePermission.*

@Secured(['ROLE_WORKER'])
class FormController {

    static allowedMethods = [delete: 'DELETE', save: 'POST', comment: ['POST', 'GET']]


    def aclPermissionFactory
    def aclUtilService
    def springSecurityService

    def wkhtmltoxService

    def formService
    def formTypeService
    def userService

    private static final Permission[] HAS_WRITE = [WRITE, ADMINISTRATION]
    private static final Permission[] HAS_DELETE = [DELETE, ADMINISTRATION]
    private static final Permission[] HAS_ADMIN = [ADMINISTRATION]

    def getFormsJSON() {
        def datatableMap = [:]

        try {
            def data = []
            def columns = [:]

            columns.put("0", [null, null]) // nothing
            columns.put("1", ["id", Long.class])
            columns.put("2", ["name", String.class])
            columns.put("3", ["type.shortcut", String.class])
            columns.put("4", ["creationDate", Date.class])
            columns.put("5", ["creatorProfile.name", String.class])
            columns.put("6", ["updateDate", Date.class])
            columns.put("7", ["updaterProfile.name", String.class])
            columns.put("8", ["version", Long.class])
            columns.put("9", [null, null]) // nothing
            columns.put("", [null, null])
            columns.put(null, [null, null])

            /*def c = Form.createCriteria()
            def results = c.list(max: params.long('length'), offset: params.long('start')) {
                createAlias('type', 'type')
                createAlias('creator', 'creator')
                createAlias('updater', 'updater')
                createAlias('creator.userProfile', 'creatorProfile')
                createAlias('updater.userProfile', 'updaterProfile')

                (0..9).each { i ->
                    if (params."columns[$i][search][value]".isEmpty())
                        return

                    def column = columns.get(params."columns[$i][data]")[0]
                    def columnClass = columns.get(params."columns[$i][data]")[1]
                    def value = params."columns[$i][search][value]".split('-yadcf_delim-');

                    if (columnClass == String.class)
                        ilike(column, "%" + value[0] + "%")
                    else if (columnClass == Date.class) {
                        try {
                            lte(column, new Date(value[1]))
                        } catch (Exception e) {
                        }
                        try {
                            gte(column, new Date(value[0]))
                        } catch (Exception e) {
                        }
                    } else if (columnClass == Long.class) {
                        try {
                            lte(column, value[1].toLong())
                        } catch (Exception e) {
                        }
                        try {
                            gte(column, value[0].toLong())
                        }
                        catch (Exception e) {
                        }
                    }
                }

                (0..9).each { i ->
                    def column = columns.get(params."order[$i][column]")[0]
                    def dir = params."order[$i][dir]"

                    if (column != null && dir != null)
                        order(column, dir)
                }
            }*/

            def results
            def formCount
            if (params.userId) {
                def user = userService.getById(params.long('userId'))
                results = formService.getAll(user, params)
                formCount = formService.getAll(user).size()
            } else {
                results = formService.getAll(params)
                formCount = formService.getAll().size()
            }

            results.each { Form form ->
                def creationDate = g.formatDate(date: form.creationDate, format: 'yyyy-MM-dd HH:mm:ss')
                def updateDate = g.formatDate(date: form.updateDate, format: 'yyyy-MM-dd HH:mm:ss')

                def version = form.fieldsVersion.size() - 1;
                def row1_label
                def row1_data
                def row2_label
                def row2_data
                def row3_label
                def row3_data
                def row4_label
                def row4_data

                if (form.type.shortcut == "VPCH") {
                    row1_label = 'I.1 Priezvisko, meno, tituly'
                    row1_data = form?.fieldsVersion?.getAt(version)?.fields?.form_meno?.values
                    row2_label = 'I.2 Rok narodenia'
                    row2_data = form?.fieldsVersion?.getAt(version)?.fields?.form_rok_narodenia?.values
                    row3_label = 'I.3 Názov a adresa pracoviska'
                    row3_data = form?.fieldsVersion?.getAt(version)?.fields?.form_pracovisko?.values
                    row4_label = 'I.4 E-mailová adresa'
                    row4_data = form?.fieldsVersion?.getAt(version)?.fields?.form_email?.values
                } else if (form.type.shortcut == "IL") {
                    row1_label = 'Vysoká škola'
                    row1_data = form?.fieldsVersion?.getAt(version)?.fields?.form_vysoka_skola?.values
                    row2_label = 'Fakulta'
                    row2_data = form?.fieldsVersion?.getAt(version)?.fields?.form_fakulta?.values
                    row3_label = 'Kód predmetu'
                    row3_data = form?.fieldsVersion?.getAt(version)?.fields?.form_kod_predmetu_1?.values
                    row4_label = 'Názov predmetu'
                    row4_data = form?.fieldsVersion?.getAt(version)?.fields?.form_nazov_predmetu_1?.values
                }

                def row = [:]
                row << [id: form.id, name: form.name, type: form.type.shortcut, creationDate: creationDate, creator: form.creator.userProfile.name, updateDate: updateDate, updater: form.updater.userProfile.name, version: form.version + 1, status: form.status.toString()]
                row << [row1_label: row1_label, row1_data: row1_data, row2_label: row2_label, row2_data: row2_data, row3_label: row3_label, row3_data: row3_data, row4_label: row4_label, row4_data: row4_data]
                row << [creator_id: form.creator.id]
                row << [updater_id: form.updater.id]

                data << row
            }

            datatableMap.put("draw", params.draw)
            datatableMap.put("recordsTotal", formCount)
            datatableMap.put("recordsFiltered", results.size())
            datatableMap.put("data", data);
            //datatableMap.put("error", error)
        } catch (Exception e) {
            e.printStackTrace();
            datatableMap.put("error", "Nastala chyba");
        }

        render datatableMap as JSON
    }

    def getFormXml(long id) {
        def form = formService.getById(id)

        if (!form) {
            response.sendError(404)
            return
        }

        def version
        if (!params.version) {
            version = form.fieldsVersion.size() - 1
        } else {
            version = params.int('version') - 1
        }


        def xml = formService.getFormAsXml(form, version)

        response.setContentType("application/octet-stream") // or or image/JPEG or text/xml or whatever type the file is
        response.setHeader("Content-disposition", "attachment;filename=\"${form.id}.xml\"")
        response.setCharacterEncoding("UTF-8")
        response.outputStream << xml.bytes
    }

    def list_test() {
    }

    def index() {
        if (!params?.max) {
            params.max = 10
        }

        List<Form> allForms
        int formCount

        if (params.userId) {
            def user = userService.getById(params.long('userId'))
            allForms = formService.getAll(user, params)
            formCount = formService.getAll(user).size()
        } else {
            allForms = formService.getAll(params)
            formCount = formService.getAll().size()
        }

        Map<Form, Boolean> hasWrite = [:]
        Map<Form, Boolean> hasDelete = [:]
        Map<Form, Boolean> hasAdmin = [:]

        def currentAuth = springSecurityService.authentication
        for (Form form : allForms) {
            hasWrite[form] = aclUtilService.hasPermission(currentAuth, form, HAS_WRITE)
            hasDelete[form] = aclUtilService.hasPermission(currentAuth, form, HAS_DELETE)
            hasAdmin[form] = aclUtilService.hasPermission(currentAuth, form, HAS_ADMIN)
        }

        [forms              : allForms, formCount: formCount,
         hasWritePermission : hasWrite,
         hasDeletePermission: hasDelete,
         hasAdminPermission : hasAdmin, max: params.max, userId: params.userId]
    }

    def save() {
        Form form

        if (params.button_startApproval || params.button_stopApproval || params.button_approve || params.button_reject) {
            try {
                form = formService.getById(params.long('formId'))
                if (params.button_startApproval) {
                    formService.startApproval(form)
                    flash.success = "Formulár bol odoslaný na schválenie"
                } else if (params.button_stopApproval) {
                    formService.stopApproval(form)
                    flash.success = "Źiadosť o schválenie formuláru bola zrušená"
                } else if (params.button_approve) {
                    formService.approve(form)
                    flash.success = "Formulár bol schválený"
                } else if (params.button_reject) {
                    formService.reject(form)
                    flash.success = "Formulár bol zamietnutý"
                }
            } catch (Exception e) {
                log.error(e)
                flash.error = "Nastala chyba, kontaktujte administrátora"
            }
        } else if (params.button_save) {
            Map fields = params.findAll {
                it.key.startsWith("form_")
            }

            try {
                if (params.formId) {
                    form = formService.getById(params.long('formId'))
                    formService.updateForm(form, params.name, fields)
                } else {
                    form = formService.createForm(params.type, params.name, fields)
                }

                flash.success = "Vytvorená verzia " + form.fieldsVersion.size()
            } catch (Exception e) {
                flash.error = "Nastala chyba, kontaktujte administrátora"
                log.error(e)
            }
        }

        redirect(action: "update", id: form.id)
    }

    def update(long id) {
        def form = formService.getById(id)
        def currentUser = springSecurityService.currentUser

        if (!form) {
            response.sendError(404)
            return
        }

        def version
        if (!params.version) {
            version = form.fieldsVersion.size() - 1
        } else {
            version = params.int('version') - 1
        }

        render(view: form.type.view, model: [form: form, version: version, currentUser: currentUser])
    }

    def delete(long id) {
        try {
            Form form = formService.getById(id)
            formService.delete(form)
            flash.success = "Vymazaný formulár #$form.id - $form.name"
        } catch (Exception e) {
            flash.error = "Nastala chyba, formulár nebol vymazaný"
        }

        redirect(action: "index")
    }

    def versions() {
        Form form = formService.getById(params.long('id'))

        if (!form) {
            response.sendError(404)
            return
        }

        form.fieldsVersion = form.fieldsVersion.reverse()

        [form: form]
    }

    def types() {
        def allTypes = formTypeService.getAll(false)

        render(template: 'types', model: [types: allTypes])
    }

    def create(Long id) {
        def formType = formTypeService.getById(id)
        def user = springSecurityService.currentUser

        if (!formType) {
            response.sendError(404)
            return
        }

        render(view: formType.view, model: [type: formType.id, user: user])
    }

    def exportXml(long id) {
        def form = formService.getById(id)

        if (!form) {
            response.sendError(404)
            return
        }

        def version
        if (!params.version) {
            version = form.fieldsVersion.size() - 1
        } else {
            version = params.int('version') - 1
        }

        render(view: "${form.type.view}_export_xml", model: [form: form, version: version], fileName: "${form.id}.xml", contentType: "application/octet-stream")
    }

    def exportHtml(long id) {
        def form = formService.getById(id)

        if (!form) {
            response.sendError(404)
            return
        }

        def version
        if (!params.version) {
            version = form.fieldsVersion.size() - 1
        } else {
            version = params.int('version') - 1
        }

        render(view: "${form.type.view}_export_html", model: [form: form, version: version])
    }

    def exportPdf(long id) {
        def form = formService.getById(id)

        if (!form) {
            response.sendError(404)
            return
        }

        def version
        if (!params.version) {
            version = form.fieldsVersion.size() - 1
        } else {
            version = params.int('version') - 1
        }


        render(filename: "${form.id}-${form.name}.pdf",
                view: "${form.type.view}_export_html",
                model: [form: form, version: version],
                marginLeft: 10,
                marginTop: 10,
                marginBottom: 10,
                marginRight: 10)
    }

    def search() {
    }

    def approve(long id) {
        def form = formService.getById(id)

        if (!form) {
            response.sendError(404)
            return
        }

        formService.approve(form)
    }

    def reject(long id) {
        def form = formService.getById(id)

        if (!form) {
            response.sendError(404)
            return
        }

        formService.reject(form)
    }

    def startApproval(long id) {
        def form = formService.getById(id)

        if (!form) {
            response.sendError(404)
            return
        }

        formService.startApproval(form)
    }

    def stopApproval(long id) {
        def form = formService.getById(id)

        if (!form) {
            response.sendError(404)
            return
        }

        formService.stopApproval(form)
    }

    def comment(long id) {
        def form = formService.getById(id)

        if (!form) {
            response.sendError(404)
            return
        }
        if (request.method == 'POST') {
            formService.addComment(form, params.comment)
        }

        render(template: "comments", var: "comment", collection: form.comments.reverse(false))
    }
}
