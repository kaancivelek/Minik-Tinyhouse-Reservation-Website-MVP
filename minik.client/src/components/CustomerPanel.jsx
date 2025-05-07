import React, { useEffect, useState } from "react";
// import { REZERVASYON } from "../services/tinyHouseService";
import {
  Card,
  CardBody,
  CardTitle,
  CardSubtitle,
  CardText,
  Col,
  Row,
} from "reactstrap";
import Filter from "../components/Filter"; // varsa
import { useNavigate } from "react-router-dom";

export default function CustomerPanel({ user, insertTinyHouse }) {
  const [reservations, setReservations] = useState([
    {
      id: 6,
      name: "Deniz Kabuğu",
      description: "Denize sıfır, romantik bir tatil evi.",
      locationId: 6,
      pricePerNight: 1600,
      maxGuests: 3,
      property_owner_id: 7,
      amenities: "wifi,jakuzi,mutfak",
      country: "Türkiye",
      city: "Aydın",
      reservationStatus: "pending",
    },
    {
      id: 9,
      name: "Lav Evi",
      description: "Lav tarlalarının ortasında fotoğraflık bir tiny house.",
      locationId: 9,
      pricePerNight: 1300,
      maxGuests: 3,
      property_owner_id: 7,
      amenities: "wifi,jakuzi,barbekü",
      country: "Türkiye",
      city: "Mersin",
      reservationStatus: "confirmed",
    },
    {
      id: 10,
      name: "Çamlık Ev",
      description: "Çam ormanları içinde kuş sesleriyle uyan.",
      locationId: 10,
      pricePerNight: 1400,
      maxGuests: 4,
      property_owner_id: 7,
      amenities: "wifi,şömine,klima",
      country: "Türkiye",
      city: "Sakarya",
      reservationStatus: "cancelled",
    },
  ]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);
  const [sortOrder, setSortOrder] = useState("asc");
  const navigate = useNavigate();

  // const fetchTinyHousesOfPropertyOwner = async () => {
  //   setLoading(true);
  //   setError(null);
  //   try {
  //     const response = await REZERVASYON(user.id);
  //     // response veri yapısına göre gerekirse .data ekle
  //     setTinyHouseOfUser(response.data || response);
  //   } catch (err) {
  //     setError(err.message || "Bir hata oluştu.");
  //   } finally {
  //     setLoading(false);
  //   }
  // };

  // useEffect(() => {
  //   console.log("User verisi:", user);
  //   if (user?.id) {
  //     REZERVASYON();
  //   } else {
  //     alert("Kullanıcı bilgisi yok. Giriş yapılmamış olabilir.");
  //   }
  // }, [user]);

  const getColorByResStatus = (status) => {
    switch (status) {
      case "confirmed":
        return "lightgreen";
      case "pending":
        return "blue";
      case "cancelled":
        return "red";
    }
  };
  const goTinyHouseDetails = (id) => {
    insertTinyHouse(id);
    navigate("/TinyHouseDetails", { state: { from: "customerPanel" } });
  };

  const searchBarOnChangeHandler = (e) => {
    console.log("Arama yapılıyor:", e.target.value);
    // Burada arama filtreleme işlemi yapılabilir
  };

  return (
    <div className="listing-page" style={{ padding: "1rem" }}>
      {loading && <div>Yükleniyor...</div>}
      {error && <div style={{ color: "red" }}>Hata: {error}</div>}
      <h2>Müşteri Paneli </h2>
      <Row>
        {reservations.map((item) => (
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
              style={{
                cursor: "pointer",
                borderColor: getColorByResStatus(item.reservationStatus),
              }}
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
