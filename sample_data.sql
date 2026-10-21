-- Sample data for SRMS

-- TENANTS
INSERT INTO TENANTS (tenant_id, full_name, phone, email, move_in_date)
VALUES (1, 'John Doe', '647-555-1234', 'john@example.com', DATE '2024-01-10');

INSERT INTO TENANTS (tenant_id, full_name, phone, email, move_in_date)
VALUES (2, 'Aman Singh', '416-555-9876', 'aman@example.com', DATE '2024-03-01');

INSERT INTO TENANTS (tenant_id, full_name, phone, email, move_in_date)
VALUES (3, 'Maria Lopez', '905-555-2222', 'maria@example.com', DATE '2024-02-20');

-- UNITS
INSERT INTO UNITS (unit_id, unit_number, unit_type, monthly_rent, status)
VALUES (1, 'A101', '1BHK', 1500, 'Occupied');

INSERT INTO UNITS (unit_id, unit_number, unit_type, monthly_rent, status)
VALUES (2, 'B202', '2BHK', 2100, 'Available');

INSERT INTO UNITS (unit_id, unit_number, unit_type, monthly_rent, status)
VALUES (3, 'C303', 'Studio', 1200, 'Occupied');

-- LEASES
INSERT INTO LEASES (lease_id, tenant_id, unit_id, start_date, end_date, deposit_amount)
VALUES (1, 1, 1, DATE '2024-01-10', DATE '2025-01-10', 1500);

INSERT INTO LEASES (lease_id, tenant_id, unit_id, start_date, end_date, deposit_amount)
VALUES (2, 3, 3, DATE '2024-02-20', DATE '2025-02-20', 1200);

-- PAYMENTS
INSERT INTO PAYMENTS (payment_id, lease_id, payment_date, amount_paid, payment_method)
VALUES (1, 1, DATE '2024-02-01', 1500, 'Credit');

INSERT INTO PAYMENTS (payment_id, lease_id, payment_date, amount_paid, payment_method)
VALUES (2, 1, DATE '2024-03-01', 1500, 'Credit');

INSERT INTO PAYMENTS (payment_id, lease_id, payment_date, amount_paid, payment_method)
VALUES (3, 2, DATE '2024-03-01', 1200, 'Debit');

-- MAINTENANCE_REQUESTS
INSERT INTO MAINTENANCE_REQUESTS (request_id, unit_id, request_date, description, status)
VALUES (1, 1, DATE '2024-02-15', 'Heating not working', 'Open');

INSERT INTO MAINTENANCE_REQUESTS (request_id, unit_id, request_date, description, status)
VALUES (2, 3, DATE '2024-03-05', 'Leaky faucet', 'In Progress');

-- STAFF
INSERT INTO STAFF (staff_id, full_name, role)
VALUES (1, 'Mike Johnson', 'Technician');

INSERT INTO STAFF (staff_id, full_name, role)
VALUES (2, 'Sarah Lee', 'Electrician');

INSERT INTO STAFF (staff_id, full_name, role)
VALUES (3, 'David Chen', 'Plumber');

-- STAFF_ASSIGNMENTS
INSERT INTO STAFF_ASSIGNMENTS (assignment_id, request_id, staff_id, assigned_date)
VALUES (1, 1, 1, DATE '2024-02-16');

INSERT INTO STAFF_ASSIGNMENTS (assignment_id, request_id, staff_id, assigned_date)
VALUES (2, 2, 3, DATE '2024-03-06');
