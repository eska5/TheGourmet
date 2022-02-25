import './App.css';
import {BrowserRouter as Router,Routes,Route} from 'react-router-dom'
import Home from './Pages';
import Identifier from './Pages/identifier';
import Info from './Pages/info';
import React, {useState} from 'react'
import NavBar from './Elements/NavBar';
import SideBar from './Elements/SideBar';
import { Helmet } from 'react-helmet';

function App() {
  const [isOpen, setIsOpen] = useState(false)

    const toggleSideBar = () => {
        setIsOpen(!isOpen)
    }

  return (
    <Router>
      <Helmet><title>Gourmet FoodApp</title></Helmet>
      <SideBar isOpen={isOpen} toggle={toggleSideBar}/>
      <NavBar toggle={toggleSideBar}/>
      <Routes>
        <Route exact path='/' active element={<Home/>} />
        <Route exact path='/identifier' element={<Identifier/>} />
        <Route exact path='/info' element={<Info/>} />
      </Routes>
    </Router>
  );
}
export default App;
