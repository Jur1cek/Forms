package classifier

import grails.plugin.springsecurity.annotation.Secured

@Secured(['ROLE_ADMIN'])
class ClassifierController {
    def classifierService

    def updateAll() {
        classifierService.updateClassifiers()
        render "success"
    }
}
