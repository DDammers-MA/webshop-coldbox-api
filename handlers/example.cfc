component extends="coldbox.system.RestHandler" {
  // https://quick.ortusbooks.com/guide/getting-started/retrieving-entities
  // Voorbeelden van functies die handig kunnen zijn.

  // Mocht je meer dan enkel iets ophalen moeten doen zoals filteren.
  // https://qb.ortusbooks.com/query-builder/building-queries

	function index(event, rc, prc) {
		// All messages.
		var news = getInstance( "News" ).asMemento().where('aktief' , '>', '-1').orderByDesc( "Datum" ).limit(20)
		var count = news.count()
    	// writeDump(var=count, abort=true, label='');

		// if (prc.oCurrentUser.hasRole('admin')) {}

		// Als er een zoekterm is, dan zoeken we op titel en tekst.
		// if (rc.keyExists('search')) {
		// 	news.where( function( q ) {
		// 		q.whereLike( 'Titel', '%#rc.search#%' )
		// 		.orWhere( 'tekst', 'LIKE', '%#rc.search#%' )
		// 	});
    	// }

		// Dit kan je net zovaak herhalen als je wilt.
		// if (rc.keyExists('groep')) {
		// 	news.where('groep', rc.groep);
		// }

		event.getResponse().setData( { "items": news.get() } );
	}

	function show(event, rc, prc) {
		var news = getInstance( "News" ).asMemento().findOrFail(rc.id);
		event.getResponse().setData( { "item": news } );
	}

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


	function update(event, rc, prc) {
		// Populate the model, based on request body.
		var news = getInstance( "News" ).findOrFail(rc.id);

		news.populate(rc, true);
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



	function delete(event, rc, prc) {
		var news = getInstance( "News" ).findOrFail(rc.id);
		news.delete()
		event.getResponse().setData({ "result": 1 });
	}
}