-- Hotel booking database: schema + made-up data (with deliberately bad records)
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS bookings;
DROP TABLE IF EXISTS rooms;
DROP TABLE IF EXISTS guests;

CREATE TABLE guests (
  guest_id INTEGER PRIMARY KEY,
  name TEXT, email TEXT);
CREATE TABLE rooms (
  room_id INTEGER PRIMARY KEY,
  room_type TEXT, price_per_night REAL);
CREATE TABLE bookings (
  booking_id INTEGER PRIMARY KEY,
  guest_id INTEGER, room_id INTEGER,
  check_in DATE, check_out DATE, total REAL);
CREATE TABLE payments (
  payment_id INTEGER PRIMARY KEY,
  booking_id INTEGER, amount REAL, paid_on DATE);

INSERT INTO guests VALUES
 (1,'Anna Virtanen','anna.virtanen@example.com'),
 (2,'Mikko Korhonen','mikko.k@example.com'),
 (3,'Sofia Papadopoulos','sofia.p@example.com'),
 (4,'John Miller','john.miller@example.com'),
 (5,'Laura Nieminen','laura.n@example.com'),
 (6,'Dimitris Georgiou','dimitris.g@example.com'),
 (7,'Emma Laine','emma.laine@example.com'),
 (8,'Mikko Korhonen','mikko.k@example.com'),   -- BAD: duplicate email
 (9,'','noname@example.com'),                   -- BAD: empty name
 (10,'Peter Salo',NULL);                        -- BAD: missing email

INSERT INTO rooms VALUES
 (1,'Single',89),(2,'Single',89),(3,'Double',119),
 (4,'Double',119),(5,'Suite',189),(6,'Family',149);

INSERT INTO bookings VALUES
 (1,1,1,'2026-10-05','2026-10-08',267),
 (2,2,2,'2026-10-06','2026-10-09',267),
 (3,3,3,'2026-10-07','2026-10-10',357),
 (4,4,4,'2026-10-08','2026-10-11',357),
 (5,5,5,'2026-10-09','2026-10-12',567),
 (6,6,6,'2026-10-10','2026-10-13',447),
 (7,7,1,'2026-10-12','2026-10-14',178),
 (8,1,3,'2026-10-15','2026-10-17',238),
 (9,2,5,'2026-10-16','2026-10-18',378),
 (10,3,2,'2026-10-14','2026-10-16',178),
 (11,4,4,'2026-10-20','2026-10-18',238),  -- BAD: check-out before check-in
 (12,99,6,'2026-10-21','2026-10-23',298), -- BAD: guest 99 does not exist
 (13,5,1,'2026-10-06','2026-10-09',267),  -- BAD: overlaps booking 1 (room 1)
 (14,6,3,'2026-10-16','2026-10-19',357),  -- BAD: overlaps booking 8 (room 3)
 (15,8,2,'2026-10-25','2026-10-27',178);

INSERT INTO payments VALUES
 (1,1,267,'2026-09-20'),(2,2,267,'2026-09-21'),(3,3,357,'2026-09-22'),
 (4,4,357,'2026-09-23'),(5,5,567,'2026-09-24'),(6,6,447,'2026-09-25'),
 (7,7,178,'2026-09-26'),(8,8,238,'2026-09-27'),
 (9,9,300,'2026-09-28'),   -- BAD: underpaid (total 378)
 (10,10,178,'2026-09-28'),
 (11,3,50,'2026-09-29'),   -- BAD: extra payment, booking 3 now overpaid
 (12,13,267,'2026-09-30'),
 (13,14,357,'2026-09-30');
-- Bookings 11, 12 and 15 have no payment at all.
