# BUG-03: Booking refers to a guest that does not exist

**Severity:** High
**Component:** bookings and guests tables
**Environment:** hotel.db (SQLite), built from 01_schema_and_data.sql, viewed in DB Browser for SQLite

## Steps to reproduce
1. Open hotel.db in DB Browser for SQLite.
2. Run CHECK 3 in 02_data_checks.sql (bookings LEFT JOIN guests, where the guest is missing).

## Expected result
No rows. Every booking should have a matching guest.

## Actual result
1 row returned: booking 12 has guest_id 99, and no guest 99 exists.

## Impact
The booking has no owner, so staff cannot contact the guest or match a payment to a person.
