# Employee-Management-DB-Project
Employee Management DB Project is a database system built with SQL Server for storing and managing employee data. It uses Liquibase for version control and schema management, ensuring smooth database updates. Python scripts automate tasks and facilitate interaction with the database for efficient operations.

## Overview
This project is a robust Employee Management Database designed for real-world use cases. It uses **SQL Server** as the database backend, **Liquibase** for managing schema versioning and changes, and **Python** for automation and integration tasks.

## Key Features

### Database Design

- **Tables** to manage employees, departments, jobs, salaries, and employee job history:
  - `Employee` — Stores employee personal and contact details.
  - `Department` — Stores department information.
  - `Job` — Contains job titles and salary ranges.
  - `EmployeeJob` — Tracks job assignments for employees with dates.
  - `Salary` — Tracks salary history including bonuses and effective dates.

- **Views** for simplified data access:
  - `vw_EmployeeFullDetails` — Combines employee, department, and job information.
  - `vw_CurrentEmployeeSalary` — Shows the latest salary details per employee.

- **Stored Procedures** for common operations:
  - `sp_GetEmployeeByDepartment` — Retrieves employees by department.
  - `sp_UpdateEmployeeSalary` — Updates salary and inserts a new salary record.
  - `sp_AddNewEmployee` — Adds a new employee record.
  - `sp_GetEmployeeHistory` — Fetches full job and salary history for an employee.

- **Indexes** for performance:
  - Unique index on employee emails.
  - Indexes on salary effective dates and department IDs to speed up queries.

## Technologies Used

- **SQL Server** — Reliable and scalable relational database system.
- **Liquibase** — Database schema version control and migration tool.
- **Python** — Automation and data manipulation scripts.
- **Maven** — Manage Liquibase plugin executions.

## Project Structure
├── src/
│ ├── dbresources/ # SQL scripts for tables, views, stored procedures, indexes
│ ├── pyresources/ # Python scripts for automation
│ └── changelogs/ # Liquibase changelog files
├── pom.xml # Maven configuration for Liquibase
├── .gitignore # Git ignore file
└── README.md # Project documentation

## Setup & Usage

### Prerequisites
- SQL Server installed and running.
- Java and Maven installed for Liquibase.
- Python installed for scripts.

### Setup Steps
1. Configure your database connection in the properties files (e.g., `dev.properties`).
2. Run Liquibase to apply schema and initial data:
   ```bash
   mvn liquibase:update -Pdev
