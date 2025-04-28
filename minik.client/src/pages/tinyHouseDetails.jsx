import React, { useEffect, useState } from "react";
import { getTinyHouseById } from "../services/tinyHouseService";
import { Container, Row, Col, Card, CardBody, CardTitle, CardText, CardSubtitle } from "reactstrap";

function TinyHouseDetails({ routerTinyHouseID }) {
  const [tinyHouse, setTinyHouse] = useState(null); // Dizi değil, obje olacak
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState("");

  const fetchTinyHouseDetails = async () => {
    setLoading(true);
    try {
      const data = await getTinyHouseById(routerTinyHouseID);
      setTinyHouse(data);
    } catch (err) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchTinyHouseDetails();
  }, [routerTinyHouseID]); // id değişirse tekrar çeksin diye

  if (loading) return <p>Yükleniyor...</p>;
  if (error) return <p>Hata: {error}</p>;
  if (!tinyHouse) return <p>Veri bulunamadı.</p>;

  return (
    <Container className="my-5">
      <Row className="justify-content-center">
        <Col xs="12" md="8">
          <Card className="p-3 shadow">
            <img
              alt={tinyHouse.name}
              src={`https://picsum.photos/600/400?random=${tinyHouse.id}`}
              className="card-img-top mb-3"
            />
            <CardBody>
              <CardTitle tag="h2" className="mb-3">{tinyHouse.name}</CardTitle>
              <CardSubtitle className="mb-2 text-muted">
                {tinyHouse.amenities}
              </CardSubtitle>
              <CardText className="mb-2">
                {tinyHouse.description}
              </CardText>
              <CardText>
                <strong>Fiyat:</strong> {tinyHouse.pricePerNight} ₺ / gece
              </CardText>
              <CardText>
                <strong>Maksimum Misafir:</strong> {tinyHouse.maxGuests} kişi
              </CardText>
            </CardBody>
          </Card>
        </Col>
      </Row>
    </Container>
  );
}

export default TinyHouseDetails;
