package user

class UserProfile {

    Date dateCreated
    Date lastUpdated

    String name
    String university
    String faculty
    String email
    String comment

    static belongsTo = [user: User]

    static constraints = {
        name nullable: true
        university nullable: true
        faculty nullable: true
        email nullable: true
        comment nullable: true
    }

    def university() {
        if (university.isEmpty())
            user.parent.userProfile.university
    }

    def faculty() {
        if (faculty.isEmpty())
            user.parent.userProfile.faculty
    }
}
