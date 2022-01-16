import {React, useState, useEffect, useRef} from 'react'
import { MainContainer,InputBar,Button,MainButtonWrapper,ImagePreview, MainContent,FooterWrapper,ImageUploadContent,ImageButtonWrapper} from './MainSectionDecorations'
import './helper.css';

const MainSection = () => { 
    const [name, setName] = useState("");
    const [hover, setHover] = useState(false)
    const onHover = () => {
      setHover(!hover)
  }

    const [file,setFile] = useState();
    const [previewUrl,setpreviewUrl] = useState();
    const filePickerRef = useRef();

    useEffect(() =>{
        if(!file){
          return;
        }
        const fileReader = new FileReader();
        fileReader.onload=()=>{
          setpreviewUrl(fileReader.result);
        };
        fileReader.readAsDataURL(file);
      },[file])

      function ImageHandler(event)
      {
        let pickedFile;
        if(event.target.files && event.target.files.length===1 )
        {
            pickedFile=event.target.files[0];
            setFile(pickedFile);
            document.getElementById("imgbtn").innerText = "Edytuj zdjęcie";
        }
      }

      function pickedImageHandler()
      {
        filePickerRef.current.click();
      }

    return (
        <>
        <form action="../../post" method="post" className="form">
        <input ref = {filePickerRef} style = {{display:"none"}} type = "file" accept=".jpg,.png,.jpeg" onChange={ImageHandler}/>
        <MainContainer>
            <InputBar type="text" placeholder='Nazwij swoje jedzenie' value={name} onChange={(e) => setName(e.target.value)}/>
            <MainContent>
                <MainButtonWrapper>
                <button class="sumbitbutton" type="submit">Wyślij</button>
                    {/* <Button type="button" onMouseEnter={onHover} onMouseLeave={onHover}>
                        Wyślij TO CHYBA MOŻNA NAPRAWIĆ SPRAWIAJĄC ŻE CUSTOMOWY BUTTON MOŻE BYĆ DZIAŁAJĄCYM SUBMITEM!
                    </Button> */}
                </MainButtonWrapper>
                
            </MainContent>            
            <ImageUploadContent>
                <ImageButtonWrapper>
                    <Button id="imgbtn" type="button" onMouseEnter={onHover} onMouseLeave={onHover} onClick={pickedImageHandler}>
                        Wybierz zdjęcie 
                    </Button>
                </ImageButtonWrapper>
                <ImagePreview>
                    {previewUrl && <img height="300px" width="300px" src={previewUrl} alt="preview"/>}
                    {!previewUrl && (
                  <div className="center">
                  
                  </div>
                )}
                </ImagePreview>
            </ImageUploadContent>
            <FooterWrapper>Jakub Sachajko & Łukasz Niedźwiadek © 2022</FooterWrapper>               
        </MainContainer>
        </form>
        </>
    )
}

export default MainSection
