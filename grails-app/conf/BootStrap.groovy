import form.FormType
import org.springframework.security.acls.domain.BasePermission
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken
import org.springframework.security.core.authority.AuthorityUtils
import org.springframework.security.core.context.SecurityContextHolder as SCH
import user.Role
import user.User
import user.UserProfile
import user.UserRole

class BootStrap {

    def aclUtilService

    def init = { servletContext ->
        def adminRole = new Role(authority: 'ROLE_ADMIN').save(flush: true)
        def userRole = new Role(authority: 'ROLE_USER').save(flush: true)
        def universityRole = new Role(authority: 'ROLE_UNIVERSITY').save(flush: true)
        def facultyRole = new Role(authority: 'ROLE_FACULTY').save(flush: true)
        def workerRole = new Role(authority: 'ROLE_WORKER').save(flush: true)
        def specialRole = new Role(authority: 'ROLE_SPECIAL').save(flush: true)

        def adminUser = new User(username: 'admin', password: 'adminPassword', userProfile: new UserProfile(name: 'Admin Adminovič'))
        adminUser.save(flush: true)
        UserRole.create adminUser, adminRole, true

        def userUser = new User(username: 'user', password: 'userPassword', userProfile: new UserProfile(name: 'User Userovič'))
        userUser.save(flush: true)
        UserRole.create userUser, userRole, true

        SCH.context.authentication = new UsernamePasswordAuthenticationToken('admin', 'adminPassword',
                AuthorityUtils.createAuthorityList('ROLE_IGNORED'))

        aclUtilService.addPermission User, adminUser.id, adminUser.username, BasePermission.ADMINISTRATION
        aclUtilService.addPermission User, userUser.id, adminUser.username, BasePermission.ADMINISTRATION
        aclUtilService.addPermission User, userUser.id, userUser.username, BasePermission.WRITE
        aclUtilService.addPermission User, userUser.id, userUser.username, BasePermission.READ

        def il = new FormType(view: "il", name: "Informačný list predmetu", shortcut: "IL", collationMain: false).save(flush: true)
        def vpch = new FormType(view: "vpch", name: "Vedecko-pedagogická alebo umelecko-pedagogická charakteristika fyzickej osoby", shortcut: "VPCH", collationMain: false).save(flush: true)
        def form_2a = new FormType(view: "2a", name: "2a - Formulár k žiadosti o vyjadrenie o spôsobilosti vysokej školy uskutočňovať študijný program oprávňujúci udeliť jeho absolventom akademický titul", shortcut: "2a", collationMain: true).save(flush: true)
        def form_2b = new FormType(view: "2b", name: "2b - Formulár k žiadosti o vyjadrenie o spôsobilosti nevysokoškolskej inštitúcie podieľať sa na uskutočňovaní doktorandského študijného programu", shortcut: "2b", collationMain: true).save(flush: true)
        def form_2c = new FormType(view: "2c", name: "2c - Formulár k žiadosti o vyjadrenie o spôsobilosti vysokej školy uskutočňovať habilitačné konanie a konanie na vymenúvanie profesorov", shortcut: "2c", collationMain: true).save(flush: true)

        aclUtilService.addPermission FormType, il.id, adminUser.username, BasePermission.ADMINISTRATION
        aclUtilService.addPermission FormType, vpch.id, adminUser.username, BasePermission.ADMINISTRATION
        aclUtilService.addPermission FormType, form_2a.id, adminUser.username, BasePermission.ADMINISTRATION
        aclUtilService.addPermission FormType, form_2b.id, adminUser.username, BasePermission.ADMINISTRATION
        aclUtilService.addPermission FormType, form_2c.id, adminUser.username, BasePermission.ADMINISTRATION

        aclUtilService.addPermission FormType, vpch.id, userUser.username, BasePermission.CREATE
    }
    def destroy = {
    }
}
