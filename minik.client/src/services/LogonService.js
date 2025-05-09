import request from "./api";

export const createNewUser = (data) => request('/Logon', 'POST', data);
export const updateUser = (email, data) => request(`/Logon/${email}`, 'PUT', data);
export const getUserByEmail = (email) => request(`/Logon/${email}`);
export const deleteUser = (email) => request(`/Logon/${email}`, 'DELETE');
export const validateUser = (email, password) => request(`/Logon/validate`, 'POST', { email, password });
export const validateEmail = (email) => request(`/Logon/validateEmail`, 'POST', { email });
export const validatePassword = (password) => {request(`/Logon/validatePassword`, 'POST', { password })};
