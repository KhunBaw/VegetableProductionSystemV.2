module.exports = (app) => {
  const router = require('express').Router()
  const { verifytoken } = require('../models/middleware.models.js')
  const { create,findAll,findOne,update,deleteOne } = require('../controllers/employee.controller')

  router.post('/',verifytoken, create)

  router.get('/',verifytoken,findAll)

  router.get('/:id',verifytoken, findOne)

  router.put('/:id',verifytoken, update)

  // router.delete('/:id',verifytoken, deleteOne)

  //เซ็ต PREFIX
  app.use(process.env.PREFIX + '/employee', router)
}
