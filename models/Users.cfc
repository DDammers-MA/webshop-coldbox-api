component table="users" extends="quick.models.BaseEntity" accessors="true" 	
delegates="
		Validatable@cbvalidation,
		Population@cbDelegates,
		Auth@cbSecurity,
		Authorizable@cbSecurity,
		JwtSubject@cbSecurity
	" {

property name="wirebox" inject="wirebox" persistent="false";
    property name="id" column="id" type="bigint" generator="identity";
    property name="name";
    property name="email";
    property name="email_verified_at";
    property name="password";
    property name="remember_token";
    property name="created_at";
    property name="updated_at";
    property name="is_admin";

    function beforeCreate() {
        variables.created_at = now();
    }

    function beforeUpdate() {
        variables.updated_at = now();
    }

    this.memento = {
        defaultIncludes: [
            "id",
            "name",
            "email",
            "email_verified_at",
            "password",
            "remember_token",
            "created_at",
            "updated_at",
            "is_admin"
        ],
        profiles: {
            detail: {
                defaultIncludes: []
            }
        }
    };

    // Validation for create.
    this.constraints = {
        name: { required: true, type: "string", maxLength: 255 },
        email: { required: true, type: "email" },
        password: { required: true, type: "string", minLength: 8 }
    };
}