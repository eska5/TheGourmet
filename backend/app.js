const express = require("express");
const app = express();
const fs = require('fs');
// Parse URL-encoded bodies (as sent by HTML forms)
app.use(express.urlencoded());

// Parse JSON bodies (as sent by API clients)
app.use(express.json());

app.get("/", (req, res) => {
    res.send("Hello World!");
  });

// Access the parse results as request.body
app.post('/', function(request, response){

  let name = request.body.foodname;
  name.toLowerCase();


  fs.appendFile('foodnames.txt', request.body.foodname + "\n", function (err) {
    if (err) 
      throw err;
    console.log('Saved ' + request.body.foodname );
  });
  response.send("http://localhost:3000/");
});

const PORT = process.env.PORT || 8080;
  
app.listen(PORT, console.log(`Server started on port ${PORT}`));