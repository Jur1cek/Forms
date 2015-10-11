package classifier

class ClassifierItem {
    String name
    String value

    static belongsTo = [classifierLine: ClassifierLine]

    static constraints = {
        value nullable: true
        name nullable: true
    }
}

