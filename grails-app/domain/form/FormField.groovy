package form

/**
 * Created by Jur1cek on 28/06/15.
 */
class FormField {
    static searchable = true

    Date dateCreated
    Date lastUpdated

    String name
    List values

    static belongsTo = [fieldsVersion: FormFieldsVersion]

    static hasMany = [values: FormFieldValue]

    static constraints = {
        values nullable: true
    }

    static mapping = {
    }

    @Override
    String toString() {
        // TODO check
        return values.toArray()
    }
}
