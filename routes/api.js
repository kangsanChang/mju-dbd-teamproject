var express = require('express');
var router = express.Router();

const db = require('../dbconn.js');

router.post('/login', (req, res, next) => {
  db.query("SELECT * FROM EMP WHERE ID='"+req.body.id+"'", (err, rows, field) => {
    if (!err){
      if(rows.length == 0)
        return res.send({ error: "Login failed" });
      if(rows[0].EMP_NUM == req.body.emp_num)
        res.redirect('/projects');
      else
        res.send({ error : "Login failed"});
    }
    else
      console.log(err);
  });
})

module.exports = router;
