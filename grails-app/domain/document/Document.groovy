package document

import collation.Collation
import user.User

class Document {
    static auditable = true

    User creator
    String filename
    String path
    Long size
    Date creationDate = new Date()
    String description
    String md5
    String sha1

    static hasMany = [collations: Collation]

    static belongsTo = Collation

    static constraints = {
        filename(blank: false, nullable: false)
        path(blank: false, nullable: false, unique: true)
        description nullable: true
    }
}
