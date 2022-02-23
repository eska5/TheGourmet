import React, {useState, useRef, useEffect} from 'react'
import { MainContainer,InputBar,SuggestionList, InputWrapper, Button,MainButtonWrapper,ImagePreview, MainContent,FooterWrapper,ImageUploadContent,ImageButtonWrapper} from './MainSectionDecorations'
import '../Styles/suggestions.css'
const MainSection = () => { 

    const inputBarRef = useRef();
    const foodNames = ["kotlet","buraczki","mizeria","arbuz","mleko","melon","maliny","maczek","marucha","marchew", "mak","marcepan","mąka","mus owocowy","mango"];
    const [hover, setHover] = useState(false)
    const [previewUrl,setPreviewUrl] = useState(null);
    const filePickerRef = useRef();
    const [foodname,setFoodName] = useState("");
    const onHover = () => {
      setHover(!hover)
    }
    const [open, toggleOpen] = React.useState(false);

    const handleClose = () => {
        toggleOpen(false);
    };
    useEffect(() => {
        window.addEventListener('click', (event) => {
            var container = document.getElementsByClassName('suggestion-list');
            var tmp = document.getElementsByClassName('suggestion-item');
            if (!container.contains(event.target) && tmp.length !== 0) {
                clearSuggestions();
            }
        });
      }, []);

    function ImageHandler(event) {
      if(event.target.files && event.target.files.length===1 )
      {
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
        else
        {
            alert('Podano następującą potrawę: ' + foodname);
        }
      }
    function clearSuggestions(chosenFood) {
        var x = document.getElementsByClassName("suggestion-item");
        var y = document.getElementsByClassName("suggestion-list");
        // y[0].parentNode.removeChild(y[0]);
        var n = x.length;
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
        var a,b;
        a = document.createElement("ul");
        a.setAttribute("class", "suggestion-list");
        document.getElementById("inputwrapper").appendChild(a);
        var inputValue = document.getElementById("foodinput").value;
        for (var i = 0; i < foodNames.length; i++)
        {
            if(foodNames[i].substring(0,inputValue.length).toUpperCase() === inputValue.toUpperCase() && inputValue !== '')
            {
                b = document.createElement("li")
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
        setFoodName(event.target.value); //jeśli się stanie zdarzenie(OnChange), wez element który je spowodował(target) i jego wartość(value)
    }
    // function handleClick(event){
    //     var b; 
    //     for (var i = 0; i < foodNames.length; i++){
    //         b = document.createElement("li")
    //         b.innerHTML=foodNames[i];
    //         b.setAttribute("class", "suggestion-item");
    //         b.addEventListener("click", function(e) {
    //             document.getElementById('foodinput').value = this.getElementsByTagName("input")[0].value;
    //             setFoodName(event.target.value);
    //             clearSuggestions();
    //         });
    //         document.getElementById("suggestionbox").appendChild(b);
    //     }
    // }
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
