# Minik-Tiny-House-Reservation-Website
A full-stack reservation and management system for Tiny House rentals with role-based access
developed using React, ASP.NET Core, and MSSQL. (MVP Rightnow)

# 🏡 Tiny House Reservation and Management System

An end-to-end reservation and management system for renting Tiny Houses, built as a university course project by students of the Hasan Ferdi Turgutlu Technology Faculty, Software Engineering Department.

## 📅 Project Date

March 13, 2025

## 👨‍💻 Development Team

- Naciye Kaya - Backend Controllers And Models  
- Nebi Çiftkaldıran - Backend Controllers And Models
- Raif Mert İkier - Database Structure And Model
- Kaan Civelek - Full-Stack & Project Lead

## 🧾 Project Description

This system allows **tenants** to search and reserve Tiny Houses, **hosts** to manage listings and bookings, and **administrators** to moderate and supervise the platform's overall activity. It includes functionality for payments, reviews, user management, and statistical reporting. The project emphasizes database-driven development with real-world software engineering practices.

---

## 🔧 Tech Stack

### Backend
- **Framework:** ASP.NET Core Web API
- **SQL SCRIPTS** ADO.NET
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


1. Open **SQL Server Management Studio (SSMS)**

2. When connecting:
   - Replace the **Server Name** with `localhost`
   - Click **Connect**

3. Execute SQL script `minikDB.sql' in root folder.
---

### ⚙️ Backend Setup (ASP.NET Core API)

> ⚠️ Prerequisite: Visual Studio, Node.Js Installed, SQL Server Version >15, SSMS Studio

1. Navigate to the project’s backend folder
2. Open the `.sln` file using Visual Studio
3. Configure launch properties for launching multiple starting project.
3. Press `F5` to start the server
4. To stop the server, close the console window (black screen with white text)

If not cloned yet:

- Open Visual Studio
- Choose `Clone a repository`
- Connect GitHub and paste the provided URL
- Select a directory and press `Clone`

