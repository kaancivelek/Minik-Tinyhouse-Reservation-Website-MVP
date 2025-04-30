# Minik-Tiny-House-Reservation-Website
A full-stack reservation and management system for Tiny House rentals with role-based access, developed using React, ASP.NET Core, and MSSQL.
(MVP Rightnow)

# 🏡 Tiny House Reservation and Management System

An end-to-end reservation and management system for renting Tiny Houses, built as a university course project by students of the HFTTF Software Engineering Department.

## 📅 Project Date

March 13, 2025

## 👨‍💻 Development Team

- Naciye Kaya  
- Nebi Çiftkaldıran  
- Raif Mert İkier  
- Kaan Civelek  

## 🧾 Project Description

This system allows **tenants** to search and reserve Tiny Houses, **hosts** to manage listings and bookings, and **administrators** to moderate and supervise the platform's overall activity. It includes functionality for payments, reviews, user management, and statistical reporting. The project emphasizes database-driven development with real-world software engineering practices.

---

## 🔧 Tech Stack

### Backend
- **Framework:** ASP.NET Core Web API
- **ORM:** Entity Framework Core
- **Database:** Microsoft SQL Server (MSSQL)

### Frontend
- **Framework:** React.js
- **Libraries:** Reactstrap, React Router DOM

---

## 🚀 Features by User Role

### 🏠 Tenant
- Register/login
- Browse and filter Tiny Houses
- Make/cancel bookings
- Make online payments
- Submit reviews and ratings

### 👨‍🌾 Host
- Create, edit, and manage listings
- Accept/reject reservation requests
- View booking history and tenant reviews
- Track payments and income

### 🛠️ Admin
- Manage user accounts
- Cancel bookings
- Moderate listings
- Monitor transactions
- View system statistics and reports

---

## 📁 Database Features

- Stored Procedures (e.g., reservation creation)
- Functions (e.g., booking cost calculation)
- Triggers (e.g., log reservation status changes)
- Full ER Diagram with normalized schema (up to 3NF)
- Constraints (Primary, Foreign, Unique, Not Null, Check)

---

## 🖥️ Installation & Running the Project

### 🔐 Database Setup

1. Place `minikDB.bak` in the backup folder:  
   `C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup`

2. Open **SQL Server Management Studio (SSMS)**

3. When connecting:
   - Replace the **Server Name** with `localhost`
   - Click **Connect**

4. Restore the database:
   - Right-click on `Databases` > `Restore Database…`
   - Choose **Device**
   - Click `...`, then `Add`
   - Select `minikDB.bak`, click OK
   - Complete the restore process

---

### ⚙️ Backend Setup (ASP.NET Core API)

> ⚠️ Prerequisite: Visual Studio Installed

1. Navigate to the project’s backend folder
2. Open the `.sln` file using Visual Studio
3. Press `F5` to start the backend server
4. To stop the server, close the console window (black screen with white text)

If not cloned yet:

- Open Visual Studio
- Choose `Clone a repository`
- Connect GitHub and paste the provided URL
- Select a directory and press `Clone`

---

### 🌐 Frontend Setup (React)

> ⚠️ Prerequisite: Node.js and npm installed

1. Open **VS Code**
2. Go to `File > Open Folder…`, and select the `frontend` folder
3. Open terminal via `Terminal > New Terminal`
4. Run the following command:

```bash
npm install
npm start
