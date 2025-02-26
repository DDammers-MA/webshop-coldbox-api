/**
 * Authentication Handler
 */
component extends="coldbox.system.RestHandler" {

	// Injection
	property name="userService" inject="UserService";
	property name="wirebox" inject="wirebox";
	property name="bcrypt" inject="BCrypt@BCrypt";

	/**
	 * Login a user into the application
	 *
	 * @x           -route          (POST) /api/login
	 * @requestBody ~auth/login/requestBody.json
	 * @response    -default ~auth/login/responses.json##200
	 * @response    -401     ~auth/login/responses.json##401
	 */
	function login( event, rc, prc ){
		param rc.name = "";
		param rc.password = bcrypt.hash(rc.password);

	// writeDump(var=rc, abort=true, label='');
		
		var token = jwtAuth().attempt(rc.email, rc.password);

		event
			.getResponse()
			.setData(token)
			.addMessage(
				"Bearer token created and it expires in #jwtAuth().getSettings().jwt.expiration# minutes"
			);
	}

	/**
	 * Register a new user in the system
	 *
	 * @x           -route          (POST) /api/register
	 * @requestBody ~auth/register/requestBody.json
	 * @response    -default ~auth/register/responses.json##200
	 * @response    -400     ~auth/register/responses.json##400
	 */
	function register( event, rc, prc ){
		param rc.name = "";
		param rc.email = "";
		param rc.password = "";
		param rc.is_admin = false;

		// Create a new user instance via UserService
		var user = userService.create({
			name: rc.name,
			email: rc.email,
			password: rc.password,
			is_admin: rc.is_admin,
			created_at: now()
		});

		// Log them in if the user was created successfully
		event
			.getResponse()
			.setData({
				"token": jwtAuth().fromUser(user),
				"user": user.getMemento()
			})
			.addMessage(
				"User registered correctly and Bearer token created and it expires in #jwtAuth().getSettings().jwt.expiration# minutes"
			);
	}

	/**
	 * Logout a user
	 *
	 * @x        -route          (POST) /api/logout
	 * @security bearerAuth,ApiKeyAuth
	 * @response -default ~auth/logout/responses.json##200
	 * @response -500     ~auth/logout/responses.json##500
	 */
	function logout( event, rc, prc ){
		jwtAuth().logout();
		event.getResponse().addMessage("Successfully logged out");
	}

}