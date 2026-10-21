-- Triggers for SRMS

-- Trigger: Auto-update unit status when maintenance request is created
CREATE OR REPLACE TRIGGER trg_unit_maintenance
AFTER INSERT ON MAINTENANCE_REQUESTS
FOR EACH ROW
BEGIN
    UPDATE UNITS
    SET status = 'Under Maintenance'
    WHERE unit_id = :NEW.unit_id;
END;
/
SHOW ERRORS;

-- Trigger: Set unit status to Occupied when a lease is created
CREATE OR REPLACE TRIGGER trg_unit_occupied
AFTER INSERT ON LEASES
FOR EACH ROW
BEGIN
    UPDATE UNITS
    SET status = 'Occupied'
    WHERE unit_id = :NEW.unit_id;
END;
/
SHOW ERRORS;

-- Trigger: Log payment date if amount is zero (example validation)
CREATE OR REPLACE TRIGGER trg_payment_check
BEFORE INSERT ON PAYMENTS
FOR EACH ROW
BEGIN
    IF :NEW.amount_paid <= 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Payment amount must be greater than zero.');
    END IF;
END;
/
SHOW ERRORS;
