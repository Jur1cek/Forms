package classifier

class ClassifierLine {
    List classifierItems

    static hasMany = [classifierItems: ClassifierItem]
    static belongsTo = [classifier: Classifier]

    static constraints = {
    }
}
