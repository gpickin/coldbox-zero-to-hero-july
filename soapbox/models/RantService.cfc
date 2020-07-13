/**
* I manage rants
*/
component singleton accessors="true"{

	// Properties
	property name="populator" inject="wirebox:populator";


	/**
	 * Constructor
	 */
	RantService function init(){

		return this;
	}

	/**
	 * Provider of Rant objects
	 */
	Rant function new() provider="Rant"{}

	/**
	 * Get all rants
	 */
	array function getAll(){
		return queryExecute(
            "SELECT * FROM `rants` ORDER BY `createdDate` DESC",
            [],
            { returntype = "array" }
        ).map( function ( rant ) {
            return populator.populateFromStruct(
                new(),
                rant
            );
        } );
	}

	function getForUserID( required userId ) {
		return queryExecute(
			"SELECT * FROM `rants` WHERE `userId` = ? ORDER BY `createdDate` DESC",
			[ userId ],
			{ returntype = "array" }
		).map( function ( rant ) {
            return populator.populateFromStruct(
                new(),
                rant
            );
        } );
	}

	/**
	 * Create a rant
	 */
	function create( required rant ){
		rant.setModifiedDate( now() );
        queryExecute(
            "
                INSERT INTO `rants` (`body`, `createdDate`, `modifiedDate`, `userId`)
                VALUES (?, ?, ?, ?)
            ",
            [
                rant.getBody(),
				{ value = rant.getCreatedDate(), cfsqltype = "TIMESTAMP" },
				{ value = rant.getModifiedDate(), cfsqltype = "TIMESTAMP" },
                rant.getUserId()
            ],
            { result = "local.result" }
        );
        rant.setId( result.GENERATED_KEY );

		return rant;
	}


}