package collation



import grails.test.mixin.*
import spock.lang.*

@TestFor(CollationController)
@Mock(Collation)
class CollationControllerSpec extends Specification {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void "Test the index action returns the correct model"() {

        when:"The index action is executed"
            controller.index()

        then:"The model is correct"
            !model.collationInstanceList
            model.collationInstanceCount == 0
    }

    void "Test the create action returns the correct model"() {
        when:"The create action is executed"
            controller.create()

        then:"The model is correctly created"
            model.collationInstance!= null
    }

    void "Test the save action correctly persists an instance"() {

        when:"The save action is executed with an invalid instance"
            request.contentType = FORM_CONTENT_TYPE
            request.method = 'POST'
            def collation = new Collation()
            collation.validate()
            controller.save(collation)

        then:"The create view is rendered again with the correct model"
            model.collationInstance!= null
            view == 'create'

        when:"The save action is executed with a valid instance"
            response.reset()
            populateValidParams(params)
            collation = new Collation(params)

            controller.save(collation)

        then:"A redirect is issued to the update action"
            response.redirectedUrl == '/collation/update/1'
            controller.flash.message != null
            Collation.count() == 1
    }

    void "Test that the show action returns the correct model"() {
        when:"The update action is executed with a null domain"
            controller.update(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the update action"
            populateValidParams(params)
            def collation = new Collation(params)
            controller.update(collation)

        then:"A model is populated containing the domain instance"
            model.collationInstance == collation
    }

    void "Test that the edit action returns the correct model"() {
        when:"The edit action is executed with a null domain"
            controller.edit(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the edit action"
            populateValidParams(params)
            def collation = new Collation(params)
            controller.edit(collation)

        then:"A model is populated containing the domain instance"
            model.collationInstance == collation
    }

    void "Test the update action performs an update on a valid domain instance"() {
        when:"Update is called for a domain instance that doesn't exist"
            request.contentType = FORM_CONTENT_TYPE
            request.method = 'PUT'
            controller.update(null)

        then:"A 404 error is returned"
            response.redirectedUrl == '/collation/index'
            flash.message != null


        when:"An invalid domain instance is passed to the update action"
            response.reset()
            def collation = new Collation()
            collation.validate()
            controller.update(collation)

        then:"The edit view is rendered again with the invalid instance"
            view == 'edit'
            model.collationInstance == collation

        when:"A valid domain instance is passed to the update action"
            response.reset()
            populateValidParams(params)
            collation = new Collation(params).save(flush: true)
            controller.update(collation)

        then:"A redirect is issues to the update action"
            response.redirectedUrl == "/collation/update/$collation.id"
            flash.message != null
    }

    void "Test that the delete action deletes an instance if it exists"() {
        when:"The delete action is called for a null instance"
            request.contentType = FORM_CONTENT_TYPE
            request.method = 'DELETE'
            controller.delete(null)

        then:"A 404 is returned"
            response.redirectedUrl == '/collation/index'
            flash.message != null

        when:"A domain instance is created"
            response.reset()
            populateValidParams(params)
            def collation = new Collation(params).save(flush: true)

        then:"It exists"
            Collation.count() == 1

        when:"The domain instance is passed to the delete action"
            controller.delete(collation)

        then:"The instance is deleted"
            Collation.count() == 0
            response.redirectedUrl == '/collation/index'
            flash.message != null
    }
}
