import request from './api'
export const getReservationByUserId = (userId) => request(`/Reservations/user/${userId}`, 'GET')
export const postReservation = (reservationData) => 
    request('/Reservations', 'POST', reservationData);