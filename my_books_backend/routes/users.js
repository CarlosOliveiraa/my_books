const express = require('express');

module.exports = (db) => {
    const router = express.Router()


    router.post('/userdata/:id', async (req, res) => {
        const { id } = req.params;

        try {
            db.query('SELECT * FROM users WHERE id = ?', [id], (err, results) => {
                if (err) {
                    return res.status(500).json({ error: 'Erro ao buscar usuário' });
                }
                if (results.length === 0) {
                    return res.status(404).json({ error: 'Usuário não encontrado' });
                }

                // Retornar os dados do usuário
                res.status(200).json(results[0]);
            });
        } catch (error) {
            res.status(500).json({ error: 'Erro interno do servidor' });
        }
    });

    return router
}