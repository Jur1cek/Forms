package document

import user.User

class Document {
    static auditable = true

    Date dateCreated
    Date lastUpdated

    User creator
    String filename
    String path
    Long size
    String description
    String md5
    String sha1

    static constraints = {
        filename(blank: false, nullable: false)
        path(blank: false, nullable: false, unique: true)
        description nullable: true
    }
}
