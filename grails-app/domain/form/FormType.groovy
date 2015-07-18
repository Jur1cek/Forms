package form

class FormType {
	String view
	String name
	String shortcut
	boolean collationMain
	
    static constraints = {
		view blank: false, unique: true
		name blank: false
		shortcut blank: false
    }
}
