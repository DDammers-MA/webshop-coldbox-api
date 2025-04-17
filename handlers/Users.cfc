component extends="coldbox.system.RestHandler" {
    
    /**
     * index
     */
    function index(event, rc, prc){

        var users = getInstance("Users").asQuery()
        .select()
        .where("email", rc)
        .first()
    
    	event.getResponse().setData( users  );
    }


    
}