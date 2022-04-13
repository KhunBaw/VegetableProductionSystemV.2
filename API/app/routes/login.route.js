module.exports = (app) => {
    const router = require('express').Router()
    const { verifytoken } = require('../models/middleware.models.js')
    const { login,personal } = require('../controllers/login.controller')
  
    router.post('/login', login)
    router.get('/login',verifytoken, personal)
    //เซ็ต PREFIX
    app.use(process.env.PREFIX, router)
  }