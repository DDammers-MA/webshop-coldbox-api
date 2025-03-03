/**
 * A user in the system.
 *
 * This user is based off the Auth User included in cbsecurity, which implements already several interfaces and properties.
 * - https://coldbox-security.ortusbooks.com/usage/authentication-services#iauthuser
 * - https://coldbox-security.ortusbooks.com/jwt/jwt-services#jwt-subject-interface
 *
 * It also leverages several delegates for Validation, Population, Authentication, Authorization and JWT Subject.
 */
component
	table = "users"
	accessors     ="true"
    extends="quick.models.BaseEntity"
	transientCache="false"
	delegates     ="
		Validatable@cbvalidation,
		Population@cbDelegates,
		Auth@cbSecurity,
		Authorizable@cbSecurity,
		JwtSubject@cbSecurity
	"
{
	property name="wirebox" inject="wirebox" persistent="false";
	property name="id" fieldtype="id";
    property name="name";
    property name="email";
    property name="email_verified_at";
    property name="password" accessed="true";
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

	function getPermissions() {
		// Logic to get permissions
		return ['read', 'write', 'execute'];
	}

	function getRoles() {
	
			return ['user'];
	
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

	this.constraints = {
		name: { required: true, type: "string" },
		// email: { required: true, type: "email" },
		password: { required: true, type: "string" }
	};

	/**
	 * Constructor
	 */
	function init(){
		super.init();
		return this;
	}
}