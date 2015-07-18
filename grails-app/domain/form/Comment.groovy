package form

import user.User

class Comment {
    User creator
    String text
    Date date = new Date()

    static belongsTo = [form: Form]

    static constraints = {
    }

    static mapping = {
        text type: "text"
    }
}
