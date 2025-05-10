import React, { useEffect } from "react";
import { Form, FormGroup, Input, Label, Button } from "reactstrap";
import { useNavigate } from "react-router-dom";
import "../styles/Login.css";
import { validateUser, getUserByEmail } from "../services/LogonService";
import { toast, Slide } from "react-toastify";

export default function Login({ setUser, user }) {
  const navigate = useNavigate();

  const fetchUserByEmail = async (email) => {
    try {
      const response = await getUserByEmail(email);
      if (response) {
        localStorage.setItem("user", JSON.stringify(response));
        setUser(response);
        navigate("/");
      } else {
        console.error("Kullanıcı bulunamadı.");
      }
    } catch (error) {
      console.error("Kullanıcı bilgileri alınırken hata:", error);
    }
  };

  const handleLogin = async (event) => {
  event.preventDefault();

  const formData = new FormData(event.target);
  const email = formData.get("email");
  const password = formData.get("password");

  if (!email || !password) {
    toast.error("Email ve şifre alanları boş olamaz!", {
      position: "top-center",
      autoClose: 2000,
      theme: "dark",
      transition: Slide,
    });
    return;
  }

  console.log("Giriş yapılmak istenen email:", email); // GÖZLEMLEME AMAÇLI

  const twoFactorCode = "";
  const twoFactorRecoveryCode = "";

  try {
    const response = await validateUser(email, password, twoFactorCode, twoFactorRecoveryCode);

    if (response === "Giriş başarılı.") {
        console.log(email, password)
      fetchUserByEmail(email); // burada 'email' artık güvenli bir şekilde tanımlı
       
    } else if (response === "0") {
      toast.error("Şifre hatalı!", {
        position: "top-center",
        autoClose: 2000,
        theme: "dark",
        transition: Slide,
      });
    } else if (response === "2") {
      toast.error("Kullanıcı bulunamadı!", {
        position: "top-center",
        autoClose: 2000,
        theme: "dark",
        transition: Slide,
      });
    } else {
      console.error("Giriş hatası:", response);
    }
  } catch (error) {
    console.error("Giriş hatası:", error);
    alert("Giriş sırasında bir hata oluştu. Lütfen tekrar deneyin.");
  }
};


  useEffect(() => {
    if (user !== null) {
      navigate("/");
    }
  }, [user, navigate]);

  return (
    <div className="login-container">
      <Form className="login-form" onSubmit={handleLogin}>
        <FormGroup>
          <Label for="Email">Email</Label>
          <Input
            id="Email"
            name="email"
            placeholder="example@example.com"
            type="email"
            className="animated-input"
            required
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
            required
          />
        </FormGroup>
        <Button color="secondary" block type="submit" className="animated-button">
          Giriş Yap
        </Button>
        <Button
          type="button"
          onClick={() => {
             const response = {
               id: 11,
               full_name: "Kaan Civelek",
               email: "kaancivelek17@gmail.com",
               role_id: "1",
               phone_number: "0532 123 4567",
             };
             toast.success("Giriş yapıldı.", {
               position: "top-center",
               autoClose: 2000,
               theme: "dark",
               transition: Slide,
             });

             localStorage.setItem("user", JSON.stringify(response));
             setUser(response);
            setTimeout(() => navigate("/"), 2500);
         
          }}
        >
          DEMO
        </Button>
      </Form>
    </div>
  );
}
