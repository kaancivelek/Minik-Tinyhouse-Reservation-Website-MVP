import request from "./api";

export const createNewUser = (data) => request('/Logon', 'POST', data);
export const updateUser = (email, data) => request(`/TinyHouses/${email}`, 'PUT', data);
export const getUserByEmail = (email) => request(`/Logon/${email}`);