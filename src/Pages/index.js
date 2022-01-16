import React, {useState} from 'react'
import NavBar from '../Elements/NavBar';
import SideBar from '../Elements/SideBar';
import MainSection from '../Elements/MainSection';
import { Helmet } from 'react-helmet';

const Home = () => {
    const [isOpen, setIsOpen] = useState(false)

    const toggleSideBar = () => {
        setIsOpen(!isOpen)
    }

    return (
        <>
        //dać credity dla autra iconki z flaticon.com
        <Helmet><title>Gourmet FoodApp</title></Helmet>
            <SideBar isOpen={isOpen} toggle={toggleSideBar}/>
            <NavBar toggle={toggleSideBar}/>
            <MainSection />
        </>
    )
}

export default Home
