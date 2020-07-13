/**
* I am a new handler
*/
component{

	property name="messagebox" inject="messageBox@cbmessagebox";

	/**
	* new
	*/
	function new( event, rc, prc ){
		event.setView( "sessions/new" );
	}

	/**
	* create
	*/
	function create( event, rc, prc ){
		try {
			auth().authenticate( rc.username ?: "", rc.password ?: "" );
			messagebox.success( "Welcome back #encodeForHTML( rc.username )#" );
			return relocate( uri = "/" );
		} catch ( InvalidCredentials e ) {
			messagebox.warn( e.message );
			return relocate( uri = "/login" );
		}
	}

	/**
	* delete
	*/
	function delete( event, rc, prc ){
		auth().logout();
		relocate( uri="/" );
	}



}
