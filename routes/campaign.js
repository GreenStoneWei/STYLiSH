const express = require('express');
const router = express.Router();
const multer = require('multer');
const mysql = require('mysql');
const bodyParser = require('body-parser');
const hostIp = 'https://wheatxstone.com';
const redis = require('redis');
const client = redis.createClient();
const uploadSingle = require('../config/multer.config.js');
const awsWorker = require('../controllers/aws.controller.js');

router.use(bodyParser.urlencoded({ extended: false}));

// GET method to render page
router.get('/admin/campaign',(req, res) => {
	res.render('campaign');
});

// POST method to add a campaign
router.post('/addCampaign', uploadSingle.single('picture'), (req, res) => {
	const {campaignProductId} = req.body,
			{story}           = req.body,
			picturePath       = req.file.path,
			picture           = hostIp + picturePath.slice(6);

	let addCampaign = `INSERT INTO campaign
						(product_id, picture, story) VALUES
						('${campaignProductId}', '${picture}', '${story}')`;
	mysql.conPool.getConnection((err,connection) => {
		connection.query(addCampaign, function (err) {
			connection.release();
			if (err) throw err;
			console.log('1 campaign product added.');
			client.del('campaignCache');
			res.render('campaign_respond', {msg: '1 campaign product added.'});
		});
	}) // End of conPool getConnection
});

module.exports = router;
