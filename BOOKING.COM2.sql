-- Booking.com Data Analysis

-- 1.Retrieve all bookings made by customers from the United Kingdom (UK). 

select *
	from bookings
where  country = 'USA'


--2.Find the total number of canceled bookings. 


SELECT 
    COUNT(*) AS total_canceled_bookings
FROM 
    bookings
WHERE 
    is_canceled = 1;


-- 3.Calculate the average price of bookings made by adults only. 

SELECT * FROM BOOKINGS

SELECT ADULTS,
	   CAST(AVG(price) AS NUMERIC (10,2)) AS AVG_BOOKING_PRICE
FROM BOOKINGS
  WHERE PRICE IS NOT NULL
GROUP BY ADULTS
	ORDER BY AVG_BOOKING_PRICE DESC; 
