import React, { useState } from 'react';
import { useNavigate } from "react-router-dom";
import "../styles/ListingPage.css"; // Mevcut temayı korumak için stil dosyasını ekledik

export default function ProfileEditings({ user, setUser }) {
    const navigate = useNavigate();
    const [formData, setFormData] = useState({
        full_name: user?.full_name || "",
        email: user?.email || "",
        phone_number: user?.phone_number || "",
        role_id: user?.role_id || "",
        password: ""
    });

    const handleInputChange = (e) => {
        const { name, value } = e.target;
        setFormData({
            ...formData,
            [name]: value
        });
    };

    const handleSubmit = (e) => {
        e.preventDefault();
        localStorage.setItem("user", JSON.stringify(formData));
        setUser(formData);
        navigate("/Profile");
    };

    return (
        <div className="profile-edit-container" style={{ maxWidth: "400px", margin: "auto", padding: "20px", border: "1px solid #ccc", borderRadius: "10px" }}>
            <h2>Bilgilerini Düzenle</h2>
            <form onSubmit={handleSubmit} style={{ display: "flex", flexDirection: "column", gap: "15px" }}>
            <div>
                    <label htmlFor="id">ID:</label>
                    <input
                        type="number"
                        id="id"
                        name="id"
                        value={formData.id}
                        onChange={handleInputChange}
                        style={{ width: "100%", padding: "8px", borderRadius: "5px", border: "1px solid #ccc" }}
                    />
                </div>
            
                <div>
                    <label htmlFor="full_name">Ad Soyad:</label>
                    <input
                        type="text"
                        id="full_name"
                        name="full_name"
                        value={formData.full_name}
                        onChange={handleInputChange}
                        style={{ width: "100%", padding: "8px", borderRadius: "5px", border: "1px solid #ccc" }}
                    />
                </div>
                <div>
                    <label htmlFor="email">Email:</label>
                    <input
                        type="email"
                        id="email"
                        name="email"
                        value={formData.email}
                        onChange={handleInputChange}
                        style={{ width: "100%", padding: "8px", borderRadius: "5px", border: "1px solid #ccc" }}
                    />
                </div>
                <div>
                    <label htmlFor="phone_number">Telefon:</label>
                    <input
                        type="text"
                        id="phone_number"
                        name="phone_number"
                        value={formData.phone_number}
                        onChange={handleInputChange}
                        style={{ width: "100%", padding: "8px", borderRadius: "5px", border: "1px solid #ccc" }}
                    />
                </div>
                <div>
                    <label htmlFor="role_id">Rol ID:</label>
                    <input
                        type="number"
                        id="role_id"
                        name="role_id"
                        value={formData.role_id}
                        onChange={handleInputChange}
                        style={{ width: "100%", padding: "8px", borderRadius: "5px", border: "1px solid #ccc" }}
                    />
                </div>
                <div>
                    <label htmlFor="password">Şifre:</label>
                    <input
                        type="password"
                        id="password"
                        name="password"
                        value={formData.password}
                        onChange={handleInputChange}
                        style={{ width: "100%", padding: "8px", borderRadius: "5px", border: "1px solid #ccc" }}
                    />
                </div>
                <button type="submit" style={{ padding: "10px", borderRadius: "5px", backgroundColor: "var(--accent-color)", color: "white", border: "none", cursor: "pointer" }}>
                    Kaydet
                </button>
            </form>
        </div>
    );
}
