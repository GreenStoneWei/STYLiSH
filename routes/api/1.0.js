const express = require('express');
const router = express.Router();
const mysql = require('../../config/mysql.js');
const redis = require('redis');
const client = redis.createClient();
const hostIP = 'https://s3.amazonaws.com/wheatxstone/img_gallery/';
const cacheExpireTime = 60;

// ----- Start of global function area -----
function NewProduct(id, title, description, price, texture, wash, place, note, story, colors, size, variants, mainImage, images){
	this.id = id,
	this.title = title,
	this.description = description,
	this.price = price,
	this.texture = texture,
	this.wash = wash,
	this.place = place,
	this.note = note,
	this.story = story,
	this.colors = colors,
	this.sizes = size,
	this.variants = variants,
	this.main_image = mainImage,
	this.images = images
}

function makeImgArray(str){
	let imgURL = [];
	const arrData = str.split(',');
	for (let i = 0 ; i < arrData.length ; i ++){
		imgURL.push( hostIP + arrData[i]);
	}
	return imgURL;
}

function generateVariant(data){
	function NewVarObj(colorCode, size, stock){
		this.colorCode = colorCode,
		this.size      = size,
		this.stock     = stock
	}
	var results=[];
	for (let i = 0; i < data.length; i += 1){
		var temp = new NewVarObj(data[i].code, data[i].size, data[i].qty);
		results.push(temp);
	}
	return results
}

function makeSizeObj(data){
	var results = [];
	for (let x = 0 ; x < data.length ; x += 1){
		results.push(data[x].size);
	}
	var uniResults = [...new Set(results)];
	return uniResults;
}

function generateColorObj(data){
	function NewColorObj(code, name){
		this.code = code,
		this.name = name
	}
	var results = [];
	for (let y = 0 ; y < data.length ; y += 1){
		var temp = new NewColorObj(data[y].code, data[y].color_name);
		results.push(temp);
	}
	results = results.filter((arr, index, self) =>
		index === self.findIndex((t) => (
			t.place === arr.place && t.name === arr.name
		))
	)
	return results;
}

function isEmpty(obj) {
	for(let key in obj) {
		if(obj.hasOwnProperty(key))
			return false;
		}
	return true;
}

// ----- End of function area -----
// ----- Start of product list api -----

