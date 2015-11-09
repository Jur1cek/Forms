package form

import user.User

class Comment {
    Date dateCreated
    Date lastUpdated

    User creator
    String text

    static belongsTo = [form: Form]

    static constraints = {
    }

    static mapping = {
        text type: "text"
    }
}
