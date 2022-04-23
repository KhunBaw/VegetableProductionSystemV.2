const multer = require('multer')
const path = require('path')
const part = process.env.PART
const whitelist = ['image/png', 'image/jpeg', 'image/jpg', 'image/webp']

const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, part + file.fieldname)
  },
  filename: function (req, file, cb) {
    const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1e9)
    const type = file.originalname.substring(file.originalname.lastIndexOf('.'))
    const name = uniqueSuffix + type
    cb(null, name)
  },
})

const upload = multer({
  storage: storage,
  limits: { fileSize: 20971520 },
  fileFilter: (req, file, cb) => {
    if (!whitelist.includes(file.mimetype)) {
      return cb(new Error('file is not allowed'))
    }

    cb(null, true)
  },
})

const getPathImage = (fieldname, name) => {
return part + fieldname + '/' + name;
}

module.exports = { upload, getPathImage }
