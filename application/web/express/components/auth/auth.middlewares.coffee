module.exports =
  loginRequired: (req, res, next) ->
    if req.user
      next()
    else
      res.status(401).json({
        user: undefined,
        message: 'Log-in required.'
      })