import { Card, CardBody, CardText, CardTitle, Button } from "reactstrap";
import { useState } from 'react';

function MakeReservation({ tinyHouse }) {
    const [startDate, setStartDate] = useState("");
    const [endDate, setEndDate] = useState("");
    const [guestCount, setGuestCount] = useState(1); // varsayılan 1 kişi

    const getNightCount = () => {
        if (!startDate || !endDate) return 0;
        const start = new Date(startDate);
        const end = new Date(endDate);
        const diff = (end - start) / (1000 * 60 * 60 * 24);
        return diff > 0 ? diff : 0;
    };

    const nightCount = getNightCount();
    const totalPrice = nightCount * tinyHouse.pricePerNight;

    const increaseGuests = () => {
        if (guestCount < tinyHouse.maxGuests) {
            setGuestCount(guestCount + 1);
        }
    };

    const decreaseGuests = () => {
        if (guestCount > 1) {
            setGuestCount(guestCount - 1);
        }
    };

    return (
        <Card body style={{ width: '100%' }}>
            <CardBody>
                <CardTitle tag="h5">Rezervasyon Yap</CardTitle>

                <div className="mb-2">
                    <label>Giriş Tarihi: </label>
                    <input
                        style={{
                            width: `20ch`,
                            border: "none",
                            borderBottom: "2px solid black",
                        }}
                        type="date"
                        value={startDate}
                        onChange={(e) => setStartDate(e.target.value)}
                    />
                </div>

                <div className="mb-3">
                    <label>Çıkış Tarihi: </label>
                    <input
                        style={{
                            width: `20ch`,
                            border: "none",
                            borderBottom: "2px solid black",
                        }}
                        type="date"
                        value={endDate}
                        onChange={(e) => setEndDate(e.target.value)}
                    />
                </div>

                <div className="mb-3">
                    <label>Kişi Sayısı: </label>
                    <div style={{ display: 'flex',justifyContent:'center', alignItems: 'center', gap: '1ch' }}>
                        <Button color="secondary" size="sm" onClick={decreaseGuests}>-</Button>
                        <span>{guestCount}</span>
                        <Button color="secondary" size="sm" onClick={increaseGuests}>+</Button>
                     
                    </div>
                </div>

                {nightCount > 0 && (
                    <CardText>
                        {nightCount} gece × {tinyHouse.pricePerNight} ₺ ={" "}
                        <strong>{totalPrice} ₺</strong>
                    </CardText>
                )}

                <Button disabled={nightCount === 0}>Rezervasyonu Onayla</Button>
            </CardBody>
        </Card>
    );
}

export default MakeReservation;
