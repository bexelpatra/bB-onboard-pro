// import React from "react";
// import logo from "./images/logo.png"
// import CropFreeIcon from "@mui/icons-material/CropFree";
// import Home from "@mui/icons-material/Home";
// import balloon from "./images/balloon.jpeg"
// import star from "./images/star.png"
// import timer from "./images/timer.png"
// import "./PageFive.css"

// export default function PageFive() {
//   return (
//     <>
//       <div class="container">
//         <div class="header">
//           <img src={logo} alt="App Icon" className="image-one" />
//         </div>
//         <div class="container-two">
//             <div className="components">
//             <img src={balloon} className="balloon"/>
//             <button className="buttons" >
//               select
//             </button>
//             </div>
//             <div>
//             <img src={star} className="star"/>
//             </div>
//             <div>
//             <img src={timer} className="timer"/>
//             </div>
//           <div class="button-container">
//             <button class="select-button" >
//               select
//             </button>
//           </div>
//         </div>

//         <div className="footer">
//           <footer class="footer">
//             <Home className="footer-content-one" />
//             <CropFreeIcon className="footer-content-two" />
//           </footer>
//         </div>
//       </div>
//     </>
//   );
// }


import React, { useState } from "react";
import logo from "./images/logo.png";
import CropFreeIcon from "@mui/icons-material/CropFree";
import Home from "@mui/icons-material/Home";
import balloon from "./images/balloon.jpeg";
import star from "./images/star.png";
import timerImage from "./images/timer.png"; // renamed to avoid conflict with the timer variable
import "./PageFive.css";

export default function PageFive() {
  const [activeButton, setActiveButton] = useState(null);

  const handleButtonClick = (button) => {
    setActiveButton(button);
  };

  return (
    <>
      <div className="container">
        <div className="header">
          <img src={logo} alt="App Icon" className="image-one" />
        </div>
        <div className="container-two">
          <div className="components">
            <div className={`image-container ${activeButton === 'balloon' ? 'active' : ''}`}>
              <img src={balloon} className="balloon" alt="balloon" />
              <button className="buttons" onClick={() => handleButtonClick('balloon')}>
                party
              </button>
            </div>
            <div className={`image-container ${activeButton === 'star' ? 'active' : ''}`}>
              <img src={star} className="star" alt="star" />
              <button className="buttons" onClick={() => handleButtonClick('star')}>
                instant
              </button>
            </div>
            <div className={`image-container ${activeButton === 'timer' ? 'active' : ''}`}>
              <img src={timerImage} className="timer" alt="timer" />
              <button className="buttons" onClick={() => handleButtonClick('timer')}>
                timer
              </button>
            </div>
          </div>
        </div>

        <div className="footer">
          <footer className="footer">
            <Home className="footer-content-one" />
            <CropFreeIcon className="footer-content-two" />
          </footer>
        </div>
      </div>
    </>
  );
}
