# Changes made when extracting this project from sql-projects-portfolio

## Update — October 31, 2026

**Query 11: average monthly rent by unit type.** Added to
`queries.sql`: average `monthly_rent` grouped by `unit_type`, with a
unit count per type, ordered by type. Uses only standard aggregate
syntax, so it runs as written in Oracle and in SQLite. Verified
against the sample data (SQLite): 1BHK — 1 unit, 1500.00; 2BHK — 1
unit, 2100.00; Studio — 1 unit, 1200.00. README updated (10 → 11
example queries).

## SQL files: no changes

All six `.sql` files (`schema.sql`, `sample_data.sql`, `views.sql`, `procedures.sql`, `triggers.sql`, `queries.sql`) are byte-for-byte copies of the originals in the `smart_rental_management_system/` folder of the old portfolio repo. Structural testing found no syntax errors that needed fixing, so the user's SQL was left exactly as written.

## Documentation changes

- This standalone `README.md` replaces both the old portfolio README and the project's original README. Claims in the old READMEs that the files don't support were dropped:
  - The portfolio README advertised three more projects ("Sales Reporting", "Customer Segmentation", "Inventory Analysis") and a `property-management-database` folder — none of them exist in that repo. This rental system was the only real project.
  - The original project README mentioned "ER modeling" — there is no ER diagram file in the project, so that claim is gone.
  - The original project README's structure diagram showed a `sql/` subfolder; the files actually sit flat, and the new README says so.

## Known quirks (documented, deliberately not "fixed")

- `schema.sql` begins with `DROP` statements for re-running the script; on a first run they report "does not exist" errors in Oracle. Expected behaviour, explained in the README.
- The comment above the `trg_payment_check` trigger in `triggers.sql` says "Log payment date if amount is zero", but the trigger actually raises an error when a payment amount is zero or less. The code is correct; only the comment's wording is off. Left as the author wrote it.
- `sample_data.sql` inserts literal IDs instead of using the sequences. Valid and consistent — the sequences are used by the stored procedures.
