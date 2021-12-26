import {
  Box,
  Text,
  HStack,
  Heading,
  Switch,
  useColorMode,
  VStack,
  Row,
} from "native-base";
import React,{useState,useEffect,useRef} from "react";
import "./imageUpload.css";
import ImageUpload from "./imageUpload";
import "./front.css";
import { Col, Container } from "react-bootstrap";

//main function called App

function App() {
  const { colorMode } = useColorMode();
  function ToggleDarkMode() {
    const { colorMode, toggleColorMode } = useColorMode();
    return (
      <HStack space={2}>
        <Text>Dark</Text>
        <Switch
          isChecked={colorMode === "light" ? true : false}
          onToggle={toggleColorMode}
          accessibilityLabel={
            colorMode === "light" ? "switch to dark mode" : "switch to light mode"
          }
        />
        <Text>Light</Text>
      </HStack>
    );
  }

  return (
    <Box
      bg={colorMode === "light" ? "coolGray.50" : "coolGray.900"}
      minHeight="100vh"
      justifyContent="center"
      px={4}
    >
      <VStack space={5} alignItems="center">
        <Heading size="lg" textAlign="center">The Gourmet - aplikacja mobilna rozpoznająca potrawy</Heading>
          <div className="container" id="container">
            <div className="registration-container">
              <form action="#">
                <input type="text" placeholder="foodName" name="foodName"></input>
                <button className="ibtno"> wyślij </button>
                    <ImageUpload/>
              </form>
            </div>
          </div>

         
        
        <ToggleDarkMode />
      </VStack>
    </Box>
  );
}

export default App;
