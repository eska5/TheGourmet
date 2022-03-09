export const sendToServer = (foodname,foodimage) => {
    const backend = 'http://localhost:5000'
    const xhttp = new XMLHttpRequest();
    var res;
    xhttp.open("POST", backend + '/meals', true);
    const request = {
        'mealName': foodname,
        'mealPhoto': foodimage,
    };
    xhttp.onreadystatechange = function() {
        if (xhttp.readyState === 4) {
          res = JSON.parse(xhttp.response)
          console.log(res)
          return res
        }
      }
    xhttp.setRequestHeader('Content-Type', 'application/json');
    xhttp.send(JSON.stringify(request));
}

