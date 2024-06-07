const jwt = require('jsonwebtoken')

module.exports = (req, res, next) => {

    const authHeader = req.header('Authorization')



    if (!authHeader) {
        return res.status(401).json({ error: 'Acesso negado' })
    }

    const token = authHeader.replace('Bearer ', '')

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