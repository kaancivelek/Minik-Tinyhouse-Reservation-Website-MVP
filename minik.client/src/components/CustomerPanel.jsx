import React, { useEffect, useState } from "react";
import { getReservationByUserId } from "../services/reservationService";
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

export default function CustomerPanel({ user }) {
  const [reservations, setReservations] = useState([]);
  const [tinyHouse, setTinyHouse] = useState([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);
  const navigate = useNavigate();

  const fetchReservationsByUser = async () => {
    setLoading(true);
    setError(null);
    try {
      const response = await getReservationByUserId(user.id);
      // response veri yapısına göre gerekirse .data ekle
      setReservations(response.data || response);
    } catch (err) {
      setError(err.message || "Bir hata oluştu.");
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    if (user?.id) {
      fetchReservationsByUser();
    } else {
      alert("Kullanıcı bilgisi yok.");
    }
  }, [user]);

  const getColorByResStatus = (status) => {
    switch (status) {
      case "confirmed":
        return "lightgreen";
      case "pending":
        return "orange";
      case "cancelled":
        return "red";
    }
  };
  const goTinyHouseDetails = (tinyHouseId) => {
    // ID'yi URL parametresi olarak geçiyoruz
    navigate(`/TinyHouseDetails/${tinyHouseId}`, {
      state: { from: "CustomerPanel", reservationInfo: reservations.filter((reservation)=>reservation.tinyHouseId === tinyHouseId) },
    });
  };



  return (
    <div className="listing-page" style={{ padding: "1rem" }}>
      {loading && <div>Yükleniyor...</div>}
      {error && <div style={{ color: "red" }}>Hata: {error}</div>}
      <h2>Müşteri Paneli </h2>
      <Row>
        {reservations.map((item) => (
          <Col
            key={item.tinyHouseId}
            xs="12"
            sm="6"
            md="4"
            lg="3"
            className="mb-4 d-flex"
          >
            <Card
              className="flex-fill"
              onClick={() => goTinyHouseDetails(item.tinyHouseId)}
              style={{
                cursor: "pointer",
                borderColor: getColorByResStatus(item.status),
              }}
            >
              <CardBody>
                <h5>
                  {item.checkIn.split("T")[0]}
                  <br />
                  {item.checkOut.split("T")[0]}
                </h5>
                <CardTitle tag="h5">
                  id: {item.tinyHouseId}, {item.totalPrice} ₺
                </CardTitle>
                <CardSubtitle className="mb-2 text-muted" tag="h6">
                  {item.amenities}
                </CardSubtitle>
                <CardText></CardText>
              </CardBody>
            </Card>
          </Col>
        ))}
      </Row>
    </div>
  );
}
