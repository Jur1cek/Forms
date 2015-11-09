package classifier

import grails.plugin.springsecurity.annotation.Secured
import grails.transaction.Transactional

import static org.springframework.http.HttpStatus.*

@Secured(['ROLE_WORKER'])
@Transactional(readOnly = true)
class ClassifierLineController {

    static responseFormats = ['json', 'xml']
    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE", show: ["GET", "POST"]]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond ClassifierLine.list(params), [status: OK]
    }

    def show(String id) {

        Map filterFields = params.findAll {
            it.key.startsWith("filter_")
        }

        filterFields = filterFields.inject([:]) { map, v ->
            map << [(v.key - "filter_"): v.value]
        }

        println(filterFields)

        def c = ClassifierLine.createCriteria()
        def results = c.list {
            classifier {
                eq("classId", id)
            }
            filterFields.each { k, v ->
                classifierItems {
                    eq("name", k)
                    eq("value", v)
                }
            }
        }

        def result = query.find();

        def resultNew = []
        for (classifierLine in result) {
            def lineNew = [:]
            for (classifierItem in classifierLine.classifierItems) {
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
