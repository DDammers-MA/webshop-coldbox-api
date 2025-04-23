component extends="coldbox.system.RestHandler" {
    
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
    

     event.getResponse().setData( users.get() );

    }
    


    
}