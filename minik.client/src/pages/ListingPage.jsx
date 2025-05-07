import React, { useState, useEffect } from "react";
import { useNavigate } from "react-router-dom";
import { getTinyHouseImagesByTinyHouseId } from "../services/houseImages";
import { getTinyHouseById } from "../services/tinyHouseService";
import "../styles/ListingPage.css";

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

// Accept sortOrder and setSortOrder as props in ListingPage
function ListingPage({
  searchBarOnChangeHandler,
  filterText,
  insertTinyHouse,
  sortOrder,
  setSortOrder,
}) {
  const [listings, setListings] = useState([]); // Tüm çekilen evleri tutan dizi
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState("");
  const [filteredListings, setFilteredListings] = useState([]); // Arama sonrası filtrelenen evleri tutan dizi
  const [imagesMap, setImagesMap] = useState({}); // { tinyHouseId: imageUrl } Ev idsine göre resimleri getiren dizi
  const [amountOfListings, setAmountOfListings] = useState(100); // Toplam ev sayısı
  const [visibleCount, setVisibleCount] = useState(8); // Görüntülenecek ev sayısı
  const [loadingMore, setLoadingMore] = useState(false); // Daha fazla yükleme durumu
  const navigate = useNavigate();

  const fetchListings = async () => {
    setLoading(true);
    const fetched = [];

    // İlk başta sadece 8 tane ev yükleyelim (visibleCount kadar)
    for (let counter = 0; counter < visibleCount; counter++) {
      try {
        const data = await getTinyHouseById(counter);
        fetched.push(data);
      } catch (err) {
        console.warn(`ID ${counter} için hata: ${err.message}`);
      }
    }

    setListings(fetched);
    await loadImagesForListings(fetched);
    setLoading(false);
  };

  const loadMoreListings = async () => {
    setLoadingMore(true);
    const nextBatch = [];
    const startIndex = listings.length + 1;
    const endIndex = Math.min(startIndex + 7, amountOfListings); // 8 tane daha yükle

    for (let counter = startIndex; counter <= endIndex; counter++) {
      try {
        const data = await getTinyHouseById(counter);
        nextBatch.push(data);
      } catch (err) {
        console.warn(`ID ${counter} için hata: ${err.message}`);
      }
    }

    const updatedListings = [...listings, ...nextBatch];
    setListings(updatedListings);
    const unique = Array.from(
      new Map(updatedListings.map((i) => [i.id, i])).values()
    );
    setListings(unique);
    await loadImagesForListings(nextBatch); // sadece yeni gelenler için
    setVisibleCount(unique.length);
    await loadImagesForListings(nextBatch);
    setVisibleCount(visibleCount + 15);
    setLoadingMore(false);
  };

  const loadImagesForListings = async (listings) => {
    const newImagesMap = { ...imagesMap };

    // Tüm resim isteklerini paralel olarak yap
    const imageRequests = listings.map(async (listing) => {
      try {
        const images = await getTinyHouseImagesByTinyHouseId(listing.id);
        if (images.length > 0) {
          newImagesMap[listing.id] = images[1].image_url;
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
    let filtered = listings;

    if (text) {
      filtered = listings.filter(
        (listing) =>
          listing.name.toLowerCase().includes(text.toLowerCase()) ||
          listing.city.toLowerCase().includes(text.toLowerCase())
      );
    }

    const sorted = sortListings(filtered, sortOrder);
    setFilteredListings(sorted);
  };

  const sortListings = (list, order) => {
    switch (order) {
      case "asc":
        return [...list].sort((a, b) => a.pricePerNight - b.pricePerNight);
      case "desc":
        return [...list].sort((a, b) => b.pricePerNight - a.pricePerNight);
      case "rate":
        return [...list].sort((a, b) => b.rating - a.rating);

      default:
        return [...list].sort((a, b) => b.rating - a.rating);
    }
  };

  useEffect(() => {
    fetchListings();
  }, []);

  useEffect(() => {
    filterListings(filterText);
  }, [filterText, listings, sortOrder]);

  if (loading) return <p className="loadingText">Yükleniyor...</p>;
  if (error) return <p className="errorText">Hata: {console.alert(error)}</p>;

  return (
    <div className="listing-page">
      <Col>
        <Row>
          {filteredListings.map(
            (item) => (
          
              (
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
                          : `https://dummyimage.com/300x200/cccccc/000000&text=Resim+Yok`
                      }
                      className="card-img-top"
                      style={{ height: "200px", objectFit: "cover" }}
                      data-retry="0"
                      onError={(e) => {
                        const target = e.target;
                        let retryCount = parseInt(
                          target.getAttribute("data-retry") || "0",
                          10
                        );

                        if (retryCount < 2) {
                          // 3 defaya kadar tekrar dene
                          target.setAttribute("data-retry", retryCount + 1);
                          target.src =
                            imagesMap[item.id] + `?retry=${retryCount + 1}`; // cache bypass için
                        } else {
                          // 3 denemeden sonra fallback image
                          target.src =
                            "https://dummyimage.com/300x200/ff0000/ffffff&text=Resim+Yüklenemedi";
                          target.onerror = null;
                        }
                      }}
                    />

                    <CardBody className="card-body">
                      <h5>
                        {item.city},{item.country}
                      </h5>
                      <CardTitle tag="h5">
                        {item.name} ★ {item.rating}
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
              )
            )
          )}
        </Row>

        {/* Daha fazla yükle butonu */}
        {!loadingMore && listings.length < amountOfListings && (
          <div className="text-center my-4">
            <Button
              color="black"
              style={{ background: "transparent" }}
              onClick={loadMoreListings}
              className="load-more-btn"
            >
              Daha Fazla Yükle
            </Button>
          </div>
        )}

        {loadingMore && (
          <div className="text-center my-4">
            <p>Daha fazla ev yükleniyor...</p>
          </div>
        )}
      </Col>
    </div>
  );
}

export default ListingPage;
