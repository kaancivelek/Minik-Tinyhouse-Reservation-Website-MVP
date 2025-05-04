import React, { useState, useEffect } from "react";
import { Row, Col,Card, CardBody,CardSubtitle, CardText,CardTitle,} from "reactstrap";
import { getAllTinyHouses } from "../services/tinyHouseService";
import { useNavigate } from "react-router-dom";
import { getTinyHouseImagesByTinyHouseId } from "../services/houseImages";
import "../styles/ListingPage.css";

function ListingPage({ filterText, insertTinyHouse }) {


  const [listings, setListings] = useState([]); //Tüm çekilen evleri tutan dizi
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState("");
  const [filteredListings, setFilteredListings] = useState([]); //Arama sonrası filtrelenen evleri tutan dizi
  const [imagesMap, setImagesMap] = useState({}); // { tinyHouseId: imageUrl } Ev idsine göre resimleri getiren dizi

  const navigate = useNavigate();

  const fetchListings = async () => {
    setLoading(true);
    try {
      const data = await getAllTinyHouses();
      setListings(data);
      // Her bir tiny house için resimleri yükle
      await loadImagesForListings(data);
    } catch (err) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  };

  const loadImagesForListings = async (listings) => {
    const newImagesMap = {};

    // Tüm resim isteklerini paralel olarak yap
    const imageRequests = listings.map(async (listing) => {
      try {
        const images = await getTinyHouseImagesByTinyHouseId(listing.id);
        if (images.length > 0) {
          newImagesMap[listing.id] = images[0].image_url;
        }
      } catch (err) {
        console.error(`Resim yüklenirken hata (ID: ${listing.id}):`, err);
      }
    });

    await Promise.all(imageRequests);
    setImagesMap(newImagesMap);
  };

  const goTinyHouseDetails = (id) => {
    insertTinyHouse(id);
    navigate("/TinyHouseDetails");
  };

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
    fetchListings();
  }, []);

  useEffect(() => {
    filterListings(filterText);
  }, [filterText, listings]);

  if (loading) return <p className="loadingText">Yükleniyor...</p>;
  if (error) return <p className="errorText">Hata: {console.alert(error)}</p>;

  return (
    <div className="listing-page">
      <Row >
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
                src={
                  imagesMap[item.id]
                    ? `${imagesMap[item.id]}?w=300&h=200&fit=crop`
                    : `https://via.placeholder.com/300x200?text=Resim+Yok`
                }
                className="card-img-top"
                style={{ height: "200px", objectFit: "cover" }}
                onError={(e) => {
                  e.target.src =
                    "https://via.placeholder.com/300x200?text=Resim+Yüklenemedi";
                  e.target.onerror = null;
                }}
              />
              <CardBody className="card-body">
                <CardTitle tag="h5">
                {item.city},{item.country} ★{Math.floor(Math.random() * 5) + 1}{" "}
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

export default ListingPage;
