import { Card, CardBody, CardTitle, Button } from "reactstrap";
import { formatCardNumber, formatExpiryDate } from "../utils/formUtils";
import  "../styles/MakeReservation.css";

function CheckoutForm({
  cardNumber,
  setCardNumber,
  expiryDate,
  setExpiryDate,
  cardHolder,
  setCardHolder,
  totalPrice,
  nightCount,
  guestCount,
  handlePayment,
  setIsClickedMakeReservation,
}) {
  return (
    <Card body style={{ width: "100%" }}>
      <CardBody>
        <div className="checkout-header">
          <button
            className="back-button"
            onClick={() => setIsClickedMakeReservation(0)}
          >
            ←
          </button>
          <CardTitle tag="h5">Ödeme Gerçekleştir</CardTitle>
        </div>

        <div className="mb-3">
          <label>Kart Numarası:</label>
          <input
            className="input-field"
            type="text"
            placeholder="0000 0000 0000 0000"
            value={cardNumber}
            onChange={(e) => setCardNumber(formatCardNumber(e.target.value))}
            maxLength="19"
          />
        </div>

        <div className="mb-3">
          <label>Kart Sahibi:</label>
          <input
            className="input-field"
            type="text"
            placeholder="Kart Sahibi"
            value={cardHolder}
            onChange={(e) => setCardHolder(e.target.value)}
            maxLength="40"
          />
        </div>

        <div className="mb-3" style={{ display: "flex", gap: "10px" }}>
          <div style={{ flex: 1 }}>
            <label>Son Kullanma Tarihi:</label>
            <input
              className="input-field"
              type="text"
              placeholder="MM/YY"
              value={expiryDate}
              maxLength="5"
              onChange={(e) => setExpiryDate(formatExpiryDate(e.target.value))}
            />
          </div>
          <div style={{ flex: 1 }}>
            <label>CVV:</label>
            <input
              className="input-field"
              type="text"
              placeholder="123"
              maxLength="3"
            />
          </div>
        </div>

        <div className="mb-3">
          <label>Posta Kodu:</label>
          <input
            className="input-field"
            type="text"
            placeholder="Posta Kodu"
            maxLength="5"
          />
        </div>

        <div className="mb-3">
          <label>Ülke/Bölge:</label>
          <select className="input-field">
            <option value="Türkiye">Türkiye</option>
            <option value="ABD">ABD</option>
            <option value="Almanya">Almanya</option>
            <option value="Fransa">Fransa</option>
          </select>
        </div>

        <div className="mb-3">
          <strong>Toplam Ödeme:</strong> {totalPrice} ₺
        </div>
        <div className="mb-3">
          <strong>Kalınacak Gün:</strong> {nightCount} gece
        </div>
        <div className="mb-3">
          <strong>Kişi Sayısı:</strong> {guestCount} kişi
        </div>

        <Button
          color="primary"
          className="payment-button"
          onClick={() => handlePayment()}
        >
          Ödemeyi Tamamla
        </Button>
      </CardBody>
    </Card>
  );
}

export default CheckoutForm;