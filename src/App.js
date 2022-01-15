import './App.css';
import {BrowserRouter as Router, HashRouter} from 'react-router-dom'
import Home from './Pages';


function App() {
  return (
    <Router>
      <Home/>
    </Router>
  );
}

export default App;
