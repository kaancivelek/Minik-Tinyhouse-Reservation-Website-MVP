import { Card, CardBody, CardText, CardTitle, Button } from "reactstrap";
import "../styles/MakeReservation.css";

function ReservationForm({ reservationInfo, setReservationInfo, nightCount, totalPrice, tinyHouse, setStep }) {
  const { startDate, endDate, guestCount } = reservationInfo;

  const updateField = (field, value) => {
    setReservationInfo((prev) => ({ ...prev, [field]: value }));
  };

  const increaseGuests = () => {
    if (guestCount < tinyHouse.maxGuests) {
      updateField("guestCount", guestCount + 1);
    }
  };

  const decreaseGuests = () => {
    if (guestCount > 1) {
      updateField("guestCount", guestCount - 1);
    }
  };

  return (
    <Card body>
      <CardBody>
        <CardTitle tag="h5">Rezervasyon Yap</CardTitle>

        <div className="mb-2">
          <label>Giriş Tarihi: </label>
          <input
            className="date-input"
            type="date"
            value={startDate}
            onChange={(e) => updateField("startDate", e.target.value)}
          />
        </div>

        <div className="mb-3">
          <label>Çıkış Tarihi: </label>
          <input
            className="date-input"
            type="date"
            value={endDate}
            onChange={(e) => updateField("endDate", e.target.value)}
          />
        </div>

        <div className="mb-3">
          <label>Kişi Sayısı: </label>
          <div className="guest-counter">
            <Button size="sm" onClick={decreaseGuests}>-</Button>
            <span>{guestCount}</span>
            <Button size="sm" onClick={increaseGuests}>+</Button>
          </div>
        </div>

        {nightCount > 0 && (
          <CardText>
            {nightCount} gece × {tinyHouse.pricePerNight} ₺ = <strong>{totalPrice} ₺</strong>
          </CardText>
        )}

        <Button disabled={nightCount === 0} onClick={() => setStep(1)}>
          Rezervasyonu Onayla
        </Button>
      </CardBody>
    </Card>
  );
}

export default ReservationForm;
