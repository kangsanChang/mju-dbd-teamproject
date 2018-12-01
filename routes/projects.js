var express = require('express');
var router = express.Router();

const db = require('../dbconn.js');

router.get('/', (req, res, next) => {
  db.query("SELECT * FROM PRJCT, CLTCDSRT WHERE ORNT=CLTCD ORDER BY ENDDE desc", (err, rows, field) => {
    let on_progress = [];
    let finished = [];
    rows.forEach(element => {
      if(element.ENDDE > Date.now())
        on_progress.push(element);
      else
        finished.push(element);
    });
    if (!err) {
      res.render('projects', { on_progress, finished });
    }
  })
})

router.get('/:project_num', async (req, res, next) => {
  let developers = [];
  let project_info;
  try{
    developers = await db.query("SELECT * FROM DEV NATURAL JOIN EMP JOIN DEV_PRJCT USING (EMP_NUM) WHERE PRJCT_NUM=" + req.params.project_num);
    project_info = await db.query("SELECT * FROM PRJCT, CLTCDSRT WHERE ORNT=CLTCD AND PRJCT_NUM=" + req.params.project_num);
  } catch(err) {
    throw new Error(err);
  } finally {
    developers.forEach(x => {
      switch(x.DTY) {
        case '10':
          x.DTY = 'PM'
          break;
        case '11':
          x.DTY = 'PL'
          break;
        case '12':
          x.DTY = '분석자'
          break;
        case '13':
          x.DTY = '설계자'
          break;
        case '14':
          x.DTY = '프로그래머'
          break;
        case '15':
          x.DTY = '테스터'
          break;
      }
    })
    console.log(developers);
    res.render('project_detail', { developers, info: project_info[0] });
  }
})

module.exports = router;
