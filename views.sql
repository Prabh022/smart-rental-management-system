-- Views for SRMS

-- View: Tenant Lease Summary
CREATE OR REPLACE VIEW tenant_lease_summary AS
SELECT t.tenant_id,
       t.full_name,
       u.unit_number,
       l.start_date,
       l.end_date,
       u.monthly_rent
FROM TENANTS t
JOIN LEASES l ON t.tenant_id = l.tenant_id
JOIN UNITS u ON l.unit_id = u.unit_id;

-- View: Maintenance Request Details
CREATE OR REPLACE VIEW maintenance_request_details AS
SELECT m.request_id,
       u.unit_number,
       m.request_date,
       m.description,
       m.status
FROM MAINTENANCE_REQUESTS m
JOIN UNITS u ON m.unit_id = u.unit_id;

-- View: Staff Assignment Summary
CREATE OR REPLACE VIEW staff_assignment_summary AS
SELECT s.staff_id,
       s.full_name,
       s.role,
       m.request_id,
       m.description,
       m.status,
       a.assigned_date
FROM STAFF s
JOIN STAFF_ASSIGNMENTS a ON s.staff_id = a.staff_id
JOIN MAINTENANCE_REQUESTS m ON a.request_id = m.request_id;
