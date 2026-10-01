# Hotel Booking Database: SQL Data-Validation Checks

A small SQLite project that checks a made-up hotel booking database for the kinds of data problems a QA tester looks for: bad dates, double bookings, orphan records, duplicates, missing fields and payment mismatches.

## What's in the repo

| File | Purpose |
|---|---|
| `01_schema_and_data.sql` | Creates 4 tables (guests, rooms, bookings, payments) and inserts 44 made-up rows, including deliberately bad records |
| `02_data_checks.sql` | Six validation queries. Each should return zero rows on clean data |

## How to run

1. Open DB Browser for SQLite and create a new empty database.
2. Run `01_schema_and_data.sql` in the Execute SQL tab.
3. Run the queries in `02_data_checks.sql` one at a time.

## Checks and findings

| # | Check | What it looks for | Found |
|---|---|---|---|
| 1 | Date order | `check_out` earlier than `check_in` | Booking 11 |
| 2 | Overlaps | Two bookings for the same room with overlapping dates | Bookings 1 and 13 (room 1), 8 and 14 (room 3) |
| 3 | Orphan bookings | Bookings whose `guest_id` has no guest | Booking 12 (guest 99) |
| 4a | Duplicate guests | Same email on more than one guest | mikko.k@example.com (guests 2 and 8) |
| 4b | Missing fields | Empty or NULL name or email | Guest 9 (no name), guest 10 (no email) |
| 5 | Payment mismatch | Amount paid differs from booking total | Booking 3 overpaid; booking 9 underpaid; bookings 11, 12, 15 unpaid |

## Notes

- All data is invented. The bad records are marked with `-- BAD` comments in the data script.
- Overlap logic treats same-day turnover (one guest leaves the day another arrives) as valid.
- Payment totals are rounded to 2 decimals before comparing, to avoid floating-point false positives.

## Possible next steps

- Add a check for `total` not matching nights × `price_per_night`.
- Add foreign key constraints and show which bad records they would have blocked.
