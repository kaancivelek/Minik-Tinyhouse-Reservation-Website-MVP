import React from "react";
import { Form, FormGroup, Input, Label, Button } from "reactstrap";
import { useEffect } from "react";
import { useNavigate } from "react-router-dom";
import "../styles/Login.css";
import { Password } from "@mui/icons-material";

export default function Login({setUser, user}) {
  const navigate = useNavigate();

  useEffect(() => {
    if (user !== null) {
      navigate("/"); // Zaten giriş yapmışsa anasayfaya gönder
    }
  }, [user]);
  
  return (
    <div className="login-container">
      <Form className="login-form">
        <FormGroup>
          <Label for="Email">Email</Label>
          <Input
            id="Email"
            name="email"
            placeholder="example@example.com"
            type="email"
            className="animated-input"
          />
        </FormGroup>
        <FormGroup>
          <Label for="Password">Password</Label>
          <Input
            id="Password"
            name="password"
            placeholder="••••••"
            type="password"
            className="animated-input"
          />
        </FormGroup>
        <Button
  color="secondary"
  block
  className="animated-button"
  onClick={() => {
    const dummyUser = {
      id: 11,
      role_id: "1",
      full_name: "Kaan Civelek",
      email: "kaancivelek17@gmail.com",
      phone_number: "539-703-1329",
      password:"123"
    };

  
    localStorage.setItem("user", JSON.stringify(dummyUser));
    setUser(dummyUser);

    navigate("/");
  }}
>
  Giriş Yap
</Button>

      </Form>
    </div>
  );
}
