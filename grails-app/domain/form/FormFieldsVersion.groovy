package form

import user.User

class FormFieldsVersion {
    Date date = new Date()
    User creator
    Map fields = [:]

    static hasMany = [fields: FormField]

    static belongsTo = [form: Form]

    static constraints = {
    }
}