router.get('/products/:route', function(req, res) {
	const {route}     = req.params,
			{keyword}   = req.query,
			{id}        = req.query,
			{paging}    = req.query;
	const objPerPage  = 6;
	let limitStatement = '';
	let productCount = '';
	let queryProduct = '';
	// check if paging query parameter exists
	if (paging){
		if (parseInt(paging) == 0){
			limitStatement = `LIMIT ${objPerPage}`;
		}
		else if (parseInt(paging) > 0){
			const showObjFrom = (parseInt(paging) * objPerPage);
			limitStatement = `LIMIT ${showObjFrom} , ${objPerPage}`;
		}
		else if (parseInt(paging) < 0){
			res.send('{"error": "Invalid token."}');
		}
		else {
			res.send('{"error": "Invalid token."}');
		}
	}
	else if (!paging) {
		var tempPaging = 0;
		limitStatement = `LIMIT ${objPerPage}`;
	}
	else {
		limitStatement = '';
	}

	if (keyword){
		productCount = `SELECT count(*) FROM product INNER JOIN img_gallery ON product.id = img_gallery.product_id
						WHERE title LIKE '%${keyword}%'`;
		queryProduct = `SELECT * FROM product INNER JOIN img_gallery ON product.id = img_gallery.product_id
						WHERE title LIKE '%${keyword}%' ${limitStatement}`;
	}
	else if (id) {
		productCount = `SELECT count(*) FROM product INNER JOIN img_gallery ON product.id = img_gallery.product_id
						WHERE product_id = '${id}'`;
		queryProduct = `SELECT * FROM product INNER JOIN img_gallery ON product.id = img_gallery.product_id
						WHERE product_id = '${id}' ${limitStatement}`;
	}
	else if ( route === "all" ){
		productCount = `SELECT count(*) FROM product INNER JOIN img_gallery ON product.id = img_gallery.product_id`;
		queryProduct = `SELECT * FROM product INNER JOIN img_gallery ON product.id = img_gallery.product_id ${limitStatement}`;
	}
	else if (route === "men") {
		productCount = `SELECT count(*) FROM product INNER JOIN img_gallery ON product.id = img_gallery.product_id
						WHERE product.category = "men"`;
		queryProduct = `SELECT * FROM product INNER JOIN img_gallery ON product.id = img_gallery.product_id
						WHERE product.category = "men" ${limitStatement}`;
	}
	else if (route === "women") {
		productCount = `SELECT count(*) FROM product INNER JOIN img_gallery ON product.id = img_gallery.product_id
						WHERE product.category = "women"`;
		queryProduct = `SELECT * FROM product INNER JOIN img_gallery ON product.id = img_gallery.product_id
						WHERE product.category = "women" ${limitStatement}`;
	}
	else if (route === "accessories") {
		productCount = `SELECT count(*) FROM product INNER JOIN img_gallery ON product.id = img_gallery.product_id
						WHERE product.category = "accessories"`;
		queryProduct = `SELECT * FROM product INNER JOIN img_gallery ON product.id = img_gallery.product_id
						WHERE product.category = "accessories" ${limitStatement}`;
	}
	else {
		res.send('{"error": "Invalid token."}')
	}

	mysql.conPool.getConnection((err,connection) => {
		connection.query(productCount, function (err, resCount) {
			connection.release();
			const totalCount = resCount[0]['count(*)'] *1 ;
			const lastPage   = Math.ceil(totalCount/objPerPage) - 1;

			// search cache before query database
			const cacheKey = `productCacheId${id}`;
			client.get(cacheKey, function(err, reply){
				if (reply){
					res.send(reply);
				}

				// if no cache, search in database
				else {
					connection.query(queryProduct, function (err, productResponse) {
						if (err) throw err;
						if (isEmpty(productResponse)){
							res.send('{"error": "Invalid token."}')
						}
						else {
							const productItem = JSON.parse(JSON.stringify(productResponse));
							// declare an array to hold the product and its variant
							let data = [];
							for (let i = 0; i < productItem.length; i += 1){
								// query inventory variants
								let searchVariants = `SELECT product_id, color_name, size, qty, code from inventory
																			INNER JOIN color
																			ON inventory.color_name = color.name WHERE product_id = ${productItem[i].product_id}
																			ORDER BY product_id`;
								connection.query(searchVariants, function (err, inventoryVariants){
									if (err) throw err;
									let colorArray   = generateColorObj(inventoryVariants),
										sizeArray    = makeSizeObj(inventoryVariants),
										variantArray = generateVariant(inventoryVariants),
										mainImageURL = hostIP + productItem[i].main_image,
										imgArray     = makeImgArray(productItem[i].gallery);

									let productDetail = new NewProduct(
										productItem[i].product_id,
										productItem[i].title,
										productItem[i].description,
										productItem[i].price,
										productItem[i].texture,
										productItem[i].wash,
										productItem[i].place,
										productItem[i].note,
										productItem[i].story,
										colorArray,
										sizeArray,
										variantArray,
										mainImageURL,
										imgArray
									);
									if (id) {
										client.set(cacheKey, JSON.stringify({data: productDetail}), 'EX', cacheExpireTime);
										res.send(JSON.stringify({data: productDetail}));
									}
									else {
										data.push(productDetail);
										// when the loop ends (runs to last product item and i starts from 0) send to response
										if ( i === productItem.length - 1){
											if (paging) {
												if (parseInt(paging) === lastPage){
													res.send(JSON.stringify({data: data}))
												}
												else {
													res.send(JSON.stringify({paging: parseInt(paging) + 1, data: data}));
												}
											}
											else if (!paging) {
												if (parseInt(tempPaging) === lastPage){
													res.send(JSON.stringify({data: data}))
												}
												else {
													res.send(JSON.stringify({paging: parseInt(tempPaging) + 1, data: data}));
												}
											}
										}
									}

								}) //End of query temp table
							} // End of for loop
						} // End of else
					}) // End of mysql.con.query Product

				} // End of else (if no cache, search in database)
			}); // End of client.get

		}) // End of query product count
	}) // End of conPool getConnection

}); // End of router get

// ----- End of product list api -----
// ----- Start of marketing api -----

router.get('/marketing/campaigns', function(req, res) {
	let key = 'campaignCache';
	client.get(key, function(err, reply){
		if (reply){
			res.send(reply);
		}
		else {
			const queryCampaign = `SELECT * FROM campaign`;
			mysql.conPool.getConnection((err,connection) => {
				connection.query(queryCampaign, function (err, queCamResult) {
					const campaignObj = JSON.parse(JSON.stringify(queCamResult));
					for (let i = 0; i < campaignObj.length; i++){
						campaignObj[i].picture = hostIP + campaignObj[i].picture;
					}
					client.set(key, JSON.stringify({data:campaignObj}), 'EX', cacheExpireTime);
					connection.release();
					res.send(JSON.stringify({data:campaignObj}));
				})
			})
		}
	});
}); // End of router get

module.exports = router;
