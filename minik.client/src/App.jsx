import React, { useEffect } from "react";
import Navi from "./components/Navbar";
import Logon from "./pages/Logon";
import Login from "./components/Login";
import ListingPage from "./pages/ListingPage";
import TinyHouseDetails from "./pages/tinyHouseDetails";
import Register from "./components/Register";
import Profile from "./pages/Profile";
import "./styles/App.css";
import { Container, Row, Col } from "reactstrap";
import { useState } from "react";
import { Route, Routes } from "react-router-dom";

function App() {
 const [user,setUser]=useState({
  id: 11,
  role_id: 2,
  full_name: "Kaan Civelek",
  email: "kaancivelek17@gmail.com",
  password: "123321",
  phone_number: "05397031329"
 }
 ); 

  const [userRole,setUserRole]= useState();  //3 admin 1 customer 2 property owner
const changeUserRole =(userRole)=>{
  setUserRole(userRole);
}

useEffect(() => {
  if (user) {
    changeUserRole(user.role_id);
  }
}, [user]);

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
    <Container fluid className="bodyContainer" >
      <Row>
        <Col xs="auto">
          <Navi userRole={userRole} userName={user.full_name} />
        </Col>
      </Row>

      <Row className="justify-content-center">
        <Col xs="12" md="10" lg="8">
          <div style={{ padding: "12px" }}>
            <Routes>
              <Route
                path="/"
                element={
                  //EV İLANLARINI LİSTELEYECEK ListingPage bileşenini seçen rota
                  <ListingPage
                    filterText={filterText}
                    insertTinyHouse={insertTinyHouse}
                    routerTinyHouseID={routerTinyHouseID}
                    searchBarOnChangeHandler={searchBarOnChangeHandler}
                  />
                }
              ></Route>

              <Route path="/Logon" element={<Logon />}></Route>
              <Route path="/Login" element={<Login />}></Route>
              <Route path="/Register" element={<Register />}></Route>
              <Route path="/Profile" element={<Profile user={user}  /> }></Route>

              <Route
                path="/TinyHouseDetails"
                element={
                  //İlan detalyarını getirecek TinyHouseDetails bileşenini seçen rota
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
