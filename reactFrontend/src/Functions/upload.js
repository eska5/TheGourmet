export const sendToServer = (foodname,foodimage) => {
    const backend = 'http://localhost'
    const xhttp = new XMLHttpRequest();
    xhttp.open("POST", backend + '/api/meals', true);
    const request = {
        'mealName': foodname,
        'mealPhoto': foodimage,
    };
    xhttp.setRequestHeader('Content-Type', 'application/json');
    xhttp.send(JSON.stringify(request));
}

