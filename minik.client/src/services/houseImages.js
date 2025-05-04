import request from './api';

export const getAllTinyHouseImages = () => request('/house_images');
export const getTinyHouseImagesByTinyHouseId = (tiny_house_id) => request(`/house_images/${tiny_house_id}`);
