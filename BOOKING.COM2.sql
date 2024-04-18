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
