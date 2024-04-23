--Temprary table for functions
WITH SplitStoreBike AS 
(
    SELECT
        REPLACE(split(w12021.store_bike, ' - ')[0], '"', '') AS store,
        LEFT(split(w12021.store_bike, ' - ')[1], 1) AS bike_type,
        w12021.date,
        w12021.customer_age,
        w12021.bike_value,
        w12021.existing_customer,
        w12021.order_id
    FROM
        PD2021_WK01 AS w12021
    WHERE
        w12021.order_id > 10
)

SELECT
    s.store,
    --Typo Correction
    CASE
        WHEN s.bike_type = 'R' THEN 'Road'
        WHEN s.bike_type = 'M' THEN 'Mountain'
        WHEN s.bike_type = 'G' THEN 'Gravel'
    END AS bike,
    QUARTER(s.date) AS quarter,
    DAYOFMONTH(s.date) AS "DAY_OF_MONTH",
    s.customer_age,
    s.bike_value,
    s.existing_customer
FROM
    SplitStoreBike AS s;
