package form

/**
 * Created by Jur1cek on 28/06/15.
 */
class FormField {
    static searchable = true

    String id_classifier
    String id_item
    String value

    static belongsTo = [fieldsVersion: FormFieldsVersion]

    static constraints = {
        id_classifier nullable: true
        id_item nullable: true
        value nullable: true
    }

    static mapping = {
        value type: "text"
    }
}
