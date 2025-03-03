/**
 * This service provides user authentication, retrieval and much more.
 * Implements the CBSecurity IUserService: https://coldbox-security.ortusbooks.com/usage/authentication-services#iuserservice
 */
component accessors="true" singleton {

	property name="wirebox" inject="wirebox";
	property name="bcrypt" inject="BCrypt@BCrypt";

	/**
	 * Verify if the incoming username/password are valid credentials.
	 *
	 * @email The username
	 * @password The password
	 */
	function isValidCredentials( required email, required password ){
		var result = false; 
		// Retrieve the user by email
		// writeDump(var=arguments, abort=true, label="isValidCredentials");
		var oTarget = retrieveUserByEmail( arguments.email ).getMemento();
		
		if ( !isNull(oTarget) ) {
			return false;
		}

			// Use checkPassword to verify the password
		if (!bcrypt.checkPassword(arguments.password, oTarget.password)) {
			event.getResponse().setError(true).addMessage("Invalid password");
			return false;
		}

		return result;
	}

	/**
	 * Create a new user
	 *
	 * @userData Struct containing user data (name, email, password, is_admin)
	 *
	 * @return User entity
	 */
	function create( required struct userData ){
		// var hashedPassword = bcrypt.hashPassword(userData.password);


		// Create a new User instance
		var user = wirebox.getInstance("User")
			.setName(userData.name)
			.setEmail(userData.email)
			.setPassword(userData.password)
			.setIs_admin(userData.is_admin) // Ensure correct method is used
			.setCreated_at(now());

		// Validate the user
		user.validateOrFail();

		// Save the user to the database
		user.save();

		registerCustomer(user);

		return user;
	}

	/**
	 * Retrieve a user by username
	 *
	 * @return User that implements JWTSubject and/or IAuthUser
	 */
	function retrieveUserByUsername( required name ){
		return wirebox.getInstance("User").where( "name", arguments.name ).firstOrFail();
	}

	function retrieveUserByEmail( required email ){
	var user = wirebox.getInstance("User").where( "email", lcase(arguments.email) ).first();

	return user;
	}
	/**
	 * Retrieve a user by unique identifier
	 *
	 * @id The unique identifier
	 *
	 * @return User that implements JWTSubject and/or IAuthUser
	 */
	User function retrieveUserById( required id ){
		return wirebox.getInstance("User").findOrFail( arguments.id );
	}

	function registerCustomer( required User user) {
  

	var firstName = listFirst(user.getName(), " ");
    var lastName = listRest(user.getName(), " ");

	  if (!len(trim(lastName))) {
        lastName = "Unknown";
    } 
 
		// Create a new Customer instance
	 var customer = wirebox.getInstance("Customers")
        .setFirst_name(firstName)
        .setLast_name(lastName)	
		.setCreated_at(now())
		.setUser_id(user.getId());

    //     // Validate the customer
        customer.validateOrFail();
		// writeDump(var=customer, abort=true, label='userData');

    //     // Save the customer to the database
        customer.save();
	}
}