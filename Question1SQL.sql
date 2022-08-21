SELECT DATE(order_time) AS order_date, order_type, COUNT(order_type) AS total_customer_per_order_type
FROM `bi-dwhdev-01.source.daily_order`
WHERE UPPER(order_status) = 'COMPLETED'
GROUP BY order_type, order_date
ORDER BY order_date DESC

SELECT order_date, order_cnt AS total_customer_per_order_type, SUBSTR(order_service, (STRPOS(order_service, '-') + 1), (LENGTH(order_service) - STRPOS(order_service, '-'))) AS order_type
FROM `bi-dwhdev-01.source.summary_order`
WHERE UPPER(order_status) = 'COMPLETED'
GROUP BY order_type, order_date, order_cnt
ORDER BY order_date DESC

SELECT * FROM `bi-dwhdev-01.source.summary_order`
WHERE UPPER(order_status) = 'COMPLETED'
AND order_cnt = 0

SELECT * FROM `bi-dwhdev-01.source.daily_order`
WHERE UPPER(order_status) = 'COMPLETED'

SELECT DISTINCT(SUBSTR(order_service, (STRPOS(order_service, '-') + 1), (LENGTH(order_service) - STRPOS(order_service, '-')))) AS order_type
FROM `bi-dwhdev-01.source.summary_order`

SELECT order_type, order_payment, COUNT(order_payment) AS no_of_payment
FROM `bi-dwhdev-01.source.daily_order`
GROUP BY order_type, order_payment

SELECT order_payment, COUNT(order_type)
FROM `bi-dwhdev-01.source.daily_order`
GROUP BY order_payment

SELECT order_payment, order_type, order_status, customer_no, DATE(order_time, 'Asia/Jakarta')
FROM `bi-dwhdev-01.source.daily_order`
WHERE UPPER(order_status) = 'COMPLETED'
AND customer_no = 9927

SELECT
  EXTRACT(DATETIME FROM order_time AT TIME ZONE 'Asia/Jakarta') AS order_date,
  [
    (STRUCT(order_type, COUNT(order_type) AS total_customer_per_order_type))
  ] AS detail,
  order_payment,
  customer_no
FROM
  `bi-dwhdev-01.source.daily_order`
WHERE UPPER(order_status) = 'COMPLETED'
GROUP BY order_date, order_type, order_payment, customer_no
ORDER BY order_date DESC;

SELECT
  EXTRACT(DATETIME FROM order_time AT TIME ZONE 'Asia/Jakarta') AS order_date,
  ARRAY_AGG(order_type ORDER BY order_type) AS order_type,
  order_payment,
  customer_no
FROM
  `bi-dwhdev-01.source.daily_order`
WHERE UPPER(order_status) = 'COMPLETED'
GROUP BY order_date, order_payment, customer_no
ORDER BY order_date DESC;

SELECT
  EXTRACT(DATE FROM order_time AT TIME ZONE 'Asia/Jakarta') AS order_date,
  COUNT(customer_no) AS total_customer,
  ARRAY_AGG(STRUCT(
    order_type,
    customer_no)
    ORDER BY order_type
  ) AS detail,
  order_payment
FROM `bi-dwhdev-01.source.daily_order`
WHERE UPPER(order_status) = 'COMPLETED'
GROUP BY order_date, order_payment 
ORDER BY order_date DESC

WITH
order_detail AS(
  SELECT
    EXTRACT(DATE FROM order_time AT TIME ZONE 'Asia/Jakarta') AS order_date,
    ARRAY_AGG(STRUCT(
      order_type,
      customer_no)
      ORDER BY order_type
    ) AS detail,
    order_payment
  FROM `bi-dwhdev-01.source.daily_order`
  WHERE UPPER(order_status) = 'COMPLETED'
  GROUP BY order_date, order_payment 
  ORDER BY order_date DESC
)
SELECT
  order_date,
  order_type,
  COUNT(DISTINCT det.customer_no) AS total_customer_per_order_type
  FROM order_detail, UNNEST(detail) det
GROUP BY order_date, order_type
ORDER BY order_date DESC

SELECT order_date,
  ARRAY_AGG(detail ORDER BY detail.order_type) AS order_detail
FROM (
  SELECT EXTRACT(DATE FROM order_time AT TIME ZONE 'Asia/Jakarta') AS order_date,
    STRUCT(order_type, customer_no, order_payment) detail
  FROM `bi-dwhdev-01.source.daily_order`
  GROUP BY order_date, detail.order_type, detail.customer_no, detail.order_payment
  ORDER BY order_date
)
GROUP BY order_date

SELECT EXTRACT(DATE FROM order_time AT TIME ZONE 'Asia/Jakarta') AS order_date,
  STRUCT(order_type, customer_no) AS detail,
  order_payment
FROM `bi-dwhdev-01.source.daily_order`
WHERE UPPER(order_status) = 'COMPLETED'
GROUP BY order_date, order_type, order_payment, customer_no
ORDER BY order_date DESC

SELECT detail.order_type,
  ARRAY_AGG(COUNT(detail.customer_no)) AS customer_no
FROM (
  SELECT STRUCT(order_type, customer_no) AS customer_no) AS detail
  FROM `bi-dwhdev-01.source.daily_order`
  GROUP BY order_type, customer_no
  ORDER BY order_type DESC
)
GROUP BY detail.order_type

--TRIAL AND ERROR LINES END HERE-----------------------------------------------------------------------
--TRIAL AND ERROR LINES END HERE-----------------------------------------------------------------------
--TRIAL AND ERROR LINES END HERE-----------------------------------------------------------------------
--TRIAL AND ERROR LINES END HERE-----------------------------------------------------------------------
--TRIAL AND ERROR LINES END HERE-----------------------------------------------------------------------
--TRIAL AND ERROR LINES END HERE-----------------------------------------------------------------------
--TRIAL AND ERROR LINES END HERE-----------------------------------------------------------------------
--TRIAL AND ERROR LINES END HERE-----------------------------------------------------------------------
--TRIAL AND ERROR LINES END HERE-----------------------------------------------------------------------

CREATE OR REPLACE TABLE `bi-dwhdev-01.ab_dwh.daily_order` AS(
  SELECT
  customer_no,
  order_status,
  [
    STRUCT(order_payment, order_type, EXTRACT(DATE FROM order_time AT TIME ZONE 'Asia/Jakarta') AS order_date)
  ] AS detail,
FROM `bi-dwhdev-01.source.daily_order`
WHERE UPPER(order_status) = 'COMPLETED'
GROUP BY customer_no, order_payment, order_type, order_time, order_status
ORDER BY customer_no ASC, order_payment, order_type, order_time DESC, order_status
);