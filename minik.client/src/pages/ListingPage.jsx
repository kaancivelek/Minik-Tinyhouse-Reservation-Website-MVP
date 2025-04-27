import React, { useState, useEffect } from 'react';
import { getAllTinyHouses, deleteTinyHouse } from '../services/tinyHouseService'

const ListingPage = () => {
    const [listings, setListings] = useState([]);
    const [loading, setLoading] = useState(false);
    const [error, setError] = useState('');

    const fetchListings = async () => {
        setLoading(true);
        try {
            const data = await getAllTinyHouses();
            setListings(data);
        } catch (err) {
            setError(err.message);
        } finally {
            setLoading(false);
        }
    };

    useEffect(() => {
        fetchListings();
    }, []);

    const handleDelete = async (id) => {
        try {
            await deleteTinyHouse(id);
            setListings((prev) => prev.filter((listing) => listing.id !== id));
        } catch (err) {
            console.error(err.message);
        }
    };

    if (loading) return <p>Yükleniyor...</p>;
    if (error) return <p>Hata: {error}</p>;

    return (
        <div>
            <h1>Ýlanlar</h1>
            <ul>
                {listings.map((item) => (
                    <li key={item.id}>
                        {item.name}
                        <button onClick={() => handleDelete(item.id)}>Sil</button>
                    </li>
                ))}
            </ul>
        </div>
    );
};

export default ListingPage;
