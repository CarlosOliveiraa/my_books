const express = require('express')
const authMiddleware = require('../middlewares/auth')


module.exports = (db) => {
    const router = express.Router()

    //Get All Books
    router.get('/allbooks', authMiddleware, async (req, res) => {
        try {
            const query = `SELECT * FROM books`
            db.query(query, (err, result) => {
                if (err) {
                    console.err('Erro na consulta', err)
                    res.status(400).json({ error: 'Erro na consulta do banco' })
                }
                console.log('Resultado da consulta', result)
                res.status(200).send(result)

            })
        } catch (error) {
            console.error('Erro ao pesquisar os dados', error);
            res.status(500).json({ error: 'Erro ao pesquisar os dados' });
        }
    })

    //Register books
    router.post('/insertbook', async (req, res) => {
        const { title, pages, description, image, userid } = req.body; // Use 'userId' aqui

        if (!title || !pages || !description || !image || !userid) {
            return res.status(400).json({ error: 'Todos os campos são obrigatórios' });
        }

        const query = `INSERT INTO books (title, pages, description, image, user_id) VALUES (?, ?, ?, ?, ?)`;

        db.query(query, [title, pages, description, image, userid], function (err) { // Use 'userId' aqui também
            if (err) {
                console.error('Erro ao inserir livro:', err);
                return res.status(500).json({ error: 'Erro ao inserir livro' });
            }

            res.status(200).send('Livro inserido com sucesso');
        });
    });

    //Update books
    router.post('/update', async (req, res) => {
        const { id, title, pages, description, image } = req.body;
        const query = `UPDATE books SET title = ?, pages = ?, description = ?, image = ? WHERE id = ?`; // Corrigindo o nome do campo WHERE

        db.query(query, [title, pages, description, image, id], function (err) {
            if (err) {
                console.error('Erro ao atualizar livro:', err);
                return res.status(500).json({ error: 'Erro ao atualizar livro' });
            }

            res.status(200).send('Livro atualizado com sucesso');
        });
    });



    //Remove books
    router.post('/remove/:id', async (req, res) => {
        const { id } = req.params

        const sql = `DELETE FROM books WHERE id = ?`

        db.query(sql, [id], (err, result) => {
            if (err) {
                console.log(err)
                res.status(400).json({ error: 'Erro ao remover dados' })
            }
            res.status(201).json({ message: 'Item removido com sucesso' })
        })
    })

    return router
}