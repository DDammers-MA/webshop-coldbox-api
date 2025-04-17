component extends="coldbox.system.RestHandler" {
    
    /**
     * index
     */
    function index(){

        var products = getInstance("Products").asQuery()
        .select()
        .get()
    

    	event.getResponse().setData( products  );
    }

    function create() {
        	var products = populate("Products");
		// Validate it
		var vResults = validateModel( products );
		// Check it
		if ( vResults.hasErrors() ) {
			// Return the errors
			event.getResponse().setStatus( 400 );
			event.getResponse().setData( vResults.getAllErrors() );
		} else {
			// Save the message
			products.save();
			// Return the message
			event.getResponse().setStatus( 201 );
			event.getResponse().setData( { 'item': products.getMemento() } );
    	}
    }


    
}