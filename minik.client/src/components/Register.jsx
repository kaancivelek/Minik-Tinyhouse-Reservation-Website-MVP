import React from "react";
import { Form, FormGroup, Input, Label, Button } from "reactstrap";
import "../styles/Register.css";

export default function Register() {
  return (
    <div className="register-container">
      <Form className="register-form">
        <FormGroup>
          <Label for="Name">Ad Soyad</Label>
          <Input
            id="Name"
            name="name"
            placeholder="Ad Soyad"
            type="text"
            className="animated-input"
          />
        </FormGroup>
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
          <Label for="Password">Şifre</Label>
          <Input
            id="Password"
            name="password"
            placeholder="••••••••"
            type="password"
            className="animated-input"
          />
        </FormGroup>
        <FormGroup>
          <Label for="ConfirmPassword">Şifre Tekrar</Label>
          <Input
            id="ConfirmPassword"
            name="confirmPassword"
            placeholder="••••••••"
            type="password"
            className="animated-input"
          />
        </FormGroup>
        <Button color="secondary" block className="animated-button">
          Kayıt Ol
        </Button>
      </Form>
    </div>
  );
}
