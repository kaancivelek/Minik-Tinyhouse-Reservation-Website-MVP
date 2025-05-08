import { Card, CardBody, CardText, CardTitle, Button } from "reactstrap";
import { postReservation } from "../services/reservationService";
import { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import ReservationForm from "./ReservationForm";
import CheckoutForm from "./CheckoutForm";
import  "../styles/MakeReservation.css";
import { toast, Slide,ToastContainer } from "react-toastify";
import "react-toastify/dist/ReactToastify.css";

function MakeReservation({ tinyHouse }) {
  const [startDate, setStartDate] = useState("");
  const [endDate, setEndDate] = useState("");
  const [guestCount, setGuestCount] = useState(1);
  const [isClickedMakeReservation, setIsClickedMakeReservation] = useState(0);
  const [cardNumber, setCardNumber] = useState("");
  const [expiryDate, setExpiryDate] = useState("");
  const [cardHolder, setCardHolder] = useState("");
  const navigate = useNavigate();

  const getNightCount = () => {
    if (!startDate || !endDate) return 0;
    const start = new Date(startDate);
    const end = new Date(endDate);
    const diff = (end - start) / (1000 * 60 * 60 * 24);
    return diff > 0 ? diff : 0;
  };

  const nightCount = getNightCount();
  const totalPrice = nightCount * tinyHouse.pricePerNight;

  const handlePayment = async () => {
    const storedUser = JSON.parse(localStorage.getItem("user"));
    const reservationData = {
      userId: storedUser.id,
      tinyHouseId: tinyHouse.id,
      checkIn: startDate,
      checkOut: endDate,
      totalPrice: totalPrice,
      status: "confirmed",
    };

    try {
      const response = await postReservation(reservationData);
      if (response) {
        toast.success(" Rezervasyon başarıyla oluşturuldu!", {
          position: "top-center",
          autoClose: 2000,
          hideProgressBar: false,
          closeOnClick: true,
          pauseOnHover: true,
          draggable: true,
          progress: undefined,
          theme: "dark",
          transition: Slide,
        });
    setTimeout(() => {
  navigate("/Profile"); // ya da başka bir işlem
}, 2500); // autoClose süresi kadar beklet
      }
    } catch (error) {
      console.error("Rezervasyon oluşturulurken hata:", error);
      toast.error("Rezervasyon oluşturulamadı. Lütfen tekrar deneyin.", {
        position: "top-center",
        autoClose: 2000,
        hideProgressBar: false,
        closeOnClick: true,
        pauseOnHover: true,
        draggable: true,
        progress: undefined,
        theme: "dark",
        transition: Slide,
      });
    }
  };

  return (
    <div>
      {isClickedMakeReservation === 0 && (
        <ReservationForm
          startDate={startDate}
          setStartDate={setStartDate}
          endDate={endDate}
          setEndDate={setEndDate}
          guestCount={guestCount}
          setGuestCount={setGuestCount}
          nightCount={nightCount}
          totalPrice={totalPrice}
          tinyHouse={tinyHouse}
          setIsClickedMakeReservation={setIsClickedMakeReservation}
        />
      )}
      {isClickedMakeReservation === 1 && (
        <CheckoutForm
          cardNumber={cardNumber}
          setCardNumber={setCardNumber}
          expiryDate={expiryDate}
          setExpiryDate={setExpiryDate}
          cardHolder={cardHolder}
          setCardHolder={setCardHolder}
          totalPrice={totalPrice}
          nightCount={nightCount}
          guestCount={guestCount}
          handlePayment={handlePayment}
          setIsClickedMakeReservation={setIsClickedMakeReservation}
        />
      )}
      <ToastContainer
        position="top-center"
        autoClose={2000}
        hideProgressBar={false}
        newestOnTop
        closeOnClick
        rtl={false}
        pauseOnFocusLoss
        draggable
        pauseOnHover
        theme="dark"
        transition={Slide}
      />
    </div>
  );
}

export default MakeReservation;
