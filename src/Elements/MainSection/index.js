import {React, useState, useRef} from 'react'
import { MainContainer,InputBar,Button,MainButtonWrapper,ImagePreview, MainContent,FooterWrapper,ImageUploadContent,ImageButtonWrapper} from './MainSectionDecorations'

const MainSection = () => { 

    const [hover, setHover] = useState(false)
    const [previewUrl,setpreviewUrl] = useState(null);
    const filePickerRef = useRef();
    const onHover = () => {
      setHover(!hover)
    }

    function ImageHandler(event) {
      if(event.target.files && event.target.files.length===1 )
      {
          setpreviewUrl(URL.createObjectURL(event.target.files[0]));
          document.getElementById("imgbtn").innerText = "Edytuj zdjęcie";
      }
    }
    function pickedImageHandler() {
      filePickerRef.current.click(); //wywolanie klikniecia inputu, ktory jest niewidzialny
    }

    return (
        <>
        <MainContainer>
            <InputBar id="foodinput" type="text" placeholder='Nazwij swoje jedzenie'/>
            <MainContent>

              <MainButtonWrapper>
                  <input ref = {filePickerRef} style = {{display:"none"}} type = "file" accept=".jpg,.png,.jpeg" onChange={ImageHandler} />
                  <Button type="submit" value="Submit" onMouseEnter={onHover} onMouseLeave={onHover}>
                      Wyślij
                  </Button>
                </MainButtonWrapper>     
            </MainContent>   

            <ImageUploadContent>
                <ImageButtonWrapper>
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
