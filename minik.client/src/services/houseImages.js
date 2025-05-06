import request from './api';

export const getAllTinyHouseImages = () => request('/HouseImages');
export const getTinyHouseImagesByTinyHouseId = (tinyHouseId) => request(`/HouseImages/${tinyHouseId}`);
