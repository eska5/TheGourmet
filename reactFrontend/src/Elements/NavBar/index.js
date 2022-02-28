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
                            <NavLinks to='/' activeStyle>Dodaj potrawę</NavLinks>
                        </NavItem>
                        <NavItem>
                            <NavLinks to="/identifier" activeStyle>Rozpoznaj potrawę</NavLinks>
                        </NavItem>
                    </NavMenu>
                    <NavButton>
                        <NavButtonLink to="/info">Informacja</NavButtonLink>
                    </NavButton>
                </NavbarContainer>
            </Nav>
        </>
    );
};

export default NavBar;

