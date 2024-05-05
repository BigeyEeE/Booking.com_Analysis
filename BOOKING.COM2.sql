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



--4.List the top 5 countries with the highest number of bookings.
SELECT COUNT(BOOKING_ID) AS BOOKING_COUNTS,
       COUNTRY
FROM BOOKINGS
GROUP BY COUNTRY
ORDER BY COUNTRY DESC
LIMIT 5;



--5.Count the number of bookings made by each market segment.
SELECT * FROM BOOKINGS


SELECT MARKET_SEGMENT,
	   COUNT(*) AS BOOKING_COUNT
FROM BOOKINGS
GROUP BY MARKET_SEGMENT
ORDER BY 2 DESC;


--6.Determine the percentage of canceled bookings.

SELECT * FROM BOOKINGS

SELECT 
    COUNT(*) AS total_bookings,
    SUM(CASE WHEN CAST(IS_CANCELED AS boolean) THEN 1 ELSE 0 END) AS canceled_bookings,
    (SUM(CASE WHEN CAST(IS_CANCELED AS boolean) THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS percentage_canceled
FROM 
    BOOKINGS;


--7.Identify the market segment with the highest average booking price.

SELECT * FROM BOOKINGS

SELECT MARKET_SEGMENT, 
       CAST(AVG(PRICE) AS NUMERIC (10,2)) AS Highest_avg_booking_price
FROM BOOKINGS
GROUP BY 1
ORDER BY 2 DESC;


--8.Find the total number of bookings made for each hotel.
 
SELECT HOTEL,
	   COUNT(BOOKING_ID) AS TOTAL_BOOKINGS
	FROM BOOKINGS
GROUP BY HOTEL

--9.Calculate the average number of children per booking.

SELECT BOOKING_ID,
	   CAST(AVG(CHILDREN) AS NUMERIC (10,2))AS avg_child_booking
	FROM BOOKINGS
WHERE CHILDREN IS NOT NULL
GROUP BY BOOKING_ID
ORDER BY 2 DESC;


--10.List the countries where the majority of bookings are made for weekend stays.

WITH WeekendStayCounts AS (
    SELECT 
        COUNTRY,
        COUNT(*) AS weekand_stay_count,
        RANK() OVER (ORDER BY COUNT(*) DESC) AS country_rank
    FROM 
        BOOKINGS
    WHERE 
        STAYS_IN_WEEKAND_NIGHTS > 0
    GROUP BY 
        COUNTRY
)
SELECT 
    COUNTRY
FROM 
    WeekendStayCounts
WHERE 
    country_rank = 1;


--11.Retrieve the bookings made by customers who have provided an email address.

select booking_id,
	   NAME,
	   email   
	from bookings
where email is not null


--12.Find the total number of bookings made by agents with IDs above 100.

select count(booking_id) as TOTAL_BOOKINGS,
	agent
	from bookings
where agent > 100 
group by 2


--13.Calculate the average price of bookings made by customers who stayed for more than 3 weekend nights.

SELECT BOOKING_ID,
	   STAYS_IN_WEEKAND_NIGHTS,
	   AVG(PRICE) AS PRICE
	FROM BOOKINGS
WHERE STAYS_IN_WEEKAND_NIGHTS > 3 
	AND PRICE IS NOT NULL 
GROUP BY 1,2
ORDER BY 3 DESC;

--14.Identify the most common meal choice among bookings.
SELECT 
    MEAL,
    COUNT(*) AS frequency
FROM 
    BOOKINGS
GROUP BY 
    MEAL
ORDER BY 
    frequency DESC
LIMIT 1;

--15.List the bookings made by customers who reserved a parking space.

SELECT REQUIRED_CAR_PARKING_SPACES,
	   COUNT(*) AS TOTAL_BOOKING
	FROM BOOKINGS
	WHERE REQUIRED_CAR_PARKING_SPACES > 0
GROUP BY REQUIRED_CAR_PARKING_SPACES





--16.Determine the average price of bookings made by customers from each country.

SELECT 
    COUNTRY,
    AVG(PRICE) AS average_booking_price
FROM 
    BOOKINGS
	WHERE COUNTRY IS NOT NULL
GROUP BY 
    COUNTRY
	ORDER BY 2 DESC ;

--17.Find the total revenue generated from bookings made in the last month.
SELECT 
    BOOKING_ID,
	EXTRACT(MONTH FROM BOOKING_DATE) AS PREVIOUS_MONTH,
    SUM(PRICE) AS TOTAL_REVENUE
FROM 
    BOOKINGS
WHERE 
    EXTRACT(MONTH FROM BOOKING_DATE) = EXTRACT(MONTH FROM CURRENT_DATE) - 1 
	AND PRICE IS NOT NULL
GROUP BY 
    BOOKING_ID,2
ORDER BY 
    TOTAL_REVENUE DESC;
