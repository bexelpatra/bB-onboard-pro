import { BrowserRouter as Router, Route, Routes } from "react-router-dom";
import FirstPage from "./Components/FirstPage";
import PageTwo from "./Components/PageTwo";
import PageThree from "./Components/PageThree";
import PageFour from "./Components/PageFour";
import PageFive from "./Components/PageFive";

function App() {
  return (
    <>
      <Router>
      <Routes>
        <Route path="/" element={<FirstPage />}></Route>
        <Route path="/two" element={<PageTwo/>}></Route>
        <Route path="/three" element={<PageThree/>}></Route>
        <Route path="/four" element={<PageFour/>}></Route>
        <Route path="/five" element={<PageFive/>}></Route>
      </Routes>
    </Router>
    </>
  );
}

export default App;
