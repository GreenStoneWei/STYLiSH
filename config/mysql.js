const mysql = require("mysql");
const mysqlPassword = require('./mysql.config.js');

const conPool = mysql.createPool({
    connectionLimit: 50,
    host:"localhost",
	user: mysqlPassword.user,
	password: mysqlPassword.password,
	database:"stylish"
})

module.exports = {
	core: mysql,
    conPool: conPool
};