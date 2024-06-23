import { BrowserRouter as Router, Route, Routes } from "react-router-dom";
import FirstPage from "./frontend-components/FirstPage";
import PageTwo from "./frontend-components/PageTwo";
import PageThree from "./frontend-components/PageThree";
import PageFour from "./frontend-components/PageFour";
import PageFive from "./frontend-components/PageFive";

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
