# BUG-01: Booking has check-out date before check-in date

**Severity:** High
**Component:** bookings table
**Environment:** hotel.db (SQLite), built from 01_schema_and_data.sql, viewed in DB Browser for SQLite

## Steps to reproduce
1. Open hotel.db in DB Browser for SQLite.
2. In Execute SQL, run: `SELECT * FROM bookings WHERE check_out < check_in;`

## Expected result
No rows. Every booking should check out after it checks in.

## Actual result
1 row returned: booking 11 (check_in 2026-10-20, check_out 2026-10-18).

## Impact
Nights and total cannot be calculated correctly, and the room could be blocked for the wrong dates.
