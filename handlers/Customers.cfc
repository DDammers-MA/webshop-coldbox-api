component extends="coldbox.system.RestHandler" {

    function create(event, rc, prc) {
		// Populate the model, based on request body.
    // writeDump(var=rc, abort=true, label='');
		var news = populate("News");
		// Validate it
		var vResults = validateModel( news );
		// Check it
		if ( vResults.hasErrors() ) {
			// Return the errors
			event.getResponse().setStatus( 400 );
			event.getResponse().setData( vResults.getAllErrors() );
		} else {
			// Save the message
			news.save();
			// Return the message
			event.getResponse().setStatus( 201 );
			event.getResponse().setData( { 'item': news.getMemento() } );
    	}
	}
}