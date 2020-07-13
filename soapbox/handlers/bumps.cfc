/**
* I am a new handler
*/
component{

	// DI
	property name="reactionService" inject="reactionService";

	/**
	* create
	*/
	function create( event, rc, prc ){
		reactionService.bump( rc.id, auth().getUserId() );
		return { "count": reactionService.getBumpCount( rc.id ) };
	}

	/**
	* delete
	*/
	function delete( event, rc, prc ){
        reactionService.unbump( rc.id, auth().getUserId() );
		return { "count": reactionService.getBumpCount( rc.id ) };
    }



}
