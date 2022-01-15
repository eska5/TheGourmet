import React from 'react'
import {FaBars} from 'react-icons/fa'
import {Nav,NavbarContainer, NavLogo, MobileIcon, NavMenu, NavItem, NavLinks, NavButton, NavButtonLink} from './NavBarDecorations'


const NavBar = ( {toggle} ) => {
    return (
        <>
            <Nav>
                <NavbarContainer>
                    <NavLogo to='/'>Gourmet</NavLogo>
                    <MobileIcon onClick={ toggle }>
                        <FaBars />
                    </MobileIcon>
                    <NavMenu>
                        <NavItem>
                            <NavLinks to="subpage1">Subpage1</NavLinks>
                        </NavItem>
                        <NavItem>
                            <NavLinks to="subpage2">Subpage2</NavLinks>
                        </NavItem>
                    </NavMenu>
                    <NavButton>
                        <NavButtonLink to="/button">Click me</NavButtonLink>
                    </NavButton>
                </NavbarContainer>
            </Nav>
        </>
    );
};

export default NavBar;

