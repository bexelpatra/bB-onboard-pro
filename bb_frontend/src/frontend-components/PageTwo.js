import React from "react";
import "./PageTwo.css";
import logo from "./images/logo.png";
import logo2 from "./images/logo2.png";
import Divider from "@mui/material/Divider";
import CalendarMonthIcon from "@mui/icons-material/CalendarMonth";
import TransgenderIcon from "@mui/icons-material/Transgender";
import LanguageIcon from "@mui/icons-material/Language";
import BadgeIcon from "@mui/icons-material/Badge";
import CropFreeIcon from "@mui/icons-material/CropFree";
import Home from "@mui/icons-material/Home";
import { useNavigate } from "react-router-dom";

export default function PageTwo() {
    const navigate = useNavigate()
    const handleAccept = () => {
        navigate('/three')
    }
  return (
    <>
      <div class="container">
        <div class="header">
          <img src={logo} alt="App Icon" class="image-one" />
        </div>
        <div class="content">
          <div class="content-container">
            <img src={logo2} className="image-three" />
            <h3 class="app-title">bB dApp</h3>
          </div>
          <p style={{marginLeft:"35px"}}>would like to access</p>
          <Divider style={{ width: "100%" }} />
          <div className="icon">
            <CalendarMonthIcon />
            <p>year of birth</p>
          </div>
          <div className="icon">
            <TransgenderIcon />
            <p>gender</p>
          </div>
          <div className="icon">
            <LanguageIcon />
            <p>country</p>
          </div>
          <div className="icon">
            <BadgeIcon />
            <p>passport unique identifier</p>
          </div>
          <Divider style={{ width: "100%" }} />
          <div className="purpose">
            <p>purpose:</p>
          </div>
          <div className="purpose-two">
            <p>link to bB application contract</p>
          </div>
          <div class="button-container">
            <button class="accept-button" onClick={handleAccept}>accept</button>
            <button class="cancel-button">cancel</button>
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
