--  (Booking.com)

--  Hotel Booking Analysis using SQL (Booking.com)

-- Questions

-- Q1.What is the overall cancellation rate for hotel bookings?
-- subquery
SELECT 
    (SELECT COUNT(*) FROM bookings WHERE is_canceled = 1) AS canceled_bookings,
    COUNT(*) AS total_bookings,
    (SELECT COUNT(*) FROM bookings WHERE is_canceled = 1) / COUNT(*) * 100 AS cancellation_rate
FROM 
    bookings;

-- CASE WHEN STATEMENT
SELECT 
    SUM(CASE WHEN is_canceled = 1 THEN 1 ELSE 0 END) AS canceled_bookings,
    COUNT(*) AS total_bookings,
    (SUM(CASE WHEN is_canceled = 1 THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS cancellation_rate
FROM 
    bookings;


--Q02.Which countries are the top contributors to hotel bookings?
select country,count(booking_id) as Total_booking
from bookings
group by country
order by 2 desc
limit 5;

--Q03.What are the main market segments booking the hotels, such as leisure or corporate?
SELECT 
    market_segment,
    COUNT(booking_id) AS total_bookings
FROM 
    bookings

GROUP BY 
    market_segment
ORDER BY 
    total_bookings DESC;

--Q04.Is there a relationship between deposit type (e.g., non-refundable, refundable) and the likelihood of cancellation?

SELECT 
    deposit_type,
    COUNT(booking_id) AS total_bookings,
    SUM(CASE WHEN is_canceled = 1 THEN 1 ELSE 0 END) AS canceled_bookings,
    cast(SUM(CASE WHEN is_canceled = 1 THEN 1 ELSE 0 END) / COUNT(booking_id)as numeric (10,2)) * 100 AS cancellation_rate
FROM 
    bookings
GROUP BY 
    deposit_type;

--Q5.How long do guests typically stay in hotels on average?
SELECT 
    CAST(AVG(stays_in_weekand_nights) AS NUMERIC(10, 2)) AS average_stay
FROM 
    bookings;

-- Q6.What meal options (e.g., breakfast included, half-board) are most preferred by guests?
SELECT 
    meal,
    COUNT(*) AS meal_count
FROM 
    bookings
GROUP BY 
    meal
ORDER BY 
    meal_count DESC;

-- Q7.Do bookings made through agents exhibit different cancellation rates or booking durations compared to direct bookings?
SELECT 
    CASE 
        WHEN agent IS NULL THEN 'Direct'
        ELSE 'Agent'
    END AS booking_source,
    CAST(AVG(stays_in_weekand_nights)AS NUMERIC (10,2)) AS average_stay,
    CAST(AVG(CASE WHEN is_canceled = 1 THEN 1 ELSE 0 END) AS NUMERIC (10,2))AS cancellation_rate
FROM 
    bookings
GROUP BY 
    CASE 
        WHEN agent IS NULL THEN 'Direct'
        ELSE 'Agent'
    END;


-- Q8.How do prices vary across different hotels and room types? Are there any seasonal pricing trends?
SELECT 
    hotel,
    EXTRACT(MONTH FROM booking_date) AS booking_month,
    AVG(price) AS average_price
FROM 
    bookings
GROUP BY 
    hotel, EXTRACT(MONTH FROM booking_date)
ORDER BY 
    hotel, EXTRACT(MONTH FROM booking_date)DESC;

--Q9.What percentage of bookings require car parking spaces, and does this vary by hotel location or other factors?
SELECT 
    hotel,
    COUNT(*) AS total_bookings,
    SUM(required_car_parking_spaces) AS bookings_with_parking,
    (SUM(required_car_parking_spaces) * 100.0) / COUNT(*) AS percentage_with_parking
FROM 
    bookings
GROUP BY 
    hotel;

-- Q10.What are the main reservation statuses (e.g., confirmed, canceled, checked-in), and how do they change over time?

SELECT 
    reservation_status,
    DATE_TRUNC('month', booking_date) AS booking_month,
    COUNT(*) AS status_count
FROM 
    bookings
GROUP BY 
    reservation_status, DATE_TRUNC('month', booking_date)
ORDER BY 
    booking_month, reservation_status;

-- Q11.What is the distribution of guests based on the number of adults, children, and
--     stays on weekend nights?

SELECT 
    adults,
    children,
    stays_in_weekand_nights,
    COUNT(*) AS guest_count
FROM 
    bookings
GROUP BY 
    adults, children, stays_in_weekand_nights
ORDER BY 
    adults, children, stays_in_weekand_nights;

-- Q12.Which email domains are most commonly used for making hotel bookings?
-- WE HAVE EXTRACT ONLY DOMAIN PART we will use substring.  

SELECT * FROM bookings

SELECT 
    SUBSTRING(email FROM POSITION('@' IN email) + 1) AS email_domain,
    COUNT(*) AS booking_count
FROM 
    bookings
WHERE 
    email LIKE '%@%'
GROUP BY 
    email_domain
ORDER BY 
    booking_count DESC;

-- OTHER APPROACH 
SELECT 
    SPLIT_PART(email, '@', 2) AS email_domain,
    COUNT(*) AS booking_count
FROM 
    bookings
WHERE 
    POSITION('@' IN email) > 0
GROUP BY 
    email_domain
ORDER BY 
    booking_count DESC;
	
-- Q13.Are there any frequently occurring names in hotel bookings, and do they exhibit
--     any specific booking patterns?

SELECT 
    name,
    COUNT(*) AS booking_count
FROM 
    bookings
GROUP BY 
    name
ORDER BY 
    booking_count DESC;

-- Q14.Which market segments contribute the most revenue to the hotels?

SELECT market_segment,hotel,
       cast(sum(price)as numeric (10,2)) as Total_revenue
FROM bookings
group by 1,2
order by 3 desc;





-- Q15.How do booking patterns vary across different seasons or months of the year

SELECT * FROM bookings

SELECT 
    CASE 
        WHEN EXTRACT(MONTH FROM booking_date) IN (12, 1, 2) THEN 'Winter'
        WHEN EXTRACT(MONTH FROM booking_date) IN (3, 4, 5) THEN 'Spring'
        WHEN EXTRACT(MONTH FROM booking_date) IN (6, 7, 8) THEN 'Summer'
        WHEN EXTRACT(MONTH FROM booking_date) IN (9, 10, 11) THEN 'Fall'
    END AS season,
    COUNT(*) AS total_bookings,
    AVG(stays_in_weekand_nights + stays_in_weekand_nights) AS average_stay,
    AVG(CASE WHEN is_canceled = 1 THEN 1 ELSE 0 END) AS cancellation_rate
FROM 
    bookings
GROUP BY 
    season
ORDER BY 
    season;







	
	

