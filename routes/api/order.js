const express = require('express');
const router = express.Router();
const mysql = require('../../config/mysql.js');
const bodyParser = require('body-parser');
const cookieParser = require('cookie-parser');
const request = require('request');
const credential = require('../../config/credentials.js');
router.use(bodyParser.urlencoded({ extended: false}));
router.use(bodyParser.json());
router.use(cookieParser());

if (!Date.now) {
	Date.now = function now() {
		return new Date().getTime();
	};
}

Date.prototype.yyyymmdd = function() {
	var mm = this.getMonth() + 1; // getMonth() is zero-based
	var dd = this.getDate();

	return [this.getFullYear(),
			(mm>9 ? '' : '0') + mm,
			(dd>9 ? '' : '0') + dd
			].join('');
};

// POST method to checkout, use TapPay SDK to perform the transaction
router.post('/order/checkout',(req, res) => {
	const prime             = req.body.prime,
		productPurchased  = JSON.stringify(req.body.order.list),
		subtotal          = parseInt(req.body.order.subtotal),
		freight           = parseInt(req.body.order.freight),
		total             = parseInt(req.body.order.total),
		payMethod         = req.body.order.payment,
		paymentStatus     = 'unpaid',
		recipient         = JSON.stringify(req.body.order.recipient),
		timeStamp         = new Date();

	// add a new record
	let unPaidRecord = `INSERT INTO customer_order
	(product_purchased, subtotal, freight, total, pay_method, payment_status, recipient, prime, time_stamp) VALUES
	('${productPurchased}', '${subtotal}' , '${freight}' , '${total}' ,'${payMethod}','${paymentStatus}', '${recipient}','${prime}','${timeStamp}')`;
	
	mysql.conPool.getConnection((err,connection) => {
		connection.query(unPaidRecord, function (err){
			if (err) throw err;
			// send prime and other data to tappay server
			const options = {
				url: 'https://sandbox.tappaysdk.com/tpc/payment/pay-by-prime',
				method:'POST',
				headers: {
					'Content-Type': 'application/json',
					'x-api-key': credential.tappayKey,
				},
				body: JSON.stringify({
					prime: prime,
					partner_key: credential.tappayKey,
					merchant_id: 'AppWorksSchool_CTBC',
					details: "TapPay Test",
					amount: total,
					cardholder: {
							phone_number: req.body.order.recipient.phone,
							name: req.body.order.recipient.name,
							email: req.body.order.recipient.email,
							zip_code: "12345",
							address: req.body.order.recipient.address,
							national_id: "A123456789"
					}, // Need cardholder data from front-end
					"remember": true
				})
			}
	
			// connection to TapPay server
			request(options, function(error, response, body){
				if (!error && response.statusCode == 200) {
					const info = JSON.parse(body);
					// if transaction is successful (where status = 0) update the payment status
					if (info.status == 0){
						const transactionDate = new Date();
						const number = transactionDate.yyyymmdd();
						let updatePayment = `UPDATE customer_order SET payment_status = 'paid', transaction_number = '${number}' WHERE prime = '${prime}'`;
						connection.query(updatePayment, function(err){
							if (err) throw err;
							// return the order number
							let searchId = `SELECT id FROM customer_order WHERE prime = '${prime}'`;
							connection.query(searchId, function(err, result_id){
								if (err) throw err;
								connection.release();
								res.send(JSON.stringify({number: number + result_id[0].id}));
							}) // End of query id
						}) // End of query update_payment
	
					}
					// if transaction failed
					else {
						let failPayment = `UPDATE customer_order SET payment_status = 'failed' WHERE prime = '${prime}'`;
						connection.query(failPayment, function(err){
							if (err) throw err;
							connection.release();
							res.send(JSON.stringify({error: 'Invalid token'}));
						})
					} // End of else
				}
				else {
					connection.release();
					res.send(JSON.stringify({error: 'Invalid token'}));
				} // End of else
			}) // End of request
		}) // End of query unpaid record
	}) // End of conPool getConnection
}) // End of router post

module.exports = router;
