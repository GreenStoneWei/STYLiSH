const express = require('express');
const router = express.Router();
const mysql = require('../../config/mysql.js');
const bodyParser = require('body-parser');
const cookieParser = require('cookie-parser');
const crypto = require('crypto');
const tokenValidTime = 600; // unit: second
const request = require('request');

router.use(bodyParser.urlencoded({ extended: false}));
router.use(bodyParser.json());
router.use(cookieParser());

if (!Date.now) {
  Date.now = function now() {
    return new Date().getTime();
  };
}

function getAccessToken (pwd, cb){
  // use sha256 algorithm to create hash instance, other choices including mb5, sha1, sha512 etc.
  const tokenHash = crypto.createHash('sha256');
  tokenHash.update(pwd);
  crypto.randomBytes( 16, function(err, buffer) {
    if (err) throw err;
    tokenHash.update(buffer);
    var accessToken = tokenHash.digest('hex');
    cb(accessToken);
  });
}

function encodePwd (password) {
  const pwdHash = crypto.createHash('sha256');
  pwdHash.update(password);
  var encodedPwd = pwdHash.digest('hex');
  return encodedPwd;
}

//
// ----- get method to render Sign In and Sign Up Pages -----
//

router.get('/user/signup.html',(req, res) => {
  res.render('sign_up'); // ec2 is case sensitive
});

router.get('/user/signin.html',(req, res) => {
  res.render('sign_in');
})

router.get('/user/profile.html', (req, res) => {
  res.render('user_profile');
})

// ----- Start of Form Method -----

router.post('/user/signup', (req, res) => {
	const {name}      = req.body,
		  {email}     = req.body,
		  {password}  = req.body,
	      encondedPwd   = encodePwd(password),
		  accessExpired = parseInt(Date.now()), // record the moment the user sign up (unit: ms)
		  timeStamp     = new Date();

	// Check if the email has been registered.
	let checkIfExist = `SELECT * FROM user WHERE email = '${email}'`;
	mysql.conPool.getConnection((err,connection) => {
		connection.query(checkIfExist, function(err, result){
		if (err) throw err;
		if (result[0]){
			connection.release();
			res.send({"msg": "This email has been registered."})
		}
	
		// if the email is ok, assign an access token and have a record of it
		else {
			getAccessToken(password, function(accessToken){
			let userSignUp = `INSERT INTO user (name, email, password, access_token, access_expired, time_stamp) VALUES
								('${name}' , '${email}' , '${encondedPwd}', '${accessToken}', '${accessExpired}','${timeStamp}')`;
				connection.query(userSignUp, function (err){
				if (err) throw err;
				console.log('1 user registered.');
				res.cookie('accessToken', accessToken);
	
				// get the user profile for the response
				let userInfo = `SELECT id, provider, name, email, picture, access_token FROM user WHERE email = '${email}'`;
				connection.query(userInfo, function (err, result){
				if (err) throw err;
				const signUpResponse = {
					data: {
						access_token: accessToken,
						access_expired: tokenValidTime,
						user: {
						id: result[0].id,
						provider: "native",
						name: result[0].name,
						email: result[0].email,
						picture: result[0].picture
						}
					}
					}
				connection.release();
				res.send(JSON.stringify(signUpResponse));
				}) // End of query user infomation
			}) // End of query insert
			}) // End of getAccessToken
		} // End of else
		}) // End of check if email exist
	}) // End if conPool getConnection
  
}) // End of post method

