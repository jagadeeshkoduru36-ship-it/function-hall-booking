CREATE TABLE IF NOT EXISTS users (
    user_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    phone VARCHAR(20),
    password VARCHAR(255) NOT NULL,
    role VARCHAR(20) DEFAULT 'USER'
);

CREATE TABLE IF NOT EXISTS halls (
    hall_id SERIAL PRIMARY KEY,
    hall_name VARCHAR(150) NOT NULL,
    location VARCHAR(200) NOT NULL,
    capacity INT NOT NULL,
    hall_price NUMERIC(10,2) NOT NULL,
    description TEXT,
    available BOOLEAN DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS services (
    service_id SERIAL PRIMARY KEY,
    service_name VARCHAR(100) NOT NULL,
    service_type VARCHAR(50) NOT NULL,
    price NUMERIC(10,2) NOT NULL
);

CREATE TABLE IF NOT EXISTS bookings (
    booking_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES users(user_id),
    hall_id INT NOT NULL REFERENCES halls(hall_id),
    booking_date DATE NOT NULL,
    guests INT NOT NULL,
    total_amount NUMERIC(12,2) NOT NULL,
    status VARCHAR(30) DEFAULT 'PENDING'
);

CREATE TABLE IF NOT EXISTS booking_services (
    booking_service_id SERIAL PRIMARY KEY,
    booking_id INT NOT NULL REFERENCES bookings(booking_id) ON DELETE CASCADE,
    service_id INT NOT NULL REFERENCES services(service_id),
    quantity INT NOT NULL,
    cost NUMERIC(12,2) NOT NULL
);

INSERT INTO halls (hall_name, location, capacity, hall_price, description)
SELECT 'Sri Lakshmi Function Hall', 'Tirupati', 500, 25000,
       'Spacious hall suitable for weddings, receptions and family events.'
WHERE NOT EXISTS (
    SELECT 1 FROM halls WHERE hall_name = 'Sri Lakshmi Function Hall'
);

INSERT INTO services (service_name, service_type, price)
SELECT 'Cushioned Chair', 'CHAIR', 25
WHERE NOT EXISTS (
    SELECT 1 FROM services WHERE service_name = 'Cushioned Chair'
);

INSERT INTO services (service_name, service_type, price)
SELECT 'Premium Decoration', 'DECORATION', 15000
WHERE NOT EXISTS (
    SELECT 1 FROM services WHERE service_name = 'Premium Decoration'
);

INSERT INTO services (service_name, service_type, price)
SELECT 'Food - Veg', 'FOOD', 300
WHERE NOT EXISTS (
    SELECT 1 FROM services WHERE service_name = 'Food - Veg'
);

INSERT INTO services (service_name, service_type, price)
SELECT 'Food - Non-Veg', 'FOOD', 450
WHERE NOT EXISTS (
    SELECT 1 FROM services WHERE service_name = 'Food - Non-Veg'
);

INSERT INTO services (service_name, service_type, price)
SELECT 'Standard Room', 'ROOM', 1500
WHERE NOT EXISTS (
    SELECT 1 FROM services WHERE service_name = 'Standard Room'
);

INSERT INTO services (service_name, service_type, price)
SELECT 'Parking', 'PARKING', 2000
WHERE NOT EXISTS (
    SELECT 1 FROM services WHERE service_name = 'Parking'
);
