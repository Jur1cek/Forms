package classifier

class Classifier {
    String classId
    String name
    List lines

    static hasMany = [lines: ClassifierLine]

    static constraints = { classId(unique: true) }
}
