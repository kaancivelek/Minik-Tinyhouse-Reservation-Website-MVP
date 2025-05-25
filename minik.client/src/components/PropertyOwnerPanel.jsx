import React, { useEffect, useState } from "react";
import { getTinyHouseByPropertyOwnerId } from "../services/tinyHouseService";
import {
  Card,
  CardBody,
  CardTitle,
  CardSubtitle,
  CardText,
  Button,
  Col,
  Row,
} from "reactstrap";
import { useNavigate } from "react-router-dom";

export default function PropertyOwnerPanel({ user }) {
  const [tinyHousesOfPropertyOwner, setTinyHouseOfUser] = useState([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);
  const navigate = useNavigate();

  const addStars = (rating) => {
    return "★".repeat(rating) + "☆".repeat(5 - rating);
  };

  const fetchTinyHousesOfPropertyOwner = async () => {
    setLoading(true);
    setError(null);
    try {
      const response = await getTinyHouseByPropertyOwnerId(user.id);
      setTinyHouseOfUser(response.data || response);
    } catch (err) {
      setError(err.message || "Bir hata oluştu.");
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    if (user.id !== null) {
      fetchTinyHousesOfPropertyOwner();
    } else {
      console.log("Kullanıcı bilgisi yok. Giriş yapılmamış olabilir.");
    }
  }, [user]);

  const goTinyHouseDetails = (tinyHouseId) => {
    navigate(`/TinyHouseDetails/${tinyHouseId}`,{ state: { from: "PropertyOwnerPanel" } });
  
  };



  // Örnek yorumlar (gerçek yorumlar için API'dan çekebilirsiniz)
  const renderComments = (comments) => (
    <div style={{ marginTop: "1rem", background: "#f8f9fa", borderRadius: "6px", padding: "8px" }}>
      <strong>Yorumlar:</strong>
      <ul style={{ margin: 0, paddingLeft: "1.2rem" }}>
        {(comments && comments.length > 0) ? (
          comments.map((c, i) => <li key={i} style={{ fontSize: "0.95em" }}>{c}</li>)
        ) : (
          <li>Henüz yorum yok.</li>
        )}
      </ul>
    </div>
  );

  return (
    <div className="listing-page" style={{ padding: "1rem" }}>
      {loading && <div>Yükleniyor...</div>}
      {error && <div style={{ color: "red" }}>Hata: {error}</div>}
      <h2>Ev Sahibi Paneli</h2>
      <Row>
        {tinyHousesOfPropertyOwner.map((item) => (
          <Col
            key={item.id}
            xs="12"
            sm="12"
            md="8"
            lg="6"
            className="mb-4 mx-auto d-flex"
            style={{ flexDirection: "column" }}
          >
            <Card className="flex-fill" style={{ width: "100%", cursor:"pointer" }}  onClick={() => goTinyHouseDetails(item.id)}>
              <CardBody style={{ display: "flex", flexDirection: "column", gap: "1.2rem" }}>
                {/* 1. Ev Detayları */}
                <div>
                  <h5 style={{ marginBottom: 4 }}>{item.name}</h5>
                  <div style={{ color: "#666", fontSize: "1.05em" }}>
                    {item.city}, {item.country}
                  </div>
                  <CardSubtitle className="mb-2 text-muted" tag="h6">
                    {addStars(item.rating)}
                  </CardSubtitle>
                  <CardText>
                    <strong>Fiyat:</strong> {item.pricePerNight} ₺ / gece
                  </CardText>
                </div>
                {/* 2. Rezervasyon / Düzenleme */}
                <div style={{ display: "flex", gap: "10px" }}>
                  <Button color="success" size="sm">
                    Rezervasyonlar
                  </Button>
            
                </div>
                {/* 3. Yorumlar */}
                {renderComments(item.comments)}
              </CardBody>
            </Card>
          </Col>
        ))}
      </Row>
    </div>
  );
}