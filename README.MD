# Tiny House Reservation and Management System

Full-stack reservation and management system for Tiny House rentals. Built as a university project to explore REST APIs, database-driven design, and team collaboration. This repository represents my early growth phase and is now being polished for a public portfolio.

## Development Team

- Kaan Civelek - Full-stack and project lead
- Naciye Kaya - Backend controllers and models
- Nebi Ciftkaldiran - Backend controllers and models
- Raif Mert Ikier - Database structure and admin panel

## Project Overview

The system allows tenants to search and reserve Tiny Houses, hosts to manage listings and bookings, and administrators to moderate the platform. It includes payments, reviews, user management, and reporting features with an MSSQL-driven schema.

## Tech Stack

Backend
- ASP.NET Core Web API
- ADO.NET
- Microsoft SQL Server

Frontend
- React
- Reactstrap, React Router DOM, Ant Design, Axios, Toastify

## Features by Role

Tenant
- Register and login
- Browse, filter, and reserve Tiny Houses
- Manage reservations
- Make payments
- Submit reviews and ratings

Host
- Create and manage listings
- Approve or reject reservations
- View booking history and tenant feedback
- Track payments and income

Admin
- Manage users
- Cancel bookings
- Moderate listings
- Monitor transactions
- View system statistics and reports

## Database Highlights

- Stored procedures (reservation creation, availability updates)
- Functions (cost calculation)
- Triggers (audit logging)
- Normalized schema with constraints

## Architecture

- Backend API: ASP.NET Core Web API with ADO.NET data access
- Frontend app: React SPA for tenants and hosts
- Admin app: React + Ant Design admin panel
- Database: MSSQL with stored procedures and triggers

## Setup

Prerequisites
- Visual Studio 2022 or later
- Node.js (LTS)
- SQL Server 2019 or later
- SQL Server Management Studio (SSMS)

Database
1. Open SSMS and connect to localhost with Windows Authentication.
2. Run the script in [db.sql](db.sql).

Backend (ASP.NET Core API)
1. Open [backend/backend.sln](backend/backend.sln) in Visual Studio.
2. Verify the connection string in [backend/appsettings.json](backend/appsettings.json).
3. Start the API with F5.

Frontend (main app)
1. In a terminal, run the following commands:

```bash
cd frontend
npm install
npm run dev
```

Admin panel
1. In a new terminal, run the following commands:

```bash
cd frontend/admin
npm install
npm run dev
```

Quick start
- Use [start-project.bat](start-project.bat) to run frontend and backend together.

## Configuration

- API base URL for admin is configured in [frontend/admin/src/services/api.ts](frontend/admin/src/services/api.ts). It defaults to https://localhost:7183/api unless VITE_API_BASE_URL is set.
- Backend connection string is configured in [backend/appsettings.json](backend/appsettings.json).

## API Notes

Auth endpoints
- POST /api/Login/login returns a success string when credentials are valid.
- POST /api/User/login returns user data plus a mock token (used by admin login).
- POST /api/Register/register creates a new user.

Roles
- role_id: 1 = Customer, 2 = Property Owner, 3 = Admin

Pagination
- GET /api/TinyHouses/paged uses offset and limit (used by the main app with a "Load More" button).
- GET /api/TinyHouses/catalog uses page-based paging and is currently unused by the main app.

## Auth Status (Current Behavior)

- Main app stores user data in localStorage after login.
- Admin panel stores a mock token from /api/User/login in localStorage.
- API endpoints are not protected with JWT or authorization middleware.

Recommended upgrade path
- Replace mock token with JWT.
- Add [Authorize] guards on sensitive endpoints.
- Use role-based checks for admin-only actions.

## Known Limitations

- Authentication is minimal and not production grade.
- Authorization is not enforced at the API level.
- Pagination endpoints are inconsistent (page vs offset).
- Some UI state is passed via props instead of shared state/context.

## Roadmap
- Restrating project from zero to hero
- JWT-based auth with role guards
- Unified pagination strategy and reusable UI component
- Centralized auth state (context or Redux) for main app
- Seperated repos handling
- Deployment
## License

See [LICENSE](LICENSE).

## Contributing

This is a university course project developed by students of Hasan Ferdi Turgutlu Technology Faculty, Software Engineering Department. For questions or contributions, please contact the project lead.
