import React, { useEffect } from 'react';
import AdminPanel from '../components/AdminPanel';
import CustomerPanel from '../components/CustomerPanel';
import PropertyOwnerPanel from '../components/PropertyOwnerPanel';

export default function Profile({ user }) {



  const getRoleName = (roleId) => {
    switch (roleId) {
      case 3: return "Admin";
      case 1: return "Müşteri";
      case 2: return "Emlak Sahibi";
      default: return "Bilinmeyen Rol";
    }
  };

  const getPanelByRole = (roleId) => {
  switch (roleId) {
    case 1:
      return <CustomerPanel />;
    case 2:
      return <PropertyOwnerPanel user={user}/>;
    case 3:
      return <AdminPanel />;
    default:
      return <div>Panel bulunamadı</div>;
  }
};


 

  return (<>
    <div className="profile-container" style={{ padding: '20px', maxWidth: '300px', margin: 'auto', border: '1px solid #ccc', borderRadius: '10px' }}>
      <h2>Profil Bilgileri</h2>
      <p><strong>Ad Soyad:</strong> {user.full_name}</p>
      <p><strong>Email:</strong> {user.email}</p>
      <p><strong>Telefon:</strong> {user.phone_number}</p>
      <p><strong>Rol:</strong> {getRoleName(user.role_id)}</p>
    

    </div>

    <div>{getPanelByRole(user.role_id)}</div>
    </>
  );
}
