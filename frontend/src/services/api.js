const API_URL = 'https://localhost:7183/api';

const request = async (endpoint, method = 'GET', body = null) => {
    let token = localStorage.getItem('adminToken');
    if (!token) {
        const storedUser = localStorage.getItem('user');
        if (storedUser) {
            try {
                token = JSON.parse(storedUser).token;
            } catch {
                token = null;
            }
        }
    }

    const headers = {
        'Content-Type': 'application/json',
    };

    if (token) {
        headers.Authorization = `Bearer ${token}`;
    }

    const options = {
        method,
        headers,
    };

    if (body) {
        options.body = JSON.stringify(body);
    }

    const response = await fetch(`${API_URL}${endpoint}`, options);

    const contentType = response.headers.get('content-type');

    if (!response.ok) {
        if (contentType && contentType.includes('application/json')) {
            const errorData = await response.json();
            throw new Error(errorData.message || 'Bir hata olustu.');
        } else {
            const errorText = await response.text();
            throw new Error(errorText || 'Bir hata olustu.');
        }
    }

    if (contentType && contentType.includes('application/json')) {
        return response.json();
    }

    return response.text();
};

export default request;
