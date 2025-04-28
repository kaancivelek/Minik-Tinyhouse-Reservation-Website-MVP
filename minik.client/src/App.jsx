import React from 'react';
import { Container, Row, Col } from 'reactstrap';
import Navi from './components/Navbar';
import ListingPage from './pages/ListingPage';

function App() {
    return (
        <Container fluid className="p-0">
            <Row className="justify-content-center mt-3">
                <Col xs="auto">
                    <Navi />
                </Col>
            </Row>

            <Row className="justify-content-center">
                <Col xs="12" md="10" lg="8">
                    <div style={{ padding: '20px' }}>
                        <ListingPage />
                    </div>
                </Col>
            </Row>
        </Container>
    );
}

export default App;
