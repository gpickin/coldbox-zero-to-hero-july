/*******************************************************************************
*	Integration Test as BDD (CF10+ or Railo 4.1 Plus)
*
*	Extends the integration class: coldbox.system.testing.BaseTestCase
*
*	so you can test your ColdBox application headlessly. The 'appMapping' points by default to
*	the '/root' mapping created in the test folder Application.cfc.  Please note that this
*	Application.cfc must mimic the real one in your root, including ORM settings if needed.
*
*	The 'execute()' method is used to execute a ColdBox event, with the following arguments
*	* event : the name of the event
*	* private : if the event is private or not
*	* prePostExempt : if the event needs to be exempt of pre post interceptors
*	* eventArguments : The struct of args to pass to the event
*	* renderResults : Render back the results of the event
*******************************************************************************/
component extends="tests.resources.BaseIntegrationSpec" appMapping="/"{

	property name="query" inject="provider:QueryBuilder@qb";


	/*********************************** LIFE CYCLE Methods ***********************************/

	function beforeAll(){
		super.beforeAll();
		// do your own stuff here
	}

	function afterAll(){
		// do your own stuff here
		super.afterAll();
	}

	/*********************************** BDD SUITES ***********************************/

	function run(){

		describe( "registration Suite", function(){

			beforeEach(function( currentSpec ){
				// Setup as a new ColdBox request for this suite, VERY IMPORTANT. ELSE EVERYTHING LOOKS LIKE THE SAME REQUEST.
				setup();
			});

			it( "new", function(){
				var event = get( route="registration.new", params={} );
				// expectations go here.
				expect( event.getRenderedContent() ).toInclude( "Register for SoapBox" );
			});

			story( "I want to register users", function(){
				given( "valid data", function(){
					then( "I should register a new user", function() {
						expect(
							queryExecute(
								"select * from users where username = :username",
								{ username : "testadmin" },
								{ returntype = "array" }
							)
						).toBeEmpty();

						var event = POST( "/registration", {
							username : "testadmin",
							email : "testadmin@test.com",
							password : "password",
							passwordConfirmation : "password"
						} );

						// expectations go here.
						expect( event.getValue( "relocate_URI" ) ).toBe( "/" );

						expect(
							queryExecute(
								"select * from users where username = :username",
								{ username : "testadmin" },
								{ returntype = "array" }
							)
						).notToBeEmpty();

					});
				});

				xgiven( "invalid registration data", function(){
					then( "I should show a validation error", function() {
						fail( "implement" );
					})
				});

				xgiven( "a non-unique email", function(){
					then( "I should show a validation error", function() {
						fail( "implement" );
					})
				});

				xgiven( "a non-unique username", function(){
					then( "I should show a validation error", function() {
						fail( "implement" );
					})
				});

			});


		});

	}

}
