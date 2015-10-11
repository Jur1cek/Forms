package classifier

import grails.plugin.springsecurity.annotation.Secured
import grails.transaction.Transactional

import static org.springframework.http.HttpStatus.*

@Secured(['ROLE_WORKER'])
@Transactional(readOnly = true)
class ClassifierLineController {

    static responseFormats = ['json']
    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE", show: ["GET", "POST"]]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond ClassifierLine.list(params), [status: OK]
    }

    def show(String id) {

        def criteria = ClassifierLine.createCriteria()
        List<ClassifierLine> result = criteria.list(params) {
            classifier {
                eq("classId", id)
            }
            if (params.name) {
                classifierItem {
                    eq("name", params.name)
                    eq("value", params.value)
                }
            }
        }

        def resultNew = []
        for (classifierLine in result) {
            def lineNew = [:]
            for (classifierItem in classifierLine.classifierItem) {
                if (classifierItem.name == "code") {
                    lineNew.put("value", classifierItem.value)
                } else if (classifierItem.name == "name") {
                    lineNew.put("label", classifierItem.value)
                }
            }
            resultNew << lineNew
        }

        respond resultNew
    }

    @Transactional
    def save(ClassifierLine classifierLineInstance) {
        if (classifierLineInstance == null) {
            render status: NOT_FOUND
            return
        }

        classifierLineInstance.validate()
        if (classifierLineInstance.hasErrors()) {
            render status: NOT_ACCEPTABLE
            return
        }

        classifierLineInstance.save flush: true
        respond classifierLineInstance, [status: CREATED]
    }

    @Transactional
    def update(ClassifierLine classifierLineInstance) {
        if (classifierLineInstance == null) {
            render status: NOT_FOUND
            return
        }

        classifierLineInstance.validate()
        if (classifierLineInstance.hasErrors()) {
            render status: NOT_ACCEPTABLE
            return
        }

        classifierLineInstance.save flush: true
        respond classifierLineInstance, [status: OK]
    }

    @Transactional
    def delete(ClassifierLine classifierLineInstance) {

        if (classifierLineInstance == null) {
            render status: NOT_FOUND
            return
        }

        classifierLineInstance.delete flush: true
        render status: NO_CONTENT
    }
}
