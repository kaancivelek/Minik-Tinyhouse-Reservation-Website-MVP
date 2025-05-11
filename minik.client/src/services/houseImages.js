import request from './api';

export const getAllTinyHouseImages = () => request('/HouseImages');
export const getTinyHouseImagesByTinyHouseId = (tiny_house_id) => request(`/HouseImages/${tiny_house_id}`);
