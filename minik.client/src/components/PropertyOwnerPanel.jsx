import React, { useEffect, useState } from "react";
import { getTinyHouseByPropertyOwnerId } from "../services/tinyHouseService";
import {
  Card,
  CardBody,
  CardTitle,
  CardSubtitle,
  CardText,
  Col,
  Row,
} from "reactstrap";
import { useNavigate } from "react-router-dom";

export default function PropertyOwnerPanel({ user }) {
  const [tinyHousesOfPropertyOwner, setTinyHouseOfUser] = useState([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);
  const navigate = useNavigate();

  const fetchTinyHousesOfPropertyOwner = async () => {
    setLoading(true);
    setError(null);
    try {
      const response = await getTinyHouseByPropertyOwnerId(user.id);
      // response veri yapısına göre gerekirse .data ekle
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
    // ID'yi URL parametresi olarak geçiyoruz
    navigate(`/TinyHouseDetails/${tinyHouseId}`);
  };

  return (
    <div className="listing-page" style={{ padding: "1rem" }}>
      {loading && <div>Yükleniyor...</div>}
      {error && <div style={{ color: "red" }}>Hata: {error}</div>}
      <h2>Ev Sahibi Paneli </h2>
      <Row>
        {tinyHousesOfPropertyOwner.map((item) => (
          <Col
            key={item.id}
            xs="12"
            sm="6"
            md="4"
            lg="3"
            className="mb-4 d-flex"
          >
            <Card
              className="flex-fill"
              onClick={() => goTinyHouseDetails(item.id)}
              style={{ cursor: "pointer" }}
            >
              <CardBody>
                <h5>
                  {item.city}, {item.country}
                </h5>
                <CardTitle tag="h5">
                  {item.name} ★ {Math.floor(Math.random() * 5) + 1}
                </CardTitle>
                <CardSubtitle className="mb-2 text-muted" tag="h6">
                  {item.amenities}
                </CardSubtitle>
                <CardText>
                  <strong>Fiyat:</strong> {item.pricePerNight} ₺ / gece
                </CardText>
              </CardBody>
            </Card>
          </Col>
        ))}
      </Row>
    </div>
  );
}
