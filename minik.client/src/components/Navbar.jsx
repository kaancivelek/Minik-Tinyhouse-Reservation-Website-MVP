import React, { useState } from "react";
import { Navbar, NavbarBrand } from "reactstrap";
import logo from "../assets/logo.svg";
import { useNavigate } from "react-router-dom";

function Navi({ onChangeHandler }) {
    const navigate=useNavigate();

  const goBackToHomePage=()=>{ navigate("/");}

  return (
    <div>
      <Navbar fixed="top">
        <NavbarBrand href="/">
          <img
            alt="logo"
            src={logo}
            style={{
              height: 87.5,
              width: 258,
            }}
            onClick={()=>goBackToHomePage}
          />
        </NavbarBrand>

        <form>
          <input
            onChange={onChangeHandler}
            type="text"
            placeholder="ARA"
           
            style={{
              width: `20ch`,
              border: "none",
              borderBottom: "2px solid black",
            }}
          />
        </form>
      </Navbar>
    </div>
  );
}

export default Navi;
