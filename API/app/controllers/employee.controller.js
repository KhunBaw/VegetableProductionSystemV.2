const validate_req = require('../models/validate_req.models')
const db = require('../config/db')
const { hashPassword } = require('../models/hashing.models')
const fs = require('fs')
const { promisify } = require('util')
const unlinkAsync = promisify(fs.unlink)
const { getPathImage } = require('../models/upload.models')

exports.create = async (req, res) => {
  //ดึงข้อมูลจาก request
  const { username, password, emp_name, emp_phnum, emp_address, emp_position } =
    req.body
  //ตรวจสอบความถูกต้อง request
  if (validate_req(req, res, [username, password, emp_name])) return
  //คำสั่ง SQL
  let sql = `INSERT INTO employee (username, password, emp_name,emp_phnum,emp_address,emp_photo,emp_position) VALUES (?,?,?,?,?,?,?)`
  //เพิ่มข้อมูล โดยส่งคำสั่ง SQL เข้าไป
  try {
    const [rows] = await db.execute(sql, [
      username,
      hashPassword(password),
      emp_name,
      emp_phnum,
      emp_address,
      req.file.filename || 'default.png',
      emp_position,
    ])
    if (rows.affectedRows != 0) res.status(204).end()
    else {
      await unlinkAsync(req.file.path)
      res.status(400).json({
        message: 'เพิ่มไม่สำเร็จ',
      })
    }
  } catch (error) {
    await unlinkAsync(req.file.path)
    if (error.errno == 1062) {
      res.status(400).json({
        message: error.message,
      })
    } else res.status(400).send(error)
  }
}

exports.findAll = async (req, res) => {
  //คำสั่ง SQL
  let sql = `SELECT emp_id,username,emp_name,emp_phnum,emp_address,emp_photo,emp_position,role FROM employee`
  //ดึงข้อมูล โดยส่งคำสั่ง SQL เข้าไป
  try {
    const [rows] = await db.execute(sql)
    res.status(200).json(rows)
  } catch (error) {
    res.status(400).send(error)
  }
}

exports.findOne = async (req, res) => {
  //ดึงข้อมูลจาก params
  const { id } = req.params
  // ตรวจสอบความถูกต้อง request
  if (validate_req(req, res, [id])) return
  //คำสั่ง SQL
  let sql = `SELECT emp_id,username,emp_name,emp_phnum,emp_address,emp_photo,emp_position,role FROM employee WHERE emp_id = ?`
  //ดึงข้อมูล โดยส่งคำสั่ง SQL เข้าไป
  try {
    const [rows] = await db.execute(sql, [id])
    const data = rows[0]
    if (data) {
      res.status(200).json(rows)
    } else res.status(204).end()
  } catch (error) {
    res.status(400).send(error)
  }
}

exports.update = async (req, res) => {
  //ดึงข้อมูลจาก request
  const { emp_name, emp_phnum, emp_address, emp_photo, emp_position } = req.body
  //ดึงข้อมูลจาก params
  const { id } = req.params
  //ตรวจสอบความถูกต้อง request
  if (validate_req(req, res, [id])) return
  //คำสั่ง SQL
  let sql = `UPDATE employee SET emp_name = ?,emp_phnum = ?,emp_address = ?,emp_photo = ?,emp_position = ? WHERE emp_id = ?`
  //แก้ไขข้อมูล โดยส่งคำสั่ง SQL เข้าไป
  try {
    const [rows] = await db.execute(sql, [
      emp_name,
      emp_phnum,
      emp_address,
      emp_photo,
      emp_position,
      id,
    ])
    if (rows.affectedRows != 0) res.status(204).end()
    else
      res.status(400).json({
        message: 'อัพเดทไม่สำเร็จ',
      })
  } catch (error) {
    res.status(400).send(error)
  }
}

exports.deleteOne = async (req, res) => {
  //ดึงข้อมูลจาก params
  const { id } = req.params
  //ตรวจสอบความถูกต้อง request
  if (validate_req(req, res, [id])) return
  //คำสั่ง SQL
  let sql = `DELETE FROM employee WHERE emp_id = ? AND role != 'admin'`
  //ลบข้อมูล โดยส่งคำสั่ง SQL และ id เข้าไป
  try {
    const [rows] = await db.execute(sql, [id])
    if (rows.affectedRows != 0) res.status(204).end()
    else
      res.status(400).json({
        message: 'ลบไม่สำเร็จ',
      })
  } catch (error) {
    res.status(400).send(error)
  }
}

exports.profile = async (req, res) => {
  const { name } = req.params
  const file = getPathImage('profile', name)
  res.status(200).sendFile(file)
}
