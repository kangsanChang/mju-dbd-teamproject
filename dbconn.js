var mysql = require('mysql');
var util = require('util');
var pool = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: 'your-passwd', // do not push with your password.
  database: 'dbd_project'
});

// node 8 version 이상.
// https://medium.com/@matthagemann/create-a-mysql-database-middleware-with-node-js-8-and-async-await-6984a09d49f4
pool.query = util.promisify(pool.query); // magic happens here! (async await 적용하기 위함. node)

module.exports = pool;