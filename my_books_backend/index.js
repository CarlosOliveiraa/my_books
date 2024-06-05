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
    const pages = req.body.pages
    const description = req.body.description
    const image = req.body.image
    console.log(req.body)


    const query = `INSERT INTO books (title, pages, description, image) VALUES ('${title}', '${pages}', '${description}', '${image}')`

    conn.query(query, function (err) {
        if (err) {
            console.log(err)
        }

        res.status(200).send('Livro inserido com sucesso')
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

    const sql = `DELETE FROM books WHERE id = ${id}`

    conn.query(sql, function (err, data) {
        if (err) {
            console.log(err)
            return
        }
    })
})

// function base64toBlob(base64, mimeType) {
//     const binaryString = atob(base64);

//     const len = binaryString.length;

//     const bytes = new Uint8Array(len);
//     for (let i = 0; i < len; i++) {
//         bytes[i] = binaryString.charCodeAt(i);
//     }

//     return new Blob([bytes], { type: mimeType });
// }
