import React, { useEffect, useState } from "react";
import { getTinyHouseById } from "../services/tinyHouseService";
import { Container, Row, Col, Card, CardBody, CardTitle, CardText, CardSubtitle } from "reactstrap";
import MakeReservation from "../components/MakeReservation";
import { getTinyHouseImagesByTinyHouseId } from "../services/houseImages";

function TinyHouseDetails({ routerTinyHouseID }) {
    const [tinyHouse, setTinyHouse] = useState(null);
    const [houseImages, setHouseImages] = useState([]);
    const [houseLoading, setHouseLoading] = useState(false);
    const [imagesLoading, setImagesLoading] = useState(false);
    const [error, setError] = useState("");

    const fetchTinyHouseDetails = async () => {
        setHouseLoading(true);
        try {
            const data = await getTinyHouseById(routerTinyHouseID);
            setTinyHouse(data);
        } catch (err) {
            setError(err.message);
        } finally {
            setHouseLoading(false);
        }
    };

    const fetchTinyHouseImages = async () => {
        setImagesLoading(true);
        try {
            const data = await getTinyHouseImagesByTinyHouseId(routerTinyHouseID);
            setHouseImages(data);
        } catch (err) {
            console.error("Error loading images:", err);
            // Continue even if images fail to load
        } finally {
            setImagesLoading(false);
        }
    };

    useEffect(() => {
        fetchTinyHouseDetails();
        fetchTinyHouseImages();
    }, [routerTinyHouseID]);

    if (houseLoading) return <p>Konut bilgileri yükleniyor...</p>;
    if (error) return <p>Hata: {error}</p>;
    if (!tinyHouse) return <p>Veri bulunamadı.</p>;

    // Helper function to generate optimized image URL
    const getOptimizedImageUrl = (url) => {
        if (!url) return null;
        // If already has query params, append ours
        const separator = url.includes('?') ? '&' : '?';
        return `${url}${separator}w=600&h=400&fit=crop&auto=format`;
    };

    return (
        <Container className="my-5">
            <Row className="justify-content-center">
                <Col xs="12" md="8">
                    <Card className="p-3 shadow">
                        {/* Image section with fallbacks */}
                        {imagesLoading ? (
                            <div className="card-img-top mb-3" style={{ height: '400px', backgroundColor: '#f5f5f5', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                                <p>Resimler yükleniyor...</p>
                            </div>
                        ) : houseImages.length > 0 ? (
                            <img
                                alt={tinyHouse.name}
                                src={getOptimizedImageUrl(houseImages[0].image_url)}
                                className="card-img-top mb-3"
                                style={{ height: '400px', objectFit: 'cover' }}
                                onError={(e) => {
                                    e.target.src = "https://via.placeholder.com/600x400?text=Resim+Yüklenemedi";
                                    e.target.onerror = null; // Prevent infinite loop
                                }}
                            />
                        ) : (
                            <div className="card-img-top mb-3" style={{ height: '400px', backgroundColor: '#f5f5f5', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                                <p>Resim bulunamadı</p>
                            </div>
                        )}

                        <CardBody>
                            <CardTitle tag="h1" className="mb-3">{tinyHouse.name}</CardTitle>
                            <CardSubtitle className="mb-2 text-muted">
                                {tinyHouse.amenities}
                            </CardSubtitle>
                            <CardText className="mb-2">
                                {tinyHouse.description}
                            </CardText>
                            <CardText>
                            <h3>{tinyHouse.city},{tinyHouse.country}</h3>
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
                <Col>{tinyHouse && <MakeReservation tinyHouse={tinyHouse} />}</Col>
            </Row>
        </Container>
    );
}

export default TinyHouseDetails;