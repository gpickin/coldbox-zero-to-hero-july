/**
* I am a new User Service
*/
component singleton accessors="true"{

	// To populate objects from data
    property name="populator" inject="wirebox:populator";
	// Properties
	property name="bcrypt" inject="Bcrypt@BCrypt";

	/**
	 * Constructor
	 */
	UserService function init(){

		return this;
	}

	function list(){
    	return queryExecute( "select * from users", {}, { returntype = "array" } );
	}

	/**
	 * Create a new user
	 *
	 * @user
	 *
	 * @return The created id of the user
	 */
	function create(
		required user
	){
		queryExecute(
			"
				INSERT INTO `users` ( `email`, `username`, `password` )
				VALUES ( ?, ?, ? )
			",
			[
				arguments.user.getEmail(),
				arguments.user.getUsername(),
				bcrypt.hashPassword( arguments.user.getPassword() )
			],
			{
				result : 'local.result'
			}
		);
		arguments.user.setID( local.result.generatedkey );
		return arguments.user;
	}

	User function new() provider="User";

	User function retrieveUserById( required id ) {
		return populator.populateFromQuery(
            new(),
            queryExecute( "SELECT * FROM `users` WHERE `id` = ?", [ arguments.id ] )
        );
    }

	User function retrieveUserByUsername( required username ) {
        return populator.populateFromQuery(
            new(),
            queryExecute( "SELECT * FROM `users` WHERE `username` = ?", [ arguments.username ] )
        );
    }

    boolean function isValidCredentials( required username, required password ) {
		var oUser = retrieveUserByUsername( arguments.username );
        if( !oUser.isLoaded() ){
            return false;
		}

		return bcrypt.checkPassword( arguments.password, oUser.getPassword() );
    }
}