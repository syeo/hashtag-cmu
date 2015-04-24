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

debug = require('../debug')('sign_up_page:component')

SignUpPage = React.createClass({
  displayName: 'SignUpPage'

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
      firstName: ''
      lastName: ''
      email: ''
      password: ''
    }

  makeStateFromRefs: () ->
    {
      firstName: @refs.firstName.getValue()
      lastName: @refs.lastName.getValue()
      email: @refs.email.getValue()
      password: @refs.password.getValue()
    }

  handleFormDataChange: () ->
    @setState(@makeStateFromRefs())

  handleClick: () ->
    debug(@state)
    UserService.signUp({
      email: @state.email
      password: @state.password
      firstName: @state.firstName
      lastName: @state.lastName
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
    <div className='sign-up-page'>
      <div className='container'>
        <div className='row'>
          <div className={colClasses}>
            <div className='card sign-up-card'>
              <form className='sign-up-form'>
                <Input type='text'
                       ref='firstName'
                       onChange={@handleFormDataChange}
                       value={@state.firstName}
                       placeholder='First Name'
                       name='first-name' />
                <Input type='text'
                       ref='lastName'
                       onChange={@handleFormDataChange}
                       value={@state.lastName}
                       placeholder='Last Name'
                       name='last-name' />
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
                <Button bsStyle='primary'
                        block
                        onClick={@handleClick}>
                  Sign Up
                </Button>
              </form>
              <div className='auxiliary'>
                <div className='existing-user'>
                  <span className='description'>Have an account?</span>
                  <Link to="log-in">Log in</Link>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

})

module.exports = SignUpPage
