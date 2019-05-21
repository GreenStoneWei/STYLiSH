const express = require('express');
const app = express();
const secret = "074205d797e99c1cb638e5dee4793ae013e9a9341797b8f866a4d45b86b458e6";
const crypto = require('crypto');
const execFile = require('child_process').execFile;
const mysql = require('./config/mysql.js');
app.use(express.static('public'));
app.set('view engine', 'pug');

if (!Date.now) {
	Date.now = function now() {
		return new Date().getTime();
	};
  }
  
Date.prototype.yyyymmdd = function() {
const mm = this.getMonth() + 1; // getMonth() is zero-based
const dd = this.getDate();

return [this.getFullYear(),
		(mm>9 ? '' : '0') + mm,
		(dd>9 ? '' : '0') + dd
		].join('');
};

// CORS Control
app.use("/api/", function(req, res, next){
	res.set("Access-Control-Allow-Origin", "*");
	res.set("Access-Control-Allow-Headers", "Origin, Content-Type, Accept, Authorization");
	res.set("Access-Control-Allow-Methods", "POST, GET, OPTIONS");
	res.set("Access-Control-Allow-Credentials", "true");
	next();
});

const mainRoutes = require('./routes');
app.use(mainRoutes);

const campaignRoutes = require('./routes/campaign');
app.use('/', campaignRoutes);

const signRoutes = require('./routes/api/signpage');
app.use('/api/1.0', signRoutes);

const orderRoutes = require('./routes/api/order');
app.use('/api/1.0', orderRoutes);

const api_1_0 = require('./routes/api/1.0');
app.use('/api/1.0', api_1_0);

app.post('/payload', (req,res) => {
	let now = new Date().toLocaleString('en-US',{timeZone: 'Asia/Taipei'});
	// let body = req.rawBody;
	// let sig = "sha1=" + crypto.createHmac('sha1', secret).update(body).digest('hex');
	// if (req.headers['x-hub-signature'] == sig){
		execFile('/home/ec2-user/cicdbash/midterm.sh', (error, stdout, stderr) => {
			if (error) {
				let cicdRecord = `INSERT INTO cdrecord (timestamp, log) VALUES ('${now}', '${stderr}')`;
				mysql.conPool.query(cicdRecord, function(error){
					if (error) {
						console.log(error);
						res.end();
					}
					res.end();
				})
			}
			let cicdRecord = `INSERT INTO cdrecord (timestamp, log) VALUES ('${now}', '${stdout}')`;
			console.log(stdout);
			mysql.conPool.query(cicdRecord, function(error){
				if (error) {
					console.log(error);
					throw error;
				}
				res.end();
			})
		})
	// } // end of if
	// console.log('wrong secret')
})

app.get('/cicdhistory', (req,res)=>{
	mysql.conPool.query('SELECT * FROM cdrecord', function(error, result){
		res.send(result.reverse());
	})
})

app.listen(3000, () => {
  console.log('The application is running on localhost:3000!');
});
