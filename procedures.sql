-- Stored procedures for SRMS

-- Procedure: Add a payment for a lease
CREATE OR REPLACE PROCEDURE add_payment (
    p_lease_id  IN NUMBER,
    p_amount    IN NUMBER,
    p_method    IN VARCHAR2
)
AS
BEGIN
    INSERT INTO PAYMENTS (payment_id, lease_id, payment_date, amount_paid, payment_method)
    VALUES (payments_seq.NEXTVAL, p_lease_id, SYSDATE, p_amount, p_method);
END;
/
SHOW ERRORS;

-- Procedure: Create a maintenance request
CREATE OR REPLACE PROCEDURE create_maintenance_request (
    p_unit_id    IN NUMBER,
    p_desc       IN VARCHAR2
)
AS
BEGIN
    INSERT INTO MAINTENANCE_REQUESTS (request_id, unit_id, request_date, description, status)
    VALUES (requests_seq.NEXTVAL, p_unit_id, SYSDATE, p_desc, 'Open');
END;
/
SHOW ERRORS;

-- Procedure: Assign staff to a maintenance request
CREATE OR REPLACE PROCEDURE assign_staff_to_request (
    p_request_id IN NUMBER,
    p_staff_id   IN NUMBER
)
AS
BEGIN
    INSERT INTO STAFF_ASSIGNMENTS (assignment_id, request_id, staff_id, assigned_date)
    VALUES (assignments_seq.NEXTVAL, p_request_id, p_staff_id, SYSDATE);
END;
/
SHOW ERRORS;
