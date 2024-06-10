require('dotenv').config()
const express = require('express')
const mysql = require('mysql')
const app = express()

//Midlewares
app.use(express.json({ limit: '50mb' }))
app.use(express.urlencoded({ extended: true, limit: '50mb' }))





const conn = mysql.createConnection({
    host: process.env.HOST,
    user: process.env.DB_USER,
    password: process.env.PASSWORD,
    database: process.env.DATABASE,
})

conn.connect(function (err) {
    if (err) {
        console.log(err)
        return
    }

    console.log('Banco conectado com sucesso')

    app.listen(process.env.PORT)
})

//AuthRoutes
const authRoutes = require('./routes/auth')(conn)
app.use('/auth', authRoutes)

//BooksRoutes
const booksRoutes = require('./routes/books')(conn)
app.use('/books', booksRoutes)

//UserRoutes
const userRoutes = require('./routes/users')(conn)
app.use('/user', userRoutes)





