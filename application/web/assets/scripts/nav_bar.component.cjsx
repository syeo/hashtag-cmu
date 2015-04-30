React = require('react')
ReactBootstrap = require('react-bootstrap')
Router = require('react-router')

{
  Navbar
  Nav
  NavItem
  Input
  CollapsableNav
  Glyphicon
  Button
} = ReactBootstrap

Link = Router.Link
# DropdownButton = ReactBootstrap.DropdownButton
# MenuItem = ReactBootstrap.MenuItem

NavBar = React.createClass
  displayName: 'NavBar'

  contextTypes:
    router: React.PropTypes.func

  handleAddClick: () ->
    @context.router.transitionTo('poster-new')

  render: ->
    brand = <Link to="home">#CMU</Link>

    <Navbar brand={brand} fixedTop toggleNavKey={0}>
      <CollapsableNav eventKey={0}>
        <Nav navbar right>
          <NavItem href='/posters/new'>
            <Glyphicon glyph='plus' />
          </NavItem>
        </Nav>
      </CollapsableNav>
    </Navbar>

module.exports = NavBar