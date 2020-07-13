/**
 * Manage rants
 * It will be your responsibility to fine tune this template, add validations, try/catch blocks, logging, etc.
 */
component{

	// DI
	property name="rantService" 	inject="RantService";
	property name="messagebox" 		inject="MessageBox@cbmessagebox";



	/**
	 * Display a list of rants
	 */
	function index( event, rc, prc ){
		prc.aRants = rantService.getAll()
		event.setView( "rants/index" );
	}

	/**
	 * Return an HTML form for creating one rant
	 */
	function new( event, rc, prc ){
		event.setView( "rants/new" );
	}

	/**
	 * Create a rants
	 */
	function create( event, rc, prc ){
		var oRant = populateModel( "Rant" );
		oRant.setUserID( auth().getUserId() );

		rantService.create( oRant );
		messagebox.info( "Rant created!" );
		relocate( URI="/rants" );
	}


}
