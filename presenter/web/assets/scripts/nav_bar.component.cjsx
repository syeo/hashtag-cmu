React = require('react')
ReactBootstrap = require('react-bootstrap')

Navbar = ReactBootstrap.Navbar
Nav = ReactBootstrap.Nav
NavItem = ReactBootstrap.NavItem
Input = ReactBootstrap.Input
# DropdownButton = ReactBootstrap.DropdownButton
# MenuItem = ReactBootstrap.MenuItem

NavTopBar = React.createClass

  render: ->
    <Navbar fixedTop toggleNavKey={0}>
      <form className="navbar-form navbar-left no-left-padding">
        <Input type='text' addonAfter='search' addonBefore='#CMU'/>
      </form>
      <Nav right eventKey={0}>
        <NavItem href='/'>Home</NavItem>
      </Nav>
    </Navbar>

module.exports = NavTopBar