const API_URL = 'https://localhost:7183/api';

const request = async (endpoint, method = 'GET', body = null) => {
    const options = {
        method,
        headers: {
            'Content-Type': 'application/json',
            // 'Authorization': `Bearer ${token}` // Ýstersen token da ekleyebilirsin
        },
    };

    if (body) {
        options.body = JSON.stringify(body);
    }

    const response = await fetch(`${API_URL}${endpoint}`, options);

    const contentType = response.headers.get('content-type');

    if (!response.ok) {
        if (contentType && contentType.includes('application/json')) {
            const errorData = await response.json();
            throw new Error(errorData.message || 'Bir hata oluþtu.');
        } else {
            const errorText = await response.text();
            throw new Error(errorText || 'Bir hata oluþtu.');
        }
    }

    if (contentType && contentType.includes('application/json')) {
        return response.json();
    } else {
        return response.text(); // Success gibi bir text dönerse
    }
};

export default request;
