component{

	// Configure ColdBox Application
	function configure(){

		// coldbox directives
		coldbox = {
			//Application Setup
			appName 				= getSystemSetting( "APPNAME", "Your app name here" ),
			eventName 				= "event",

			//Development Settings
			reinitPassword			= "",
			handlersIndexAutoReload = true,

			//Implicit Events
			defaultEvent			= "rants.index", 			//main.index
			requestStartHandler		= "Main.onRequestStart",
			requestEndHandler		= "",
			applicationStartHandler = "Main.onAppInit",
			applicationEndHandler	= "",
			sessionStartHandler 	= "",
			sessionEndHandler		= "",
			missingTemplateHandler	= "",

			//Extension Points
			applicationHelper 			= "includes/helpers/ApplicationHelper.cfm",
			viewsHelper					= "",
			modulesExternalLocation		= [],
			viewsExternalLocation		= "",
			layoutsExternalLocation 	= "",
			handlersExternalLocation  	= "",
			requestContextDecorator 	= "",
			controllerDecorator			= "",

			//Error/Exception Handling
			invalidHTTPMethodHandler 	= "",
			exceptionHandler			= "main.onException",
			invalidEventHandler			= "",
			customErrorTemplate			= "/views/error.cfm",

			//Application Aspects
			handlerCaching 			= false,
			eventCaching			= false,
			viewCaching				= false,
			// Will automatically do a mapDirectory() on your `models` for you.
			autoMapModels			= true
		};

		// custom settings
		settings = {

		};

		// environment settings, create a detectEnvironment() method to detect it yourself.
		// create a function with the name of the environment so it can be executed if that environment is detected
		// the value of the environment is a list of regex patterns to match the cgi.http_host.
		environments = {
			development = "localhost,^127\.0\.0\.1"
		};

		// Module Directives
		modules = {
			// An array of modules names to load, empty means all of them
			include = [],
			// An array of modules names to NOT load, empty means none
			exclude = []
		};

		//LogBox DSL
		logBox = {
			// Define Appenders
			appenders = {
				coldboxTracer = { class="coldbox.system.logging.appenders.ConsoleAppender" }
			},
			// Root Logger
			root = { levelmax="INFO", appenders="*" },
			// Implicit Level Categories
			info = [ "coldbox.system" ]
		};

		//Layout Settings
		layoutSettings = {
			defaultLayout = "",
			defaultView   = ""
		};

		//Interceptor Settings
		interceptorSettings = {
			customInterceptionPoints = ""
		};

		//Register interceptors as an array, we need order
		interceptors = [
		];


		// module setting overrides
		moduleSettings = {
			"cbauth" : {
				"userServiceClass" : "UserService"
			},
			"cbsecurity": {
				// The global invalid authentication event or URI or URL to go if an invalid authentication occurs
				"invalidAuthenticationEvent"	: "login",
				// Default Auhtentication Action: override or redirect when a user has not logged in
				"defaultAuthenticationAction"	: "redirect",
				// The global invalid authorization event or URI or URL to go if an invalid authorization occurs
				"invalidAuthorizationEvent"		: "login",
				// Default Authorization Action: override or redirect when a user does not have enough permissions to access something
				"defaultAuthorizationAction"	: "redirect",
				// You can define your security rules here or externally via a source
				"rules"							: [
					{
						"whitelist": "",
						"securelist": "rants/new",
						"match": "url"
					}
				],
				// The validator is an object that will validate rules and annotations and provide feedback on either authentication or authorization issues.
				"validator"						: "CBAuthValidator@cbsecurity",
				// The WireBox ID of the authentication service to use in cbSecurity which must adhere to the cbsecurity.interfaces.IAuthService interface.
				"authenticationService"  		: "authenticationService@cbauth",
				// WireBox ID of the user service to use
				"userService"             		: "UserService",
				// Activate handler/action based annotation security
				"handlerAnnotationSecurity"		: true,
				// Activate security rule visualizer, defaults to false by default
				"enableSecurityVisualizer"		: true
			}
		};

		/*


		// flash scope configuration
		flash = {
			scope = "session,client,cluster,ColdboxCache,or full path",
			properties = {}, // constructor properties for the flash scope implementation
			inflateToRC = true, // automatically inflate flash data into the RC scope
			inflateToPRC = false, // automatically inflate flash data into the PRC scope
			autoPurge = true, // automatically purge flash data for you
			autoSave = true // automatically save flash scopes at end of a request and on relocations.
		};

		//Register Layouts
		layouts = [
			{ name = "login",
		 	  file = "Layout.tester.cfm",
			  views = "vwLogin,test",
			  folders = "tags,pdf/single"
			}
		];

		//Conventions
		conventions = {
			handlersLocation = "handlers",
			viewsLocation 	 = "views",
			layoutsLocation  = "layouts",
			modelsLocation 	 = "models",
			eventAction 	 = "index"
		};
		*/

	}

	/**
	* Development environment
	*/
	function development(){
		coldbox.customErrorTemplate = "/coldbox/system/includes/BugReport.cfm";
		coldbox.handlersIndexAutoreload = true;
		coldbox.reinitPassword = "";
		coldbox.handlerCaching = false;
		coldbox.viewCaching = false;
		coldbox.eventCaching = false;
	}

}