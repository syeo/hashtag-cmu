React = require('react')
ReactBootstrap = require('react-bootstrap')
Router = require('react-router')

Navbar = ReactBootstrap.Navbar
Nav = ReactBootstrap.Nav
NavItem = ReactBootstrap.NavItem
Input = ReactBootstrap.Input
CollapsableNav = ReactBootstrap.CollapsableNav
Glyphicon = ReactBootstrap.Glyphicon
Link = Router.Link
# DropdownButton = ReactBootstrap.DropdownButton
# MenuItem = ReactBootstrap.MenuItem

NavBar = React.createClass
  displayName: 'NavBar'

  render: ->
    brand = <Link to="home">#CMU</Link>

    <Navbar brand={brand} fixedTop toggleNavKey={0}>
      <CollapsableNav eventKey={0}>
        <form className="navbar-form navbar-left" role="search">
          <Input type='text' addonAfter={<Glyphicon glyph='search' />} />
        </form>
      </CollapsableNav>
    </Navbar>

module.exports = NavBar