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
                    <SideBarLink to="subpage1" onClick={toggle}>Subpage1 </SideBarLink>
                    <SideBarLink to="subpage2" onClick={toggle}>Subpage2</SideBarLink>
                    <SideBarLink to="subpage3" onClick={toggle}>Subpage3</SideBarLink>
                    <SideBarLink to="subpage4" onClick={toggle}>Subpage4</SideBarLink>
                </SideBarMenu>
                <SideButton>
                    <SideBarRoute to="/button">Click me</SideBarRoute>
                </SideButton>
            </SideBarWrapper>
              
              
          </SideBarCointainer>  
        </>
    )
}

export default SideBar
