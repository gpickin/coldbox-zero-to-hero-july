component accessors="true"{

	//DI
	property name="rantService" inject="RantService";
	property name="reactionService" inject="ReactionService";

	// Properties
	property name="id" type="string";
	property name="username" type="string";
	property name="email" type="string";
	property name="password" type="string";

	/**
	 * Constructor
	 */
	User function init(){

		return this;
    }

    boolean function isLoaded(){
		return ( !isNull( variables.id ) && len( variables.id ) );
	}

	function getRants(){
		return rantService.getForUserID( variables.id );
	}

	function hasBumped( rant ) {
		hasReacted( rant, "bump");
	}

	function hasPoop( rant ) {
		hasReacted( rant, "poop");
	}

	function hasReacted( rant, type ){
		if ( isNull( variables.bumps ) ) {
			variables.bumps = reactionService.getBumpsForUser( this );
		}
		return ! variables.bumps.filter( function( bump ) {
			return bump.getRantId() == rant.getId();
		} ).isEmpty();
	}

	function hasPooped( rant ) {
		if ( isNull( variables.poops ) ) {
			variables.poops = reactionService.getPoopsForUser( this );
		}
		return ! variables.poops.filter( function( poop ) {
			return poop.getRantId() == rant.getId();
		} ).isEmpty();
	}

}