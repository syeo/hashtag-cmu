React = require('react')
ReactBootstrap = require('react-bootstrap')

Navbar = ReactBootstrap.Navbar
Nav = ReactBootstrap.Nav
NavItem = ReactBootstrap.NavItem
# DropdownButton = ReactBootstrap.DropdownButton
# MenuItem = ReactBootstrap.MenuItem

NavTopBar = React.createClass

  render: ->
    <Navbar brand='#CMU' fixedTop toggleNavKey={0}>
      <Nav right eventKey={0}>
        <NavItem href='/'>Home</NavItem>
      </Nav>
    </Navbar>

module.exports = NavTopBar