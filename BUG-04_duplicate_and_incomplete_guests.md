# BUG-04: Duplicate guest email and guests with missing required fields

**Severity:** Medium
**Component:** guests table
**Environment:** hotel.db (SQLite), built from 01_schema_and_data.sql, viewed in DB Browser for SQLite

## Steps to reproduce
1. Open hotel.db in DB Browser for SQLite.
2. Run CHECK 4a (group by email, count above 1) and CHECK 4b (name or email empty or NULL) from 02_data_checks.sql.

## Expected result
No rows from either query. Each email belongs to one guest, and name and email are always filled in.

## Actual result
- 4a: mikko.k@example.com appears twice (guests 2 and 8).
- 4b: guest 9 has an empty name; guest 10 has no email.

## Impact
Duplicate profiles split a guest's history, and missing contact details block confirmations.
