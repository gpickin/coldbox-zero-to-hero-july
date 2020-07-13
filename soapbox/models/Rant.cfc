/**
* I model a rants
*/
component accessors="true"{

	// DI
	property name="userService" inject="UserService";
	property name="reactionService" inject="ReactionService";


	// Properties
	property name="id"           type="string" default = "";
	property name="body"         type="string" default = "";
	property name="createdDate"  type="date";
	property name="modifiedDate" type="date";
	property name="userID"       type="string" default = "";

	/**
	 * Constructor
	 */
	Rant function init(){
		variables.createdDate = now();
		return this;
	}

	/**
	* getUser
	*/
	function getUser(){
		// Lazy loading the relationship
		return userService.retrieveUserById( getuserId() );
	}

	function getBumps() {
		return reactionService.getBumpsForRant( this );
	}

	function getPoops() {
		return reactionService.getPoopsForRant( this );
	}

	function getBumpsAsArrayOfStructs() {
		return reactionService.getBumpsForRantArrayOfStructs( this );
	}

	function getPoopsAsArrayOfStructs() {
		return reactionService.getPoopsForRantArrayOfStructs( this );
	}

	function getBumpCount() {
		return reactionService.getBumpCount( this );
	}

	function getPoopCount() {
		return reactionService.getPoopCount( this );
	}


	/**
	* isLoaded
	*/
	boolean function isLoaded(){
		return( !isNull( variables.id ) && len( variables.id ) );
	}


}