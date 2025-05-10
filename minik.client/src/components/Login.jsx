import React from "react";
import { Form, FormGroup, Input, Label, Button } from "reactstrap";
import { useEffect } from "react";
import { useNavigate } from "react-router-dom";
import "../styles/Login.css";
import { validateUser } from "../services/LogonService"; // Kullanıcı doğrulama servisi
import { getUserByEmail } from "../services/LogonService";
import { toast, Slide } from "react-toastify"; // Toast bildirimleri için
export default function Login({ setUser, user }) {
  const navigate = useNavigate();

  const getUserByEmail = async (email) => {
    try {
      const response = await getUserByEmail(email); // Kullanıcıyı email ile al
      if (response) {
        localStorage.setItem("user", JSON.stringify(response)); // Kullanıcı bilgilerini localStorage'a kaydet
        setUser(response); // Kullanıcıyı state'e ayarla
        navigate("/"); // Başarılı giriş sonrası anasayfaya yönlendir
      } else {
        console.error("Kullanıcı bulunamadı.");
      }
    } catch (error) {
      console.error("Kullanıcı bilgileri alınırken hata:", error);
    }
  };

  const handleLogin = async (event) => {
    event.preventDefault(); // Formun varsayılan gönderimini engelle

    const email = event.target.email.value;
    const password = event.target.password.value;

    try {
      const response = await validateUser(email, password); // Kullanıcıyı doğrula
      if (response) {
        getUserByEmail(email); // Kullanıcı bilgilerini al
      } else {
        alert("Giriş başarısız. Lütfen bilgilerinizi kontrol edin.");
      }
    } catch (error) {
      console.error("Giriş hatası:", error);
      alert("Giriş sırasında bir hata oluştu. Lütfen tekrar deneyin.");
    }
  };

  useEffect(() => {
    if (user !== null) {
      navigate("/"); // Zaten giriş yapmışsa anasayfaya gönder
    }
  }, [user]);

  return (
    <div className="login-container">
      <Form className="login-form" onSubmit={handleLogin}>
        {" "}
        {/* Formun onSubmit olayını dinle */}
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
          type="submit"
          className="animated-button"
        >
          Giriş Yap
        </Button>
        <Button
          onClick={() => {
            const response = {
              id: 11,
              full_name: "Kaan Civelek",
              email: "kaancivelek17@gmail.com",
              role_id: "1",
              phone_number: "0532 123 4567",
            };
            toast.success("Rezervasyon başarıyla oluşturuldu!", {
              position: "top-center",
              autoClose: 2000,
              theme: "dark",
              transition: Slide,
            });

            localStorage.setItem("user", JSON.stringify(response)); // Kullanıcı bilgilerini localStorage'a kaydet
            setUser(response); // Kullanıcıyı state'e ayarla
            setTimeout(() => navigate("/"), 2500);
          }}
        >
          {" "}
          DEMO
        </Button>
      </Form>
    </div>
  );
}
