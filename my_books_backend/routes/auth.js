const express = require('express');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');

module.exports = (db) => {
    const router = express.Router();

    // Endpoint de registro
    router.post('/register', async (req, res) => {
        const { name, email, password, imageProfile } = req.body;

        console.log('Request Body:', req.body);

        if (!name || !email || !password) {
            return res.status(400).json({ error: 'Todos os campos são obrigatórios' });
        }

        try {
            const hashedPassword = await bcrypt.hash(password, 10);
            db.query(
                'INSERT INTO users (name, email, password, imageProfile) VALUES (?, ?, ?, ?)',
                [name, email, hashedPassword, imageProfile],
                (err, result) => {
                    if (err) {
                        if (err.code === 'ER_DUP_ENTRY') {
                            console.error('Erro de duplicidade:', err);
                            return res.status(409).json({ error: 'Usuário ou email já existe' });
                        }
                        console.error('Erro ao inserir no banco de dados:', err);
                        return res.status(500).json({ error: 'Erro ao registrar usuário' });
                    }

                    if (!result) {
                        console.error('Resultado indefinido ao inserir no banco de dados');
                        return res.status(500).json({ error: 'Erro ao registrar usuário' });
                    }

                    console.log('Resultado da inserção:', result);
                    res.status(201).json({ id: result.insertId });
                }
            );
        } catch (error) {
            console.error('Erro ao registrar usuário:', error);
            res.status(500).json({ error: 'Erro ao registrar usuário' });
        }
    });

    // Endpoint de login
    router.post('/login', async (req, res) => {
        const { email, password } = req.body;

        db.query('SELECT * FROM users WHERE email = ?', [email], async (err, results) => {
            if (err) {
                return res.status(500).json({ error: 'Erro ao fazer login' });
            }
            if (results.length === 0) {
                return res.status(404).json({ error: 'Usuário não encontrado' });
            }

            const user = results[0];
            const isPasswordValid = await bcrypt.compare(password, user.password);
            if (!isPasswordValid) {
                return res.status(401).json({ error: 'Senha inválida' });
            }

            const token = jwt.sign({ id: user.id }, 'seu_jwt_secreto', { expiresIn: '1h' });
            res.json({ token });
        });
    });

    router.post('/delete/:id', (req, res) => {
        const { id } = req.params

        const sql = `DELETE FROM users WHERE id = ?`

        db.query(sql, [id], (err, result) => {
            if (err) {
                console.log(err)
                res.status(400).json({ error: 'Erro ao remover dados' })
            }
            res.status(201).json({ message: 'Item removido com sucesso' })
        })
    })

    return router;
};
