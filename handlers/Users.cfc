component extends="coldbox.system.RestHandler" {
	property name="bcrypt" inject="BCrypt@BCrypt";
    /**
     * index
     */
    function index(event, rc, prc){

var authUser = jwtAuth().getUser();

        // writeDump(var=rc, abort=true, label="rc");

        // var users = getInstance("Users").asQuery()
        // .select()
        // .where("email", rc)
        // .first()
    
    	event.getResponse().setData( authUser.getMemento("id,name,email,is_admin")  );
    }

    
    /**
     * index
     */
    function users(event, rc,prc){
    // writeDump(var = rc, abort=true)
     var users = getInstance("Users").asMemento()


 if (rc.keyExists('name')) {
	users.where( function( q ) {
				q.whereLike( 'name', '%#rc.name#%' )
				// .orWhere( 'tekst', 'LIKE', '%#rc.search#%' )
			});
		}

         if (rc.keyExists('email')) {
	users.where( function( q ) {
				q.whereLike( 'email', '%#rc.email#%' )
				// .orWhere( 'tekst', 'LIKE', '%#rc.search#%' )
			});
		}

        
         if (rc.keyExists('isAdmin')) {
        // writeDump(var=rc,abort=true)
				users.whereIn( 'is_admin', rc.isAdmin )
				// .orWhere( 'tekst', 'LIKE', '%#rc.search#%' )
		
		}

        //      if (rc.keyExists('admin')) {
        //         users.where("is_admin" , rc.admin)
		// }
    
    

     event.getResponse().setData( users.get() );

    }



/**
 * index
 */
function create(event, rc, prc){
    // writeDump(var=rc, abort=true, label="rc");

    var users = populate("Users");

   var hashedPassword = bcrypt.hashPassword(rc.password);
    users.setPassword(hashedPassword);


    // Validate it
    var vResults = validateModel( users );
    // Check it
    if ( vResults.hasErrors() ) {
        // Return the errors
        event.getResponse().setStatus( 400 );
        event.getResponse().setData( vResults.getAllErrors() );
    } else {
        // Save the message
        users.save();
        // Return the message
        event.getResponse().setStatus( 201 );
        event.getResponse().setData( { 'item': users.getMemento() } );
    }
}

}