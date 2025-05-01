import React from "react";

import Navi from "./components/Navbar";
import Logon from "./pages/Logon";
import ListingPage from "./pages/ListingPage";
import TinyHouseDetails from "./pages/TinyHouseDetails"

import "./styles/App.css"
import { Container, Row, Col } from "reactstrap";
import { useState } from "react";
import { Route, Routes } from "react-router-dom";

function App() {

   // Navbarda arama kutusuna girilen harfler onChangeHandler metodu yardımıyla burada tutuluyor.
   const [filterText, setText] = useState(""); 
   //  ListingPage'e yollanıyor.
   const searchBarOnChangeHandler = (event) => {
    let newText = event.target.value;
    setText(newText);
  };


 // TinyHouseDetails ve ListingPage kısmına ilgili ilanın idsini yolluyoruz ki senkron olsunlar. burada da id var.
  const [routerTinyHouseID, setRouterTinyHouse] = useState(0);
//
  const insertTinyHouse = (tinyHouseId) => {
    setRouterTinyHouse(tinyHouseId);
  };


  return (
 
      <Container fluid className="bodyContainer">
        <Row>
          <Col xs="auto">
            <Navi searchBarOnChangeHandler={searchBarOnChangeHandler} />
          </Col>
        </Row>

        <Row className="justify-content-center">
          <Col xs="12" md="10" lg="8">
            <div style={{ padding: "12px" }}>
              <Routes>

                <Route
                  path="/"
                  element={ //EV İLANLARINI LİSTELEYECEK ListingPage bileşenini seçen rota
                    <ListingPage
                      filterText={filterText}
                      insertTinyHouse={insertTinyHouse}
                      routerTinyHouseID={routerTinyHouseID}
                    />
                  }
                ></Route>

                <Route path="/Logon" element={<Logon/>}></Route>
                
                <Route
                  path="/TinyHouseDetails"
                  element={ //İlan detalyarını getirecek TinyHouseDetails bileşenini seçen rota
                    <TinyHouseDetails routerTinyHouseID={routerTinyHouseID} />
                  }
                />

              </Routes>
            </div>
          </Col>
        </Row>
      </Container>
   
  );
}

export default App;
