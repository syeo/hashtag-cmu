React = require('react')
ReactBootstrap = require('react-bootstrap')

Navbar = ReactBootstrap.Navbar
Nav = ReactBootstrap.Nav
NavItem = ReactBootstrap.NavItem
Input = ReactBootstrap.Input
CollapsableNav = ReactBootstrap.CollapsableNav
Glyphicon = ReactBootstrap.Glyphicon
# DropdownButton = ReactBootstrap.DropdownButton
# MenuItem = ReactBootstrap.MenuItem

NavTopBar = React.createClass

  render: ->
    <Navbar brand='#CMU' fixedTop toggleNavKey={0}>
      <CollapsableNav eventKey={0}>
        <Nav navbar>
          <form className="navbar-form">
            <Input type='text' addonAfter={<Glyphicon glyph='search' />} />
          </form>
        </Nav>
        <Nav navbar right>
          <NavItem href='/'>Home</NavItem>
        </Nav>
      </CollapsableNav>
    </Navbar>

module.exports = NavTopBar