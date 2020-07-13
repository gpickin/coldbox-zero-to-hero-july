/**
* I am a new handler
*/
component{

	    property name="reactionService" inject="reactionService";


	function create( event, rc, prc ) {
        reactionService.poop( rc.id, auth().getUserId() );
        relocate( "rants" );
    }

    function delete( event, rc, prc ) {
        reactionService.unpoop( rc.id, auth().getUserId() );
        relocate( "rants" );
    }


}
