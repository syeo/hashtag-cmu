_ = require('lodash')
React = require('react')
ReactBootstrap = require('react-bootstrap')
classNames = require('classnames')
Router = require('react-router')

UserStore = require('../user/user.store')
UserService = require('../user/user.service')

Input = ReactBootstrap.Input
Button = ReactBootstrap.Button

Link = Router.Link

debug = require('../debug')('log_in_page:component')

LogInPage = React.createClass({
  displayName: 'LogInPage'

  contextTypes:
    router: React.PropTypes.func

  componentDidMount: ->
    UserStore.addChangeListener(@handleUserChange)

  componentWillUnmount: ->
    UserStore.removeChangeListener(@handleUserChange)

  handleUserChange: ->
    me = UserStore.getMe()
    if me?
      @context.router.transitionTo('home')

  getInitialState: ->
    {
      email: ''
      password: ''
    }

  makeStateFromRefs: () ->
    {
      email: @refs.email.getValue()
      password: @refs.password.getValue()
    }

  handleFormDataChange: () ->
    @setState(@makeStateFromRefs())

  handleSubmit: (e) ->
    debug(@state)
    e.preventDefault()
    UserService.logIn({
      email: @state.email
      password: @state.password
    })

  render: ->
    colClasses = classNames(
      'col-lg-6',
      'col-lg-offset-3',
      'col-md-6',
      'col-md-offset-3',
      'col-sm-12',
      'col-xs-12'
    )
    <div className='log-in-page'>
      <div className='container'>
        <div className='row'>
          <div className={colClasses}>
            <div className='card log-in-card'>
              <form className='log-in-form' onSubmit={@handleSubmit}>
                <Input type='email'
                       ref='email'
                       onChange={@handleFormDataChange}
                       value={@state.email}
                       placeholder='Email Address'
                       name='email' />
                <Input type='password'
                       ref='password'
                       onChange={@handleFormDataChange}
                       value={@state.password}
                       placeholder='Password'
                       name='password' />
                <Input type='submit'
                       value='Log In'
                       bsStyle='primary'
                       block />
              </form>
              <div className='auxiliary'>
                <div className='existing-user'>
                  <span className='description'>Not a user?</span>
                  <Link to="sign-up">Sign Up</Link>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

})

module.exports = LogInPage
