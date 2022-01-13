import {
  Box,
  VStack,
} from "native-base";
import React,{useState,useEffect,useRef} from "react";
import "./imageUpload.css";
import ImageUpload from "./imageUpload";
import "./front.css";

var myTimeout = 0;
function showSendInfo() {
  document.getElementById("sendInfo").innerHTML = "Zdjęcie pomyślnie wysłane";
  myTimeout = setTimeout(hideSendInfo, 2000);
}
function hideSendInfo() {
  document.getElementById("sendInfo").innerHTML = "";
  clearTimeout(myTimeout);
}

//main function called App
function App() {
  return (
    <Box
      minHeight="100vh"
      justifyContent="center"
      px={4}
    > 
      <h1 class="title">GOURMET</h1>
      <VStack space={5} alignItems="center">
          <div className="container" id="container">
              <form action="#">
                <input class="food-name-bar" type="text" placeholder="Nazwij swoje jedzenie" name="foodName"></input>
                <button className="sendbutton" onClick={showSendInfo}> wyślij </button>
                    <p class="sendInfo" id="sendInfo"></p>
                    <ImageUpload/>
              </form>
          </div>
      </VStack>
    </Box>  
  );
}

export default App;
