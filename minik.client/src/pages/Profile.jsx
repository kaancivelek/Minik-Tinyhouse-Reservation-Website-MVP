import React, { useEffect, useState } from "react";
import AdminPanel from "../components/AdminPanel";
import CustomerPanel from "../components/CustomerPanel";
import PropertyOwnerPanel from "../components/PropertyOwnerPanel";
import { useNavigate } from "react-router-dom";
import { Button } from "reactstrap";

export default function Profile({ user, setUser, insertTinyHouse }) {
  const navigate = useNavigate();
  const [isUserLoading, setIsUserLoading] = useState(true);

  useEffect(() => {
    const storedUser = localStorage.getItem("user");
    if (storedUser) {
      setUser(JSON.parse(storedUser));
    }
    setIsUserLoading(false);
  }, []);

  useEffect(() => {
    if (!isUserLoading && !user) {
      navigate("/");
    }
  }, [user, isUserLoading, navigate]);

  const getRoleName = (roleId) => {
    switch (roleId) {
      case 3:
        return "Admin";
      case 1:
        return "Müşteri";
      case 2:
        return "Emlak Sahibi";
      default:
        return "Bilinmeyen Rol";
    }
  };

  const getPanelByRole = (roleId) => {
    switch (roleId) {
      case 1:
        return <CustomerPanel user={user} insertTinyHouse={insertTinyHouse}/>;
      case 2:
        return <PropertyOwnerPanel user={user} insertTinyHouse={insertTinyHouse} />;
      case 3:
        return <AdminPanel />;
      default:
        return <div>Panel bulunamadı</div>;
    }
  };

  if (isUserLoading || !user) {
    return <div style={{ textAlign: "center", marginTop: "100px" }}>Yükleniyor...</div>;
  }

  return (
    <>
      <div
        className="profile-container"
        style={{
          padding: "20px",
          maxWidth: "300px",
          margin: "auto",
          border: "1px solid #ccc",
          borderRadius: "10px",
        }}
      >
        <h2>Profil Bilgileri</h2>
        <p>
          <strong>Ad Soyad:</strong> {user.full_name}
        </p>
        <p>
          <strong>Email:</strong> {user.email}
        </p>
        <p>
          <strong>Telefon:</strong> {user.phone_number}
        </p>
        <p>
          <strong>Rol:</strong> {getRoleName(user.role_id)}
        </p>
        <Button
          color="info"
          style={{ background: "transparent", border: "1px solid #ccc" }}
          onClick={() => {
            localStorage.removeItem("user");
            setUser(null); // Kullanıcıyı sıfırla
            navigate("/logout");
          }}
        >
          ÇIKIŞ YAP
        </Button>
      </div>

      <div>{getPanelByRole(user.role_id)}</div>
    </>
  );
}
