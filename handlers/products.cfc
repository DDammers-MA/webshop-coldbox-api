component extends="coldbox.system.RestHandler" {
    
    /**
     * index
     */
    function index(){

        var products = getInstance("Products").asQuery()
        .select()
        .get()
    

    	event.getResponse().setData( { "items": products } );
    }


    
}