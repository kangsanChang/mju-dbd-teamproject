# MJU-DBD-TEAMPROJECT

## how to build

1. `npm i` (Need Node.js v^8)
2. install gulp (`npm install -g gulp`)
3. `gulp build` in semantic folder

## set up to start
0. before set up, install mysql in your local machine
1. Create database and insert data using ./sql/INSERT_ALL.sql file in your local machine
  - copy full path of INSERT_ALL.sql
  - `source [path]` in mysql client
2. set local mysql configuration in <b>dbconn.js</b>

## Start
1. `npm start`
2. project will run on localhost:3000