use hotel_reservation;

create table if not exists hotel_reservation_data
(
Booking_id varchar(20) PRIMARY KEY,
no_of_adults INT,
no_of_children INT,
no_of_weekend_nights INT,
no_of_week_nights INT,
type_of_meal_plan VARCHAR(50),
room_type_reserved VARCHAR(50),
lead_time INT,
arrival_date text,
market_segment_type varchar(20),
average_price_per_room DECIMAL,
booking_status varchar(20)
);


SELECT 
    *
FROM
    hotel_reservation_data;

desc hotel_reservation_data;

UPDATE hotel_reservation_data
SET arrival_date = STR_TO_DATE(arrival_date, '%d-%m-%Y')
WHERE STR_TO_DATE(arrival_date, '%d-%m-%Y') IS NOT NULL;

-- 1. What is the total number of reservations in the dataset?  
SELECT 
    COUNT(booking_id) AS number_of_reservations
FROM
    hotel_reservation_data;

-- 2. Which meal plan is the most popular among guests?  
SELECT 
    type_of_meal_plan,
    COUNT(booking_id) AS number_of_meal_bookings
FROM
    hotel_reservation_data
GROUP BY type_of_meal_plan
ORDER BY number_of_meal_bookings DESC
LIMIT 1;


-- 3. What is the average price per room for reservations involving children?  
SELECT 
    ROUND(AVG(average_price_per_room), 2) AS avg_price_per_room
FROM
    hotel_reservation_data
WHERE
    no_of_children > 0;

-- 4. How many reservations were made for the year 2018?  
SELECT 
    YEAR(arrival_date) AS year_of_arrival,
    COUNT(booking_id) AS number_of_bookings
FROM
    hotel_reservation_data
WHERE
    YEAR(arrival_date) = 2018
GROUP BY YEAR(arrival_date);

-- 5. What is the most commonly booked room type?  
SELECT 
    room_type_reserved, 
    COUNT(booking_id) AS number_of_bookings
FROM
    hotel_reservation_data
GROUP BY room_type_reserved
ORDER BY COUNT(booking_id) DESC
LIMIT 1;

-- 6. How many reservations fall on a weekend (no_of_weekend_nights > 0)?  
SELECT 
    COUNT(no_of_weekend_nights) as no_of_reservations_on_weekend
FROM
    hotel_reservation_data
WHERE
    no_of_weekend_nights > 0;

-- 7. What is the highest and lowest lead time for reservations?  
SELECT 
    MAX(lead_time) AS maximum_lead_time,
    MIN(lead_time) AS minimum_lead_time
FROM
    hotel_reservation_data;

-- 8. What is the most common market segment type for reservations?  
SELECT 
    market_segment_type, 
    COUNT(booking_id) as no_of_reservations
FROM
    hotel_reservation_data
GROUP BY market_segment_type
ORDER BY COUNT(booking_id) DESC
limit 1;

-- 9. How many reservations have a booking status of "Confirmed"?  
SELECT 
    COUNT(Booking_id) AS Confirmed_reservations
FROM
    hotel_reservation_data
WHERE
    booking_status = 'Not_canceled';

-- 10. What is the total number of adults and children across all reservations?  
SELECT 
    SUM(no_of_adults) as number_of_adults, 
    SUM(no_of_children) AS number_of_children,
    SUM(no_of_adults) + SUM(no_of_children) as total_members
FROM
    hotel_reservation_data;
    
-- 11. What is the average number of weekend nights for reservations involving children?  
SELECT 
    Round(AVG(no_of_weekend_nights))as no_of_weekend_nights_children
FROM
    hotel_reservation_data
WHERE
    no_of_children > 0;

-- 12. How many reservations were made in each month of the year? 
SELECT 
	EXTRACT(MONTH FROM arrival_date) as Month_no,
    DATE_FORMAT(arrival_date, '%M') AS Month_name,
    COUNT(booking_id) AS no_of_reservations
FROM hotel_reservation_data
GROUP BY month_name,Month_no
ORDER BY Month_no;


-- 13. What is the average number of nights (both weekend and weekday) spent by guests for each room type?  
SELECT 
    room_type_reserved AS room_type,
    ROUND(AVG(no_of_week_nights) + AVG(no_of_weekend_nights),2) AS avg_no_of_nights
FROM
    hotel_reservation_data
GROUP BY room_type_reserved
ORDER BY room_type;

-- 14. For reservations involving children, what is the most common room type, and what is the average price for that room type?  
SELECT 
    room_type_reserved as room_type,
    COUNT(Booking_id) AS no_of_reservations,
    Round(AVG(average_price_per_room),2) AS avg_price
FROM
    hotel_reservation_data
WHERE
    no_of_children > 0
GROUP BY room_type_reserved
ORDER BY no_of_reservations desc
limit 1;

-- 15. Find the market segment type that generates the highest average price per room.  
SELECT 
    market_segment_type, 
    ROUND(AVG(average_price_per_room),2) as avg_room_price 
FROM
    hotel_reservation_data
GROUP BY market_segment_type
ORDER BY avg_room_price desc
LIMIT 1;













