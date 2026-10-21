

-- Smart Rental Management System (SRMS)
-- Schema definition

-- Drop tables (optional, for reset)
DROP TABLE STAFF_ASSIGNMENTS CASCADE CONSTRAINTS;
DROP TABLE MAINTENANCE_REQUESTS CASCADE CONSTRAINTS;
DROP TABLE PAYMENTS CASCADE CONSTRAINTS;
DROP TABLE LEASES CASCADE CONSTRAINTS;
DROP TABLE UNITS CASCADE CONSTRAINTS;
DROP TABLE STAFF CASCADE CONSTRAINTS;
DROP TABLE TENANTS CASCADE CONSTRAINTS;

-- Drop sequences (optional)
DROP SEQUENCE tenants_seq;
DROP SEQUENCE units_seq;
DROP SEQUENCE leases_seq;
DROP SEQUENCE payments_seq;
DROP SEQUENCE requests_seq;
DROP SEQUENCE staff_seq;
DROP SEQUENCE assignments_seq;

-- TENANTS
CREATE TABLE TENANTS (
    tenant_id      NUMBER PRIMARY KEY,
    full_name      VARCHAR2(100) NOT NULL,
    phone          VARCHAR2(20),
    email          VARCHAR2(100),
    move_in_date   DATE
);

-- UNITS
CREATE TABLE UNITS (
    unit_id        NUMBER PRIMARY KEY,
    unit_number    VARCHAR2(10) NOT NULL,
    unit_type      VARCHAR2(20),
    monthly_rent   NUMBER(10,2),
    status         VARCHAR2(20) CHECK (status IN ('Available', 'Occupied', 'Under Maintenance'))
);

-- LEASES
CREATE TABLE LEASES (
    lease_id       NUMBER PRIMARY KEY,
    tenant_id      NUMBER NOT NULL,
    unit_id        NUMBER NOT NULL,
    start_date     DATE NOT NULL,
    end_date       DATE,
    deposit_amount NUMBER(10,2),
    CONSTRAINT fk_leases_tenant FOREIGN KEY (tenant_id) REFERENCES TENANTS(tenant_id),
    CONSTRAINT fk_leases_unit FOREIGN KEY (unit_id) REFERENCES UNITS(unit_id)
);

-- PAYMENTS
CREATE TABLE PAYMENTS (
    payment_id     NUMBER PRIMARY KEY,
    lease_id       NUMBER NOT NULL,
    payment_date   DATE NOT NULL,
    amount_paid    NUMBER(10,2) NOT NULL,
    payment_method VARCHAR2(20),
    CONSTRAINT fk_payments_lease FOREIGN KEY (lease_id) REFERENCES LEASES(lease_id)
);

-- MAINTENANCE_REQUESTS
CREATE TABLE MAINTENANCE_REQUESTS (
    request_id     NUMBER PRIMARY KEY,
    unit_id        NUMBER NOT NULL,
    request_date   DATE NOT NULL,
    description    VARCHAR2(200),
    status         VARCHAR2(20) CHECK (status IN ('Open', 'In Progress', 'Completed')),
    CONSTRAINT fk_requests_unit FOREIGN KEY (unit_id) REFERENCES UNITS(unit_id)
);

-- STAFF
CREATE TABLE STAFF (
    staff_id       NUMBER PRIMARY KEY,
    full_name      VARCHAR2(100) NOT NULL,
    role           VARCHAR2(50)
);

-- STAFF_ASSIGNMENTS
CREATE TABLE STAFF_ASSIGNMENTS (
    assignment_id  NUMBER PRIMARY KEY,
    request_id     NUMBER NOT NULL,
    staff_id       NUMBER NOT NULL,
    assigned_date  DATE NOT NULL,
    CONSTRAINT fk_assign_request FOREIGN KEY (request_id) REFERENCES MAINTENANCE_REQUESTS(request_id),
    CONSTRAINT fk_assign_staff FOREIGN KEY (staff_id) REFERENCES STAFF(staff_id)
);

-- Sequences
CREATE SEQUENCE tenants_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE units_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE leases_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE payments_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE requests_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE staff_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE assignments_seq START WITH 1 INCREMENT BY 1;

-- Indexes (optional for performance)
CREATE INDEX idx_leases_tenant ON LEASES(tenant_id);
CREATE INDEX idx_leases_unit ON LEASES(unit_id);
CREATE INDEX idx_payments_lease ON PAYMENTS(lease_id);
CREATE INDEX idx_requests_unit ON MAINTENANCE_REQUESTS(unit_id);
CREATE INDEX idx_assign_staff ON STAFF_ASSIGNMENTS(staff_id);
