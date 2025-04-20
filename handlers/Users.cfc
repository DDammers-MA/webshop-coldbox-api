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


    
}