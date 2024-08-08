-- Table to store users' information
CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,
    phone_number VARCHAR(15) UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table to store cars available for booking
CREATE TABLE Cars (
    car_id INT PRIMARY KEY AUTO_INCREMENT,
    model VARCHAR(100) NOT NULL,
    brand VARCHAR(100) NOT NULL,
    year INT NOT NULL,
    seats INT NOT NULL,
    price_per_day DECIMAL(10, 2) NOT NULL,
    available BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table to store booking information
CREATE TABLE Bookings (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    car_id INT,
    booking_start_date DATE NOT NULL,
    booking_end_date DATE NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    status VARCHAR(50) DEFAULT 'Pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (car_id) REFERENCES Cars(car_id)
);

-- Table to store payment information
CREATE TABLE Payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    booking_id INT,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    amount_paid DECIMAL(10, 2) NOT NULL,
    payment_method VARCHAR(50) NOT NULL,
    payment_status VARCHAR(50) DEFAULT 'Completed',
    FOREIGN KEY (booking_id) REFERENCES Bookings(booking_id)
);

-- Indexes to speed up queries
CREATE INDEX idx_user_id ON Bookings(user_id);
CREATE INDEX idx_car_id ON Bookings(car_id);
CREATE INDEX idx_booking_id ON Payments(booking_id);

//CRUD  operation



//Create (Insert) Operation



INSERT INTO Cars (model, brand, year, seats, price_per_day, available)
VALUES ('Tesla Model 3', 'Tesla', 2023, 5, 150.00, TRUE);



//read

SELECT * FROM Cars;


//update

UPDATE Cars
SET price_per_day = 120.00, available = FALSE
WHERE car_id = 1;


//delete

DELETE FROM Cars WHERE car_id = 1;



//store procedure

// store procedure for updating a car

DELIMITER $$

CREATE PROCEDURE AddCar (
    IN p_model VARCHAR(100),
    IN p_brand VARCHAR(100),
    IN p_year INT,
    IN p_seats INT,
    IN p_price_per_day DECIMAL(10, 2),
    IN p_available BOOLEAN
)
BEGIN
    INSERT INTO Cars (model, brand, year, seats, price_per_day, available)
    VALUES (p_model, p_brand, p_year, p_seats, p_price_per_day, p_available);
END $$

DELIMITER ;


CALL AddCar('Tesla Model 3', 'Tesla', 2023, 5, 150.00, TRUE);




//store procedure for update

DELIMITER $$

CREATE PROCEDURE UpdateCar (
    IN p_car_id INT,
    IN p_price_per_day DECIMAL(10, 2),
    IN p_available BOOLEAN
)
BEGIN
    UPDATE Cars
    SET price_per_day = p_price_per_day, available = p_available
    WHERE car_id = p_car_id;
END $$

DELIMITER ;



CALL UpdateCar(1, 120.00, FALSE);



//store procedure for deletion



DELIMITER $$

CREATE PROCEDURE DeleteCar (
    IN p_car_id INT
)
BEGIN
    DELETE FROM Cars WHERE car_id = p_car_id;
END $$

DELIMITER ;


CALL DeleteCar(1);





















