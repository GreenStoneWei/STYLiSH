const express = require('express');
const router = express.Router();
const multer = require('multer');
const mysql = require('../config/mysql.js');
const bodyParser = require('body-parser');
const credentials = require('../config/s3.env.js');
router.use(bodyParser.urlencoded({ extended: false}));

// --- upload with multer-s3
const aws = require('aws-sdk');
const multerS3 = require('multer-s3');
const s3 = new aws.S3();

aws.config.update({
  secretAccessKey: credentials.AWS_SECRET_ACCESS_KEY,
  accessKeyId: credentials.AWS_ACCESS_KEY,
  region: credentials.REGION,
});

const upload = multer({
  storage: multerS3({
	s3: s3,
	bucket: 'wheatxstone/img_gallery',
	acl: 'public-read', // everyone can read after uploading
	metadata: function (req, file, cb) {
	  cb(null, {fieldName: file.originalname});
	},
	key: function (req, file, cb) {
	  cb(null, Date.now().toString() + '_' + file.originalname);
	}
  })
})

// Another method with pure s3 sdk and multer
// const uploadSingle = require('../config/multer.config.js');
// const awsWorker = require('../controllers/aws.controller.js');
// router.post('/api/file/upload', upload.single("file"), awsWorker.doUpload);


// GET method to render page
router.get('/admin/product',(req, res) => {
  res.render('profile');
});

router.get('/admin/inventory', (req, res) => {
  const queryColor = `SELECT * FROM color`;
  const queryProduct = `SELECT * FROM product`;
  mysql.conPool.getConnection((err,connection) => {
	connection.query(queryColor, function (err, resultColor) {
		if (err) {
			connection.release();
			throw err;
		}
		connection.query(queryProduct, function (err, resultProduct){
			connection.release();
			if (err) throw err;
			res.render('inventory', {
				product: resultProduct,
				color: resultColor
			});
		})
	})
  }) // End  conPool getConnection
  
}); // End of router get

router.get('/admin/gallery', (req, res) => {
	const queryProduct = `SELECT * FROM product`;
	mysql.conPool.getConnection((err,connection) => {
		connection.query(queryProduct, function (err, resultProduct) {
			if (err) throw err;
			res.render('gallery', {
			product: resultProduct
			});
		})
	})
});


// POST method to update product details
router.post('/profile', upload.single('main_image'), (req, res) => {
	const {title}       = req.body,
		{category}    = req.body,
		{description} = req.body,
		{price}       = req.body,
		{texture}     = req.body,
		{wash}        = req.body,
		{place}       = req.body,
		{note}        = req.body,
		{story}       = req.body,
		mainImage     = req.file.path;
	mysql.conPool.getConnection((err, connection) => {
		let writeProfile = `INSERT INTO product
						(title, category, description, price, texture, wash, place, note, story, main_image) VALUES
						('${title}', '${category}', '${description}', '${price}', '${texture}', '${wash}', '${place}', '${note}', '${story}', '${mainImage}')`;
		connection.query(writeProfile, function (err) {
			if (err) throw err;
			console.log('1 product added.');
			connection.release();
			res.render('res_msg', {msg: '1 product added.'});
		});
	})
});

router.post('/inventory', (req, res) => {
	const {invtryTitle} = req.body,
		  {invtryColor} = req.body,
		  {size}        = req.body,
		  {qty}         = req.body;
	mysql.conPool.getConnection((err, connection) => {
		let writeInventory = `INSERT INTO inventory (product_id, color_name, size, qty) VALUES ('${invtryTitle}', '${invtryColor}', '${size}', '${qty}')`;
		connection.query( writeInventory, function (err) {
			if (err) throw err;
			console.log('1 inventory record added.');
			connection.release();
			res.send('1 inventory record added.');
		});
	})
});


const imgsUpload = upload.fields([{ name: 'gallery', maxCount: 4 }])
router.post('/gallery', imgsUpload, (req, res) => {
	const {galleryProductId} = req.body;
	let gallery = [];
	for (let i = 0; i < req.files['gallery'].length; i += 1){
		gallery.push(req.files['gallery'][i].key);
	}
	
	mysql.conPool.getConnection((err, connection) => {
		let checkIfExist = `SELECT * FROM img_gallery WHERE product_id = '${galleryProductId}'`;
		connection.query(checkIfExist, function(err, result){
		if (err) throw err;
		if (!result[0]){
			let insertGallery = `INSERT INTO img_gallery (product_id, gallery) VALUES ('${galleryProductId}', '${gallery}')`;
			connection.query( insertGallery, function (err) {
			if (err) throw err;
			console.log('Multiple images of 1 product added.');
			connection.release();
			res.send('Multiple images of 1 product added.');
			})
		}
		else {
			let updateGallery = `UPDATE img_gallery SET gallery = '${gallery}' WHERE product_id ='${galleryProductId}'`;
			connection.query(updateGallery, function(err){
			if (err) throw err;
			console.log('Multiple images of 1 product updated.');
			connection.release();
			res.send('Multiple images of 1 product updated.');
			})
		}
		})
	});
});

module.exports = router;
