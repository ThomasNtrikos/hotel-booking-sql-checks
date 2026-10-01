-- QA data-validation checks. Each query should return ZERO rows on clean data.

-- CHECK 1: check-out before check-in
SELECT * FROM bookings WHERE check_out < check_in;

-- CHECK 2: overlapping bookings for the same room
SELECT a.booking_id AS booking_a, b.booking_id AS booking_b, a.room_id
FROM bookings a JOIN bookings b
  ON a.room_id = b.room_id
 AND a.booking_id < b.booking_id
 AND a.check_in < b.check_out
 AND b.check_in < a.check_out;

-- CHECK 3: orphan bookings (no matching guest)
SELECT b.* FROM bookings b
LEFT JOIN guests g ON g.guest_id = b.guest_id
WHERE g.guest_id IS NULL;

-- CHECK 4a: duplicate guests (same email)
SELECT email, COUNT(*) AS copies FROM guests
GROUP BY email HAVING COUNT(*) > 1;

-- CHECK 4b: missing required guest fields
SELECT * FROM guests
WHERE name IS NULL OR name = '' OR email IS NULL OR email = '';

-- CHECK 5: payments that do not match the booking total
SELECT b.booking_id, b.total, COALESCE(SUM(p.amount),0) AS paid
FROM bookings b LEFT JOIN payments p ON p.booking_id = b.booking_id
GROUP BY b.booking_id
HAVING ROUND(paid,2) <> ROUND(b.total,2);
