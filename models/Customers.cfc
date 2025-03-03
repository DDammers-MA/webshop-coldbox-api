component extends="quick.models.BaseEntity" accessors="true" persistent="true" table="Customers" 
	delegates="Validatable@cbvalidation" {
    
    property name="user_id" fieldtype="id" generator="native";
    property name="first_name" type="string" length="50";
    property name="last_name" type="string" length="50";
    property name="phone" type="string" length="20";
    property name="status" type="string" length="20";
    property name="created_at" type="timestamp";
    property name="updated_at" type="timestamp";
    property name="created_by" type="string" length="50";
    property name="updated_by" type="string" length="50";

    this.memento = {
        defaultIncludes: [
            "user_id",
            "first_name",
            "last_name",
            "phone",
            "status",
            "created_at",
            "updated_at",
            "created_by",
            "updated_by"
        ],
        profiles: {
            detail: {
                defaultIncludes: []
            }
        }
    };

	this.constraints = {
		first_name: { required: true, type: "string" },
		last_name: { required: true, type: "string" },
		
	};
}