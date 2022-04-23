const validate_req = require('../models/validate_req.models')
const db = require('../config/db')
const { verifyingHash } = require('../models/hashing.models')
const { signtoken } = require('../models/middleware.models')

exports.login = async (req, res) => {
  //ดึงข้อมูลจาก request
  const { username, password } = req.body
  // ตรวจสอบความถูกต้อง request
  if (validate_req(req, res, [username, password])) return
  //คำสั่ง SQL
  let sql = `SELECT * FROM employee WHERE username = ?`
  //ดึงข้อมูล โดยส่งคำสั่ง SQL เข้าไป
  // await db.execute(sql, [username])
  try {
    const [rows] = await db.execute(sql, [username])
    const data = rows[0]
    if (data && verifyingHash(password, data.password)) {
      data.token = await signtoken({ emp_id: data.emp_id }, '15d')
      delete data.password
      res.status(200).json(data)
    } else res.status(204).end()
  } catch (error) {
    res.status(400).send(error)
  }
}

exports.personal = async (req, res) => {
  //ดึงข้อมูลจาก request
  const { emp_id } = req.authData
  // ตรวจสอบความถูกต้อง request
  if (validate_req(req, res, [])) return
  //คำสั่ง SQL
  let sql = `SELECT * FROM employee WHERE emp_id = ?`

  try {
    //ดึงข้อมูล โดยส่งคำสั่ง SQL เข้าไป
    const [rows] = await db.execute(sql, [emp_id])
    const data = rows[0]
    data.token = await signtoken({ emp_id: emp_id }, '15d')
    delete data.password
    res.status(200).json(data)
  } catch (error) {
    res.status(400).send(error)
  }
}
