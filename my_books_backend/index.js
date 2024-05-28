const express = require('express')
const mysql = require('mysql')
const app = express()

//Midlewares
app.use(express.json())
app.use(express.urlencoded({ extended: true }))

const conn = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: 'K@ike963',
    database: 'nodemysql',
})

conn.connect(function (err) {
    if (err) {
        console.log(err)
        return
    }

    console.log('Banco conectado com sucesso')

    app.listen(3000)
})

//Routes
app.get('/allBooks', (req, res) => {

    const sql = `SELECT * FROM books`

    conn.query(sql, function (err, data) {
        if (err) {
            console.log(err)
            return
        }

        res.send(data)
        console.log(data)
    })


})

app.post('/books/insertbook', (req, res) => {
    const title = req.body.title
    const page = req.body.page
    const description = req.body.description
    const image = req.body.image


    const query = `INSERT INTO books (title, page, description, image) VALUES ('${title}', '${page}', '${description}', '${image}')`

    conn.query(query, function (err) {
        if (err) {
            console.log(err)
        }

    })
})

app.post('/books/update', (req, res) => {
    const title = req.body.title
    const page = req.body.page
    const description = req.body.description
    const image = req.body.image


    const query = `UPDATE books SET title = '${title}', page = '${page}', description = '${description}', image = '${image}' WHERE idbooks = ${id}')`

    conn.query(query, function (err) {
        if (err) {
            console.log(err)
        }

    })
})

app.post('/books/remove/:id', (req, res) => {
    const id = req.params.id

    const sql = `DELETE FROM books WHERE idbooks = ${id}`

    conn.query(sql, function (err, data) {
        if (err) {
            console.log(err)
            return
        }
    })
})
