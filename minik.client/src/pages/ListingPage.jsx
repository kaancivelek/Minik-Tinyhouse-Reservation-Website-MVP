import React, { useState, useEffect } from "react";
import { Row, Col, Card, CardBody, CardSubtitle, CardText, CardTitle, Button } from 'reactstrap';
import './ListingPage.css';
import { getAllTinyHouses } from "../services/tinyHouseService";

const ListingPage = () => {
    const [listings, setListings] = useState([]);
    const [loading, setLoading] = useState(false);
    const [error, setError] = useState("");

    const fetchListings = async () => {
        setLoading(true);
        try {
            const data = await getAllTinyHouses();
            setListings(data);
        } catch (err) {
            setError(err.message);
        } finally {
            setLoading(false);
        }
    };

    useEffect(() => {
        fetchListings();
    }, []);

    if (loading) return <p>Yükleniyor...</p>;
    if (error) return <p>Hata: {error}</p>;

    return (
        <div className="listing-page">
            <h1 className="text-center mb-4">İlanlar</h1>

            <Row className="justify-content-center">
                {listings.map((item) => (
                    <Col key={item.id} xs="12" sm="6" md="4" lg="3" className="mb-4 d-flex">
                        <Card className="flex-fill">
                            <img
                                alt={item.name}
                                src="https://picsum.photos/300/200"
                                className="card-img-top"
                            />
                            <CardBody>
                                <CardTitle tag="h5">{item.name}</CardTitle>
                                <CardSubtitle className="mb-2 text-muted" tag="h6">
                                    {item.amenities}
                                </CardSubtitle>
                                <CardText>
                                    {item.description}
                                </CardText>
                                <Button color="secondary" block>İncele</Button>
                            </CardBody>
                        </Card>
                    </Col>
                ))}
            </Row>
        </div>
    );
};

export default ListingPage;
