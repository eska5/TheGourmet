
  import React,{useState,useEffect,useRef} from "react";
  import {Button} from "react-bootstrap";
  import {MdModeEdit} from "react-icons/md";
  import "./imageUpload.css"
  
  //main function called Upload
  
  function ImageUpload(props) {
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
  
  //functions used below
  
    function pickedHandler(event){
      let pickedFile;
      if(event.target.files && event.target.files.length===1 ){
        pickedFile=event.target.files[0];
        setFile(pickedFile);
      }
    }
  
    function pickedImageHandler(){
      filePickerRef.current.click();
    }
  
    return (

          <div className="form-controll center">
            <input
            id={props.id}
            ref = {filePickerRef}
            style = {{display:"none"}}
            type = "file"
            accept=".jpg,.png,.jpeg"
            onChange={pickedHandler}
            />

            <div className={`image-upload ${props.center && "center"} `}>
              <div className="image-upload__preview">
                {previewUrl && <img src={previewUrl} alt="preview"/>}
                {!previewUrl && (
                  <div className="center">
                  <Button className="image-upload-button" type="button" onClick={pickedImageHandler}>
                    &#128247;</Button>
                  </div>
                )}
  
              </div>
              
              <div>
                  {previewUrl && (
                    <div className="center">
                    <Button className="image-edit-button" type="button" onClick={pickedImageHandler}>
                      <MdModeEdit className="icon"></MdModeEdit>
                    </Button>
                    </div>
  
                  )}
              </div>
  
            </div>
           </div>
    );
  }
  
  export default ImageUpload;
  