import React from "react";
import { Container, Row, Col } from "reactstrap";
import { useState } from "react";
import Navi from "./components/Navbar";
import ListingPage from "./pages/ListingPage";
import TinyHouseDetails from "./pages/TinyHouseDetails";
import { Route, Routes } from "react-router-dom";


function App() {

  const [filterText, setText] = useState("");
  const [routerTinyHouseID,setRouterTinyHouse] = useState(0);

const insertTinyHouse = (tinyHouseId)=>{
    setRouterTinyHouse(tinyHouseId);
}

  const onChangeHandler = (event) => {
    let newText = event.target.value;
    setText(newText);
  };

  return (
    <Container fluid className="p-0">
      <Row className="justify-content-center mt-3">
        <Col xs="auto">
          <Navi onChangeHandler={onChangeHandler} />
        </Col>
      </Row>

      <Row className="justify-content-center">
        <Col xs="12" md="10" lg="8">
          <div style={{ padding: "20px" }}>
            <Routes>
                <Route path="/" element={<ListingPage filterText={filterText} insertTinyHouse={insertTinyHouse} />}></Route>
            
            <Route path="/TinyHouseDetails" element={<TinyHouseDetails routerTinyHouseID={routerTinyHouseID} />} />
            </Routes>
          </div>
        </Col>
      </Row>
    </Container>
  );
}

export default App;
