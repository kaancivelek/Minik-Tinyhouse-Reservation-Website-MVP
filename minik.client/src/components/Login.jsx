import React from "react";
import { Form, FormGroup, Input, Label, Button } from "reactstrap";
import { useEffect } from "react";
import { useNavigate } from "react-router-dom";
import "../styles/Login.css";

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
      role_id: 2,
      full_name: "Kaan Civelek",
      email: "kaancivelek17@gmail.com",
      password: "123321",
      phone_number: "05397031329"
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
