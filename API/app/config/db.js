const mysql = require('mysql2/promise') // เรียกใช้งาน MySQL module

// กำหนดการเชื่อมต่อฐานข้อมูล
const db = mysql.createPool({
  //ip ของ sql
  host: process.env.DB_HOST,
  // port ของ sql
  port: process.env.DB_PORT,
  //username ของ sql
  user: process.env.DB_USER,
  //password ของ sql
  password: process.env.DB_PASSWORD,
  //ชื่อ data ของ sql
  database: process.env.DB_DATABASE,
  charset: 'utf8mb4',
})

module.exports = db
