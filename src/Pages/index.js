import React, {useState} from 'react'
import NavBar from '../Elements/NavBar';
import SideBar from '../Elements/SideBar';
import MainSection from '../Elements/MainSection';

const Home = () => {
    const [isOpen, setIsOpen] = useState(false)

    const toggleSideBar = () => {
        setIsOpen(!isOpen)
    }


    return (
        <>
            <SideBar isOpen={isOpen} toggle={toggleSideBar}/>
            <NavBar toggle={toggleSideBar}/>
            <MainSection />
        </>
    )
}

export default Home
