import React from 'react'
import { SideBarCointainer,Icon,CloseIcon,SideBarLink,SideBarWrapper,SideBarRoute,SideButton,SideBarMenu } from './SideBarDecorations';

const SideBar = ({isOpen, toggle}) => {
    return (
        <>
          <SideBarCointainer isOpen={isOpen} onClick={toggle}>
            <Icon onClick={toggle}>
                <CloseIcon/>    
            </Icon>
            <SideBarWrapper>
                <SideBarMenu>
                    <SideBarLink to='/' activeStyle onClick={toggle}>Dodaj potrawę </SideBarLink>
                    <SideBarLink to="/identifier" activeStyle onClick={toggle}>Rozpoznaj potrawę</SideBarLink>
                </SideBarMenu>
                <SideButton>
                    <SideBarRoute to="/info">Informacja</SideBarRoute>
                </SideButton>
            </SideBarWrapper>
          </SideBarCointainer>  
        </>
    )
}

export default SideBar
