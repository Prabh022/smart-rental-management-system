# Smart Rental Management System (SRMS)

An Oracle SQL database for managing residential property rentals: tenants, rental units, leases, rent payments, maintenance requests, and the staff assigned to fix them.

## Tech stack

- Oracle Database (the SQL uses Oracle syntax throughout: `VARCHAR2`, `NUMBER`, sequences, `SYSDATE`, PL/SQL)
- Run with Oracle SQL Developer or Oracle LiveSQL

## Tables

| Table | Purpose | Key columns | Foreign keys |
|---|---|---|---|
| `TENANTS` | People renting a unit | `tenant_id` (PK), `full_name`, `phone`, `email`, `move_in_date` | — |
| `UNITS` | Rental units | `unit_id` (PK), `unit_number`, `unit_type`, `monthly_rent`, `status` | — |
| `LEASES` | A tenant's lease on a unit | `lease_id` (PK), `start_date`, `end_date`, `deposit_amount` | `tenant_id` → `TENANTS`, `unit_id` → `UNITS` |
| `PAYMENTS` | Rent payments against a lease | `payment_id` (PK), `payment_date`, `amount_paid`, `payment_method` | `lease_id` → `LEASES` |
| `MAINTENANCE_REQUESTS` | Maintenance issues reported for a unit | `request_id` (PK), `request_date`, `description`, `status` | `unit_id` → `UNITS` |
| `STAFF` | Maintenance/property staff | `staff_id` (PK), `full_name`, `role` | — |
| `STAFF_ASSIGNMENTS` | Which staff member is assigned to which request | `assignment_id` (PK), `assigned_date` | `request_id` → `MAINTENANCE_REQUESTS`, `staff_id` → `STAFF` |

`UNITS.status` is restricted by a CHECK constraint to `Available` / `Occupied` / `Under Maintenance`; `MAINTENANCE_REQUESTS.status` to `Open` / `In Progress` / `Completed`.

## What's included

- **7 tables** with primary keys, 6 named foreign-key constraints, CHECK constraints, and NOT NULL constraints on required fields
- **7 sequences** (one per table) for generating IDs
- **5 indexes** on foreign-key columns
- **3 views** — `tenant_lease_summary`, `maintenance_request_details`, `staff_assignment_summary`
- **3 stored procedures** (PL/SQL) — `add_payment`, `create_maintenance_request`, `assign_staff_to_request`
- **3 triggers** (PL/SQL) — set a unit to `Under Maintenance` when a request is created, set it to `Occupied` when a lease is created, and reject payments of zero or less
- **11 example queries** (`queries.sql`) — joins, aggregates, `NOT EXISTS` checks, and date-based reports such as monthly revenue, upcoming lease expiries, and average rent by unit type
- **Sample data** — 3 tenants, 3 units, 2 leases, 3 payments, 2 maintenance requests, 3 staff, 2 assignments

## Files and run order

Run the scripts in this order in SQL Developer or LiveSQL:

1. `schema.sql` — drops (for re-runs) and creates the tables, sequences, and indexes
2. `sample_data.sql` — inserts the sample rows
3. `views.sql` — creates the 3 views
4. `procedures.sql` — creates the 3 stored procedures
5. `triggers.sql` — creates the 3 triggers
6. `queries.sql` — 11 example queries to run against the data

Notes:

- `schema.sql` starts with `DROP TABLE` / `DROP SEQUENCE` statements so the script can be re-run. On a **first** run, against an empty database, those drops report "does not exist" errors — that is expected and the rest of the script still creates everything.
- `procedures.sql` and `triggers.sql` end each block with `/` and `SHOW ERRORS;` — these are SQL*Plus / SQL Developer commands, so run those files as scripts in an Oracle client rather than pasting them into a generic SQL tool.
