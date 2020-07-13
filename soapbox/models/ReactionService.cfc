/**
* I am a new Model Object
*/
component accessors="true"{

	//DI
	property name="populator" inject="wirebox:populator";

	// Properties


	function newBump() provider="Bump";
    function newPoop() provider="Poop";

	/**
	 * Constructor
	 */
	ReactionService function init(){

		return this;
	}

	/**
	* getBumpCount
	*/
	function getBumpCount( required rant ){
		var rantID = 0;
		if( isNumeric( rant ) ){
			rantID = rant
		} else {
			rantID = arguments.rant.getId();
		}
		return queryExecute(
            "SELECT count(rantId) as theCount FROM `bumps` WHERE `rantId` = ?",
            [ rantID ],
            { returntype = "array" }
        )[1]["theCount"]
	}

	/**
	* getBumpsForRant
	*/
	function getBumpsForRantArrayOfStructs( required rant ){
		return queryExecute(
            "SELECT * FROM `bumps` WHERE `rantId` = ?",
            [ arguments.rant.getId() ],
            { returntype = "array" }
        )
	}


	/**
	* getBumpsForRant
	*/
	function getBumpsForRant( required rant ){
		return getBumpsForRantArrayOfStructs()
		.map( function( bump ) {
            return populator.populateFromStruct(
                newBump(),
                bump
            )
        } );
	}


	/**
	* getPoopCount
	*/
	function getPoopCount( required rant ){
		return queryExecute(
            "SELECT count(rantId) as theCount FROM `poops` WHERE `rantId` = ?",
            [ arguments.rant.getId() ],
            { returntype = "array" }
        )[1]["theCount"]
	}


	/**
	* getPoopsForRant
	*/
	function getPoopsForRant( required rant ){
		return getPoopsForRantArrayOfStructs()
		.map( function( poop ) {
            return populator.populateFromStruct(
                newPoop(),
                poop
            )
        } );
	}

	/**
	* getBumpsForRant
	*/
	function getPoopsForRantArrayOfStructs( required rant ){
		return queryExecute(
            "SELECT * FROM `poops` WHERE `rantId` = ?",
            [ arguments.rant.getId() ],
            { returntype = "array" }
        )
	}



	function getBumpsForUser( user ) {
		return queryExecute(
			"SELECT * FROM `bumps` WHERE `userId` = ?",
			[ user.getId() ],
			{ returntype = "array" }
		).map( function( bump ) {
			return populator.populateFromStruct(
				newBump(),
				bump
			)
		} );
	}

	function getPoopsForUser( user ) {
		return queryExecute(
			"SELECT * FROM `poops` WHERE `userId` = ?",
			[ user.getId() ],
			{ returntype = "array" }
		).map( function( poop ) {
			return populator.populateFromStruct(
				newPoop(),
				poop
			)
		} );
	}

	// models/services/ReactionService.cfc
		function bump( rantId, userId ) {
			queryExecute(
				"INSERT INTO `bumps` VALUES (?, ?)",
				[ userId, rantId ]
			);
		}

		function unbump( rantId, userId ) {
			queryExecute(
				"DELETE FROM `bumps` WHERE `userId` = ? AND `rantId` = ?",
				[ userId, rantId ]
			);
		}

		function poop( rantId, userId ) {
			queryExecute(
				"INSERT INTO `poops` VALUES (?, ?)",
				[ userId, rantId ]
			);
		}

		function unpoop( rantId, userId ) {
			queryExecute(
				"DELETE FROM `poops` WHERE `userId` = ? AND `rantId` = ?",
				[ userId, rantId ]
			);
		}

}