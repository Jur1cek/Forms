package classifier

class Classifier {
    String classId
    String name
    Map items = [:]

    static constraints = { classId(unique: true) }
}
