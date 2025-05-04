import request from './api';

export const getAllTinyHouses = () => request('/TinyHouses');
export const getTinyHouseById = (id) => request(`/TinyHouses/${id}`);
export const getTinyHouseByName = (name) => request(`/TinyHouses/${name}`);
export const createTinyHouse = (data) => request('/TinyHouses', 'POST', data);
export const updateTinyHouse = (id, data) => request(`/TinyHouses/${id}`, 'PUT', data);
export const deleteTinyHouse = (id) => request(`/TinyHouses/${id}`, 'DELETE');
