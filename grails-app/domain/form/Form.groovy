package form

import user.User

class Form {
    static auditable = true

    String name
    FormType type
    User creator
    List fieldsVersion = []
    List comments = []
    Date creationDate = new Date()
    Date updateDate = new Date()
    User updater
    ApprovalStatus status = ApprovalStatus.NONE

    static hasMany = [fieldsVersion: FormFieldsVersion, comments: Comment]

    enum ApprovalStatus {
        PENDING, APPROVED, REJECTED, NONE
    }
}
