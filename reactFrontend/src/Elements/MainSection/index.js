import React, {useState, useRef, useEffect} from 'react'
import { MainContainer,InputBar, InputWrapper, Button,MainButtonWrapper,ImagePreview, MainContent,FooterWrapper,ImageUploadContent,ImageButtonWrapper} from './MainSectionDecorations'
import '../Styles/suggestions.css'
import Resizer from "react-image-file-resizer";
const MainSection = () => { 
    const backendURL =  'http://localhost:5000';
    //const backendURL = 'https://gourmet.hopto.org:5000'
    const inputBarRef = useRef();
    const [hover, setHover] = useState(false)
    const [previewUrl,setPreviewUrl] = useState(null);
    const filePickerRef = useRef();
    const [foodname,setFoodName] = useState("");
    const [foodimage,setFoodImage] = useState("");
    const [foodNames,setFoodNames] = useState("");
    const onHover = () => {
      setHover(!hover)
    }
    useEffect(() => {
        window.addEventListener('click', (event) => {
            var container = document.getElementById('suggestionbox');
            var tmp = document.getElementsByClassName('suggestion-item');
            if(container !== null)
            {
                if (!container.contains(event.target) && tmp.length !== 0) {
                    clearSuggestions();
                }
            }
            
        });
      }, []);
    function ImageHandler(event) {
      if(event.target.files && event.target.files.length===1 )
      {
        var file = event.target.files[0];
        Resizer.imageFileResizer(
            file,
            400,
            400,
            "JPEG",
            100,
            0,
            (uri) => {
              const base64String = uri.replace("data:", "").replace(/^.+,/, "");
              setFoodImage(base64String);
            },
            "base64",
            300,
            300
          ); 
        setPreviewUrl(URL.createObjectURL(event.target.files[0]));
        document.getElementById("imgbtn").innerText = "Edytuj zdjęcie";
      }
    }

    function pickedImageHandler() {
      filePickerRef.current.click(); //wywolanie klikniecia inputu, ktory jest niewidzialny
    }
    
    function handleSubmit() {
        if (foodname === "")
        {
            alert('Nie wprowadzono żadnej nazwy!');
        }
        if (foodimage === "")
        {
            alert('Nie wybrano zdjęcia!');
        }
        else
        {
            alert('Podano następującą potrawę: ' + foodname);
            handleRequest(foodname,foodimage)
        }
      }
    window.onload = function getSuggestions()
    {
        var xmlHttp = new XMLHttpRequest();
        xmlHttp.open( "GET", backendURL + '/suggestions', false ); // false for synchronous request
        xmlHttp.send( null );
        var sug = JSON.parse(xmlHttp.response);
        setFoodNames(sug)
    }
    function handleRequest(foodname,foodimage)
    {
        const xhttp = new XMLHttpRequest();
        var res;
        xhttp.open("POST", backendURL + '/meals', true);
        const request = {
            'mealName': foodname,
            'mealPhoto': foodimage,
        };
        xhttp.onreadystatechange = function() {
            if (xhttp.readyState === 4) {
            res = JSON.parse(xhttp.response)
            console.log(res)
            alert(foodname + ' został pomyślnie zapisany');
            setFoodNames(res)
            }
        }
        xhttp.setRequestHeader('Content-Type', 'application/json');
        xhttp.send(JSON.stringify(request));
    }
    function clearSuggestions() {
        var x = document.getElementsByClassName("suggestion-item");
        var n = x.length;
        var y = document.getElementsByClassName("suggestion-list");
        for (var i = 0; i < n; i++) {
            x[0].parentNode.removeChild(x[0]);
        }
        if(y.length !== 0)
        {
            y[0].parentNode.removeChild(y[0]);
        }
        
    }

    function handleChange(event) {
        clearSuggestions();
        //getSuggestions();
        var b,a; 
        var inputValue = document.getElementById("foodinput").value;
        if(inputValue !== '')
        {
            a = document.createElement("ul")
            a.setAttribute("class", "suggestion-list");
            a.setAttribute("id", "suggestionbox");
            document.getElementById('inputwrapper').appendChild(a);
            var actualHeight = 0;
            for (var i = 0; i < foodNames.length; i++)
            {
                if(foodNames[i].substring(0,inputValue.length).toUpperCase() === inputValue.toUpperCase() && inputValue !== '')
                {
                    b = document.createElement("li");
                    if(actualHeight < 250)
                    {
                        actualHeight += 43;
                    }
                    a.style.setProperty('--height',actualHeight+'px')
                    b.innerHTML="<span class='firstLetter'>" + foodNames[i].substring(0,inputValue.length) + "</span>";
                    b.innerHTML += foodNames[i].substring(inputValue.length,foodNames[i].length);
                    b.innerHTML += "<input type='hidden' value='" + foodNames[i] + "'>";
                    b.setAttribute("class", "suggestion-item");
                    b.addEventListener("click", function(e) {
                        document.getElementById('foodinput').value = this.getElementsByTagName("input")[0].value;
                        setFoodName(event.target.value);
                        clearSuggestions();
                    });
                    a.appendChild(b);
                }
            }
        }
        setFoodName(event.target.value); //jeśli się stanie zdarzenie(OnChange), wez element który je spowodował(target) i jego wartość(value)
    }
    return (
        <>
        <MainContainer>
            {/* obniżyć przycisk wybierz zdjęcie, na urządzeniach mobilnych zmiejszyć imagepreview */}
            {/* <Autocomplete suggestions={["Oranges", "Orangutan", "Apples", "Banana", "Kiwi", "Mango"]}/> */}
            <InputWrapper id="inputwrapper">
                {/* <SuggestionList id="suggestionbox"/> */}
                <InputBar id="foodinput" ref={inputBarRef} value={foodname} type="text" placeholder='Nazwij swoje jedzenie' onChange={handleChange}/>
            </InputWrapper>
            
            <MainContent>
                <MainButtonWrapper>
                  <Button type="submit" value="Submit" onMouseEnter={onHover} onMouseLeave={onHover} onClick={handleSubmit}>
                      Wyślij
                  </Button>
                </MainButtonWrapper>     
            </MainContent>   
            <ImageUploadContent>
                <ImageButtonWrapper>
                <input ref = {filePickerRef} style = {{display:"none"}} type = "file" accept=".jpg,.png,.jpeg" onChange={ImageHandler} />
                    <Button id="imgbtn" type="button" onMouseEnter={onHover} onMouseLeave={onHover} onClick={pickedImageHandler}>
                        Wybierz zdjęcie 
                    </Button>
                </ImageButtonWrapper>
                <ImagePreview>
                    <img height="300px" width="300px" src={previewUrl} alt="preview"/>
                </ImagePreview>
            </ImageUploadContent>

            <FooterWrapper>Jakub Sachajko & Łukasz Niedźwiadek © 2022</FooterWrapper>
        </MainContainer>
        </>
    )
}

export default MainSection