component{

	function configure(){
		// Set Full Rewrites
		setFullRewrites( true );


		resources( resource="registration", only="new,create" );

		route( "rants/:id/bumps" )
			.withAction( { "POST" = "create", "DELETE" = "delete" } )
			.toHandler( "Bumps" );
		route( "rants/:id/poops" )
			.withAction( { "POST" = "create", "DELETE" = "delete" } )
			.toHandler( "Poops" );
		resources( "rants" );


		get( "/users/:username" ).to( "users.show" );
		/**
		 * --------------------------------------------------------------------------
		 * App Routes
		 * --------------------------------------------------------------------------
		 *
		 * Here is where you can register the routes for your web application!
		 * Go get Funky!
		 *
		 */

		// A nice healthcheck route example
		route("/healthcheck",function(event,rc,prc){
			return "Ok!";
		});

		// A nice RESTFul Route example
		route( "/api/echo", function( event, rc, prc ){
			return {
				"error" : false,
				"data" 	: "Welcome to my awesome API!"
			};
		} );

		route( "/login" )
			.withAction( { "POST" = "create", "GET" = "new" } )
			.toHandler( "sessions" );
		delete( "/logout" ).to( "sessions.delete" );

		// Conventions based routing
		route( ":handler/:action?" ).end();
	}

}