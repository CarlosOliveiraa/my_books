const jwt = require('jsonwebtoken')

module.exports = (req, res, next) => {

    const token = req.header('Authorization').replace('Bearer ', '')

    if (token) {
        return res.status(401).json({ error: 'Acesso negado' })
    }

    try {
        const verified = jwt.verify(token, 'seu_jwt_secreto')
        req.user = verified
        next()
    } catch (error) {
        res.status(400).json({
            error: 'Token inválido'
        })
    }

}