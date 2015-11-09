package form

import user.User

class Form {
    static auditable = true

    Date dateCreated
    Date lastUpdated

    String name
    FormType type
    User creator
    List fieldsVersion = []
    List comments = []
    User updater
    ApprovalStatus status = ApprovalStatus.NONE

    static hasMany = [fieldsVersion: FormFieldsVersion, comments: Comment]

    enum ApprovalStatus {
        PENDING, APPROVED, REJECTED, NONE
    }
}
