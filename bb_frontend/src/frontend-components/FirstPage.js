import React from "react";
import "./FirstPage.css";
import myImage from "./images/mobile.png";
import logo from "./images/logo.png";
import { useNavigate } from "react-router-dom";

export default function FirstPage() {
  const navigate = useNavigate();

  const handleImageClick = (event) => {
    navigate("/two");
  };
  return (
    <>
      <div className="fp-container">
        <div className="header">
          <div className="text-content">
            <img src={logo} className="image-one" />
          </div>
        </div>
        <div className="fp-content">
          <p>ready to scan</p>
          <img src={myImage} className="image-two" onClick={handleImageClick} />
          <p>hold your phone near a</p>
          <p>NFC enabled passport</p>
          <div className="cancel-button">cancel</div>
        </div>
      </div>
    </>
  );
}
