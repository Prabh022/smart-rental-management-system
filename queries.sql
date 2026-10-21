-- Useful and advanced queries for SRMS

-- 1. List all tenants with their unit numbers
SELECT t.full_name, u.unit_number
FROM TENANTS t
JOIN LEASES l ON t.tenant_id = l.tenant_id
JOIN UNITS u ON l.unit_id = u.unit_id;

-- 2. Total rent collected per tenant
SELECT t.full_name, SUM(p.amount_paid) AS total_paid
FROM TENANTS t
JOIN LEASES l ON t.tenant_id = l.tenant_id
JOIN PAYMENTS p ON l.lease_id = p.lease_id
GROUP BY t.full_name;

-- 3. Units currently available
SELECT unit_number, unit_type, monthly_rent
FROM UNITS
WHERE status = 'Available';

-- 4. Maintenance requests still open or in progress
SELECT u.unit_number, m.description, m.status
FROM MAINTENANCE_REQUESTS m
JOIN UNITS u ON m.unit_id = u.unit_id
WHERE m.status != 'Completed';

-- 5. Staff workload count
SELECT s.full_name, COUNT(a.assignment_id) AS tasks_assigned
FROM STAFF s
LEFT JOIN STAFF_ASSIGNMENTS a ON s.staff_id = a.staff_id
GROUP BY s.full_name;

-- 6. Rent overdue (no payment this month)
SELECT t.full_name, u.unit_number
FROM TENANTS t
JOIN LEASES l ON t.tenant_id = l.tenant_id
JOIN UNITS u ON l.unit_id = u.unit_id
WHERE NOT EXISTS (
    SELECT 1
    FROM PAYMENTS p
    WHERE p.lease_id = l.lease_id
      AND EXTRACT(MONTH FROM p.payment_date) = EXTRACT(MONTH FROM SYSDATE)
      AND EXTRACT(YEAR FROM p.payment_date) = EXTRACT(YEAR FROM SYSDATE)
);

-- 7. Monthly revenue summary
SELECT EXTRACT(YEAR FROM payment_date) AS year,
       EXTRACT(MONTH FROM payment_date) AS month,
       SUM(amount_paid) AS total_revenue
FROM PAYMENTS
GROUP BY EXTRACT(YEAR FROM payment_date), EXTRACT(MONTH FROM payment_date)
ORDER BY year, month;

-- 8. Units with no maintenance requests
SELECT u.unit_number
FROM UNITS u
WHERE NOT EXISTS (
    SELECT 1
    FROM MAINTENANCE_REQUESTS m
    WHERE m.unit_id = u.unit_id
);

-- 9. Tenants with upcoming lease expiry (next 60 days)
SELECT t.full_name, u.unit_number, l.end_date
FROM TENANTS t
JOIN LEASES l ON t.tenant_id = l.tenant_id
JOIN UNITS u ON l.unit_id = u.unit_id
WHERE l.end_date IS NOT NULL
  AND l.end_date BETWEEN SYSDATE AND SYSDATE + 60;

-- 10. Staff assigned to open maintenance requests
SELECT s.full_name, m.description, m.status
FROM STAFF s
JOIN STAFF_ASSIGNMENTS a ON s.staff_id = a.staff_id
JOIN MAINTENANCE_REQUESTS m ON a.request_id = m.request_id
WHERE m.status IN ('Open', 'In Progress');
