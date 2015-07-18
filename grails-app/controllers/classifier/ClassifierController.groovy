package classifier

import grails.plugin.springsecurity.annotation.Secured

@Secured(['ROLE_WORKER'])
class ClassifierController {
	def classifierService

    def updateAll() {
		classifierService.updateClassifiers()
		render "success"
	}
}
