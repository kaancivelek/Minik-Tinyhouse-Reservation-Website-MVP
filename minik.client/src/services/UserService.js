import request from './api';

export const updateUser = (email, data) => request(`/User/update/${email}`, 'PATCH', data);