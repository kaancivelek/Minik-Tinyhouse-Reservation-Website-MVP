import request from './api.js'

export const getAvailabilityByTinyHouseId = (tinyHouseId) => request(`/Availability/tinyhouse/${tinyHouseId}`, 'GET');
export const addAvailability =(body) => request('/Availability', 'POST', body);
export const getMaintenancesByTinyHouseId = (tinyHouseId) => request(`/Maintenance/tinyhouse/${tinyHouseId}`, 'GET');
export const getReservationsByTinyHouseId = (tinyHouseId) => request(`/Reservations/tinyhouse/${tinyHouseId}`, 'GET');
