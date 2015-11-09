package form

class FormFieldValue {

    Date dateCreated
    Date lastUpdated

    String id_classifier
    String id_item
    List values

    static hasMany = [values: String]

    static constraints = {
    }
}
