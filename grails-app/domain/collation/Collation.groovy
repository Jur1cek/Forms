package collation

import document.Document
import form.Form
import user.User

class Collation {
    static auditable = true

    String name
    User creator
    Form mainForm
    Date creationDate = new Date()
    Date updateDate = new Date()
    User updater

    static hasMany = [forms: Form, documents: Document]

    static constraints = {
    }
}
