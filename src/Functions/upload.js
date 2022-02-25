export const sendToServer = (foodname,foodimage) => {
    const backend = 'http://localhost:8080'
    const xhttp = new XMLHttpRequest();
    xhttp.open("POST", backend + '/api/', true);
    const request = {
        'name': foodname,
        'img': foodimage,
    };
    xhttp.setRequestHeader('Content-Type', 'application/json');
    xhttp.send(JSON.stringify(request));
}

