import {React, useState, useRef} from 'react'
import { MainContainer,InputBar,Button,MainButtonWrapper,ImagePreview, MainContent,FooterWrapper,ImageUploadContent,ImageButtonWrapper} from './MainSectionDecorations'

const MainSection = () => { 

    const [hover, setHover] = useState(false)
    const [previewUrl,setPreviewUrl] = useState(null);
    const filePickerRef = useRef();
    const [foodname,setFoodName] = useState("");
    const onHover = () => {
      setHover(!hover)
    }
    
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

    function handleChange(event) {
        setFoodName(event.target.value) //jeśli się stanie zdarzenie(OnChange), wez element który je spowodował(target) i jego wartość(value)
      }

    return (
        <>
        <MainContainer>
            <InputBar id="foodinput" value={foodname} type="text" placeholder='Nazwij swoje jedzenie' onChange={handleChange} />
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
