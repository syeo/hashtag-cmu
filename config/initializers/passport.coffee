LocalStrategy = require("passport-local").Strategy

module.exports = (passport, registry) ->

  # Serialize the user id to push into the session
  passport.serializeUser((user, done) ->
    done(null, user.id)
  )

  passport.deserializeUser((id, done) ->
    userRepository = registry.instance().userRepository
    userRepository.findById(id)
      .then((user) ->
        if user?
          done(null, user)
        else
          done(null, false)
      )
      .catch(done)
      .done()
  )

  # Use local strategy
  passport.use(new LocalStrategy({
    usernameField: "email"
    passwordField: "password"
  }, (email, password, done) ->
    userRepository = registry.instance().userRepository
    userRepository.findByEmail(email)
      .then((user) ->
        if user?.authenticate(password)
          done(null, user)
        else
          done(null, false, {
            message: 'Incorrect email or password.'
          })
      )
      .catch(done)
      .done()
  ))
