/**
* I am a new handler
*/
component{

	// DI
	property name="userService" inject="UserService";

	/**
	* show
	*/
	function show( event, rc, prc ){
		prc.user = userService.retrieveUserByUsername( rc.username );
		if ( !prc.user.isLoaded() ) {
			// Go to the 404 page
			relocate( "404" );
		}
		event.setView( "users/show" );
	}



}
