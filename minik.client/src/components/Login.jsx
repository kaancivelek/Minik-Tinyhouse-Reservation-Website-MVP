import React from "react";
import { Form, FormGroup, Input, Label, Button } from "reactstrap";
import "../styles/Login.css";

export default function Login() {
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
        <Button color="secondary" block className="animated-button">
          Giriş Yap
        </Button>
      </Form>
    </div>
  );
}
