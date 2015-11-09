package forms

class ClassifiersJob {
    def classifierService

    static triggers = {
        cron name: 'Daily', cronExpression: "0 0 0 * * ?"
    }

    def execute() {
        classifierService.updateClassifiers()
    }
}
