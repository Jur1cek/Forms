package form

import user.User

class FormFieldsVersion {
    Date dateCreated
    Date lastUpdated

    User creator
    Map fields = [:]

    static hasMany = [fields: FormField]

    static belongsTo = [form: Form]

    static constraints = {
    }
}
