package classifier

class ClassifierLine {
    List classifierItem

    static hasMany = [classifierItem: ClassifierItem]
    static belongsTo = [classifier: Classifier]

    static constraints = {
    }
}
