import React from "react";
import { Navbar, NavbarBrand, NavbarText } from "reactstrap";
import logo from "../../public/logo.svg";
import { useNavigate } from "react-router-dom";
import "../styles/Navi.css";

function Navi({user}) {
  const navigate = useNavigate();

  const goBackToHomePage = () => {
    navigate("/");
  };


  function logonAndProfile() {
    if(!(user && Object.keys(user).length > 0)){
    return (
      <div className="navbar-right">
      <NavbarText className="navbar-login-text" onClick={() => navigate("/Logon")}>
        GİRİŞ YAP
      </NavbarText>
    </div>
    )}else {
      return(
      <div className="navbar-right">
      <NavbarText className="navbar-login-text" onClick={() => navigate("/Profile")}>
        {user.full_name}
      </NavbarText>
    </div>)
    }
 
  }
  
  return (
    <Navbar className="navbar-custom" fixed="top">
      <div className="navbar-content">
        <NavbarBrand onClick={goBackToHomePage} style={{ cursor: "pointer" }}>
          <img src={logo} alt="logo" className="logo-img" />
        </NavbarBrand>
{logonAndProfile()}
      </div>
    </Navbar>
  );
}

export default Navi;
