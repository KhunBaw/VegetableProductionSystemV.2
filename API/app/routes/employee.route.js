module.exports = (app) => {
  const router = require('express').Router()
  const { verifytoken } = require('../models/middleware.models')
  const { create,findAll,findOne,update,deleteOne,profile } = require('../controllers/employee.controller')
  const {upload} = require('../models/upload.models')

  router.post('/',verifytoken,upload.single('profile'), create)

  router.get('/',verifytoken,findAll)

  router.get('/:id',verifytoken, findOne)

  router.put('/:id',verifytoken, update)

  router.delete('/:id',verifytoken, deleteOne)

  router.get('/profile/:name',verifytoken,profile)

  //เซ็ต PREFIX
  app.use(process.env.PREFIX + '/employee', router)
}
