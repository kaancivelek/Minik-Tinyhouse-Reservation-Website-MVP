//import React, { useState } from "react";
import { Navbar, NavbarBrand,NavbarText } from "reactstrap";
import logo from "../assets/logo.svg";
import { useNavigate } from "react-router-dom";


function Navi({ searchBarOnChangeHandler }) {
    const navigate = useNavigate();

    const goBackToHomePage = () => { navigate("/"); }

    return (
        <div  >
            <Navbar
                fixed="top"
                style={{
                    display: "flex",
                    justifyContent: "space-between",
                    alignItems: "center",
                    padding: "0 20px",
                    height: "100px", // navbar yüksekliği belirlenirse hizalama daha kolay olur
                }}
            >
                {/* Logo - Sol kısım */}
                <NavbarBrand href="/">
                    <img
                        alt="logo"
                        src={logo}
                        style={{
                            height: 87.5,
                            width: 258,
                            cursor: "pointer",
                        }}
                        onClick={() => goBackToHomePage()}
                    />
                </NavbarBrand>

                {/* Sağ kısım */}
                <div
                    style={{
                        display: "flex",
                        alignItems: "center",
                        gap: "20px",
                        height: "100%", // tüm navbar yüksekliğini kapla
                    }}
                >
                    <form style={{ height: "100%", display: "flex", alignItems: "center" }}>
                        <input
                            onChange={searchBarOnChangeHandler}
                            type="text"
                            placeholder="ARA"
                            style={{
                                width: `20ch`,
                                border: "none",
                                borderBottom: "2px solid black",
                                background: "transparent",
                                outline: "none",
                                fontSize: "16px",
                                height: "40px", // tutarlı yükseklik
                            }}
                        />
                    </form>

                    <NavbarText
                        style={{
                           
                            background: "transparent",
                            cursor: "pointer",
                            fontSize: "12px",
                            height: "40px", // aynı yükseklik
                            display: "flex",
                            alignItems: "center",
                        }}
                        onClick={ ()=>navigate("/Logon")}
                    >
                        GİRİŞ YAP
                    </NavbarText>
                </div>
            </Navbar>


    </div>
  );
}

export default Navi;
