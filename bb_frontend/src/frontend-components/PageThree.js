import React from "react";
import logo from "./images/logo.png"
import "./PageThree.css"
import { useState } from "react";
import CropFreeIcon from "@mui/icons-material/CropFree";
import Home from "@mui/icons-material/Home";
import { useNavigate } from "react-router-dom";

export default function PageThree() {

    const [selectedColor, setSelectedColor] = useState(null);
    const handleCircleClick = (color) => {
        setSelectedColor(color); // Update state on circle click
      };
    const navigate = useNavigate();
    const handleSelect = () => {
      if (selectedColor) {
          sessionStorage.setItem('storedColor', selectedColor);
          navigate('/four');
      } else {
          alert("Please select a color!");
      }
  };
  return (
    
    <>
      <div class="container">
        <div class="header">
          <img src={logo} alt="App Icon" class="image-one" />
        </div>
        <div class="container-two">
          <div className="text">
            <span className="red">red</span>
            <span className="or">or</span>
            <span className="blue">blue</span>
          </div>
          <div className={`red-circle ${selectedColor === 'red' ? 'selected' : ''}`} onClick={() => handleCircleClick('red')}>  
          </div>

          <div className={`blue-circle ${selectedColor === 'blue' ? 'selected' : ''}`} onClick={() => handleCircleClick('blue')}>
          </div>
        
          <div class="button-container">
            <button class="select-button" onClick={handleSelect} >select</button>
          </div>
        </div>

        <div className="footer">
          <footer class="footer">
            <Home className="footer-content-one"/>
            <CropFreeIcon className="footer-content-two"/>   
          </footer>
        </div>
      </div>
    </>
  );
}
