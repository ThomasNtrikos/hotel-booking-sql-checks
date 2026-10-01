# BUG-02: Same room booked by two guests on overlapping dates

**Severity:** Critical
**Component:** bookings table
**Environment:** hotel.db (SQLite), built from 01_schema_and_data.sql, viewed in DB Browser for SQLite

## Steps to reproduce
1. Open hotel.db in DB Browser for SQLite.
2. Run the overlap check (CHECK 2 in 02_data_checks.sql), which joins bookings to itself on the same room_id and compares the date ranges.

## Expected result
No rows. A room cannot have two bookings at the same time.

## Actual result
2 rows returned:
- Bookings 1 and 13, room 1 (2026-10-05 to 10-08 and 2026-10-06 to 10-09)
- Bookings 8 and 14, room 3 (2026-10-15 to 10-17 and 2026-10-16 to 10-19)

## Impact
Double bookings: two guests arrive for the same room.
