import './App.css';
import {BrowserRouter as Router} from 'react-router-dom'
import Home from './Pages';
import React from 'react';

function App() {
  return (
    <Router>
      <Home/>
    </Router>
  );
}
export default App;
