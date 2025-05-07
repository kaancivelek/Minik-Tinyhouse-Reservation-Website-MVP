import React, { useEffect } from "react";
import Navi from "./components/Navbar";
import Logon from "./pages/Logon";
import Login from "./components/Login";
import ListingPage from "./pages/ListingPage";
import TinyHouseDetails from "./pages/tinyHouseDetails";
import Register from "./components/Register";
import Profile from "./pages/Profile";
import Logout from "./utils/Logout"
import "./styles/App.css";
import { Container, Row, Col } from "reactstrap";
import { useState } from "react";
import { Route, Routes } from "react-router-dom";

function App() {
  const [user, setUser] = useState(null);
  const [isUserLoading, setIsUserLoading] = useState(true);
  const [sortOrder, setSortOrder] = useState("");
  
  useEffect(() => {
    const storedUser = localStorage.getItem("user");
    if (storedUser) {
      setUser(JSON.parse(storedUser));
    }
    setIsUserLoading(false);
  }, []);
  
 

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
    <Container fluid className="bodyContainer">
      <Navi
        user={user}
        filterText={filterText}
        searchBarOnChangeHandler={searchBarOnChangeHandler}
        sortOrder={sortOrder}
        setSortOrder={setSortOrder}
      />
  
      <div className="page-wrapper">
        <Routes>
          <Route
            path="/"
            element={
              <ListingPage
                filterText={filterText}
                insertTinyHouse={insertTinyHouse}
                routerTinyHouseID={routerTinyHouseID}
                searchBarOnChangeHandler={searchBarOnChangeHandler}
                sortOrder={sortOrder}
                setSortOrder={setSortOrder}
              />
            }
          />
          <Route path="/Logon" element={<Logon />} />
          <Route path="/Login" element={<Login user={user} setUser={setUser} />} />
          <Route path="/Register" element={<Register />} />
          <Route
            path="/Profile"
            element={
              <Profile
                user={user}
                setUser={setUser}
                insertTinyHouse={insertTinyHouse}
              />
            }
          />
          <Route path="/Logout" element={<Logout user={user} setUser={setUser} />} />
          <Route
            path="/TinyHouseDetails"
            element={
              <TinyHouseDetails
                routerTinyHouseID={routerTinyHouseID}
                user={user}
              />
            }
          />
        </Routes>
      </div>
    </Container>
  );
  
}

export default App;
