import request from './api.js'

export const getAvailabilityByTinyHouseId = (tinyHouseId) => request(`/Availability/tinyhouse/${tinyHouseId}`, 'GET');

export const getMaintenancesByTinyHouseId = (tinyHouseId) => request(`/Maintenance/tinyhouse/${tinyHouseId}`, 'GET');

export const getReservationsByTinyHouseId = (tinyHouseId) => request(`/Reservation/tinyhouse/${tinyHouseId}`, 'GET');
