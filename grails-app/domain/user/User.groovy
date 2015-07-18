package user

class User {
    static auditable = true

    transient springSecurityService
    static hasOne = [userProfile: UserProfile]

    String username
    String password
    boolean enabled = true
    boolean accountExpired
    boolean accountLocked
    boolean passwordExpired

    static hasMany = [children: User]
    static belongsTo = [parent: User]

    static transients = ['springSecurityService']

    static constraints = {
        username blank: false, unique: true
        password blank: false
        userProfile unique: true
        parent nullable: true
    }

    static mapping = {
        password column: '`password`'
    }

    Set<Role> getAuthorities() {
        UserRole.findAllByUser(this).collect { it.role }
    }

    def beforeInsert() {
        encodePassword()
    }

    def beforeUpdate() {
        if (isDirty('password')) {
            encodePassword()
        }
    }

    protected void encodePassword() {
        password = springSecurityService?.passwordEncoder ? springSecurityService.encodePassword(password) : password
    }
}
