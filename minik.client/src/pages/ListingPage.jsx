import React, { useState, useEffect } from "react";
import {
  Row,
  Col,
  Card,
  CardBody,
  CardSubtitle,
  CardText,
  CardTitle,
  Button,
} from "reactstrap";
import { getAllTinyHouses } from "../services/tinyHouseService";
import { useNavigate } from "react-router-dom";

import "./ListingPage.css";

function ListingPage({ filterText, insertTinyHouse }) {
  const [listings, setListings] = useState([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState("");
  const [filteredListings, setFilteredListings] = useState([]);

  const navigate = useNavigate();

  const fetchListings = async () => {
    setLoading(true);
    try {
      const data = await getAllTinyHouses();
      setListings(data); // Tüm listeyi al
    } catch (err) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  };

  const goTinyHouseDetails = (id) => {
    insertTinyHouse(id);
    navigate("/TinyHouseDetails");
  };

  //Eğer filtreleme için bir metin varsa filtrelenmiş listeliyor aksi durumda hepsini listeliyor.
  const filterListings = (text) => {
    if (!text) {
      setFilteredListings(listings);
    } else {
      const filtered = listings.filter((listing) =>
        listing.name.toLowerCase().includes(text.toLowerCase())
      );
      setFilteredListings(filtered);
    }
  };

  useEffect(() => {
    //Component mount olduğu anda listeyi çekiyor.
    fetchListings();
  }, []);

  useEffect(() => {
    filterListings(filterText);
  }, [filterText, listings]);

  if (loading) return <p>Yükleniyor...</p>;
  if (error) return <p>Hata: {error}</p>;

  //İlanların listeleneceği bölge
  return (
    <div className="listing-page">
      <Row className="justify-content-center">
        {filteredListings.map((item) => (
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
            >
              <img
                alt={item.name}
                src={`https://picsum.photos/300/200?random=${item.id}`}
                className="card-img-top"
              />
              <CardBody className="card-body">
                <CardTitle tag="h5">
                  {item.name} ★{Math.floor(Math.random() * 5) + 1}{" "}
                </CardTitle>
                <CardSubtitle className="mb-2 text-muted" tag="h6">
                  {item.amenities}
                </CardSubtitle>
                <CardText>{item.description}</CardText>
              </CardBody>
            </Card>
          </Col>
        ))}
      </Row>
    </div>
  );
}

export default ListingPage;
