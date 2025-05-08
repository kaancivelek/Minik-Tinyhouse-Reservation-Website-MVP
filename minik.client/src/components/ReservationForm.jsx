import { Card, CardBody, CardText, CardTitle, Button } from "reactstrap";
import  "../styles/MakeReservation.css";

function ReservationForm({
  startDate,
  setStartDate,
  endDate,
  setEndDate,
  guestCount,
  setGuestCount,
  nightCount,
  totalPrice,
  tinyHouse,
  setIsClickedMakeReservation,
}) {
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
    <Card body style={{ width: "100%" }}>
      <CardBody>
        <CardTitle tag="h5">Rezervasyon Yap</CardTitle>

        <div className="mb-2">
          <label>Giriş Tarihi: </label>
          <input
            className="date-input"
            type="date"
            value={startDate}
            onChange={(e) => setStartDate(e.target.value)}
          />
        </div>

        <div className="mb-3">
          <label>Çıkış Tarihi: </label>
          <input
            className="date-input"
            type="date"
            value={endDate}
            onChange={(e) => setEndDate(e.target.value)}
          />
        </div>

        <div className="mb-3">
          <label>Kişi Sayısı: </label>
          <div className="guest-counter">
            <Button color="secondary" size="sm" onClick={decreaseGuests}>
              -
            </Button>
            <span> {guestCount} </span>
            <Button color="secondary" size="sm" onClick={increaseGuests}>
              +
            </Button>
          </div>
        </div>

        {nightCount > 0 && (
          <CardText>
            {nightCount} gece × {tinyHouse.pricePerNight} ₺ = <strong>{totalPrice} ₺</strong>
          </CardText>
        )}

        <Button
          disabled={nightCount === 0}
          onClick={() => setIsClickedMakeReservation(1)}
        >
          Rezervasyonu Onayla
        </Button>
      </CardBody>
    </Card>
  );
}

export default ReservationForm;