router.post('/user/signin', (req, res) => {

	// check where the user comes from, if comes from facebook
	if (req.body.provider == 'facebook'){
		const fbToken = req.body.access_token;
		const signinTime  = parseInt(Date.now());
		const timeStamp  = new Date();
		let graphURL = `https://graph.facebook.com/me?fields=id,name,email,picture&access_token=${fbToken}`;

		// Take user's token to facebook and get the user profile
		request( graphURL, function (error, response, body){
			const id     = JSON.parse(body).id,
				password = 'Null',
				name     = JSON.parse(body).name,
				email    = JSON.parse(body).email,
				picture  = JSON.parse(body).picture.data.url;

		// check if the user exist already, if NO, add the user
			let checkIfExist = `SELECT * FROM user
							WHERE provider = 'facebook' AND email = '${email}'`;
			mysql.conPool.getConnection((err,connection) => {
				connection.query(checkIfExist, function(err, result){
					if (err) throw err;
					if (!result[0]){
						let fbUser  = `INSERT INTO user ( provider, name, email, password, picture, access_token, access_expired, time_stamp)
									VALUES ( 'facebook', '${name}' , '${email}' , '${password}', '${picture}' , '${fbToken}', '${signinTime}', '${timeStamp}')`;
						connection.query( fbUser, function(err){
							if (err) throw err;
							res.cookie('accessToken', fbToken);
							let fbUserResponse = {
								data: {
									access_token: fbToken,
									access_expired: tokenValidTime,
									user: {
									id: id,
									provider: 'facebook',
									name: name,
									email: email,
									picture: picture
									}
								}
								}
							connection.release();
							res.send(JSON.stringify(fbUserResponse));
						}) // End of connection.query fb User
					}
					// check if the user exist already, if YES, update the user's record
					else{
						let updateFBuser = `UPDATE user SET access_token = '${fbToken}', picture = '${picture}', access_expired = '${signinTime}', time_stamp = '${timeStamp}' WHERE email = '${email}'`;
						connection.query(updateFBuser, function(err){
						if (err) throw err;
						res.cookie('accessToken', fbToken);
						const fbResponse = {
								data: {
									access_token: fbToken,
									access_expired: tokenValidTime,
									user: {
									id: id,
									provider: 'facebook',
									name: name,
									email: email,
									picture: picture
									}
								}
							}
						connection.release();
						res.send(JSON.stringify(fbResponse));
						}) // End of query updateFBuser
					} // End of else
				}); // End of checkIfExist
			}) // End of conPool getConnection
		}); // End of request
	}
	// check where the user comes from, if he/she is a native user
	else {
		const {name}      = req.body,
			  {email}     = req.body,
			  {password}  = req.body,
		      encondedPwd = encodePwd(password),
		      signinTime  = parseInt(Date.now()),
		      timeStamp  = new Date();
		// check the user fill all the blanks
		if ( name && email && password ){
			// check if any the email and password match
			let checkCombination = `SELECT * FROM user WHERE email = '${email}' AND password = '${encondedPwd}'`;
			mysql.conPool.getConnection((err,connection) => {
				connection.query(checkCombination, function (err, result){
				if (err) throw err;
				if (!result[0]){
					connection.release();
					res.send({"msg": "Wrong email and password combination"});
				} else {
						getAccessToken(password, function(accessToken){
							let assignNewToken = `UPDATE user SET access_token = '${accessToken}', access_expired = '${signinTime}', time_stamp = '${timeStamp}' WHERE email = '${email}'`;
							connection.query(assignNewToken, function(err){
								if (err) throw err;
								res.cookie('accessToken', accessToken);
				
								// generate the update info for the user
								let userInfo = `SELECT id, provider, name, email, picture, access_token FROM user WHERE email = '${email}'`;
								connection.query(userInfo, function (err, result){
								if (err) throw err;
								const updatedInfo = {
										data: {
											access_token: accessToken,
											access_expired: tokenValidTime,
											user: {
											id: result[0].id,
											provider: 'native',
											name: result[0].name,
											email: result[0].email,
											picture: result[0].picture
											}
										}
								}
								connection.release();
								res.send(JSON.stringify(updatedInfo));
								}) // End of query new user info
							}) // End of query assignNewToken
						}) // End of getAccessToken
					} // End of else
				}) // End of query sign in
			}) // End of conPool getConnection	
		}
	} // End of else
}) // End of post method


router.get('/user/profile', (req, res) => {
	const authToken = req.headers.authorization.slice(7);
	const nowTime   = parseInt(Date.now());

	// check user's token
	let checkToken = `SELECT * FROM user WHERE access_token = '${authToken}'`;
	mysql.conPool.getConnection((err,connection) => {
		connection.query(checkToken, function(err, result){
			if (err) throw err;
			// check if the token expired
			const expiration = Math.ceil((nowTime - result[0].access_expired)/1000) ;
			if ( expiration > tokenValidTime ){
				connection.release();
				res.send({"err": "Your token was expired. Please sign in again to update the token"});
			} else {
				const userInfo = {
					data: {
						id: result[0].id,
						provider: result[0].provider,
						name: result[0].name,
						email: result[0].email,
						picture: result[0].picture
						}
				}
				connection.release();
				res.send(JSON.stringify(userInfo));
			} // End of else
		}) // End of query
	}) // End of conPool getConnection
}) // End of post method

module.exports = router;
