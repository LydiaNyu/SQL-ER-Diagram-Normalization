-- 1. this query tries to determine whether or not report id is unique	
SELECT report_id, count(*) FROM staging_caers_events
GROUP BY report_id
ORDER BY count(*) DESC LIMIT 5;

--  report_id | count 
-- -----------+-------
--  179852    |    44
--  174049    |    39
--  190041    |    35
--  210074    |    35
--  190166    |    30

-- 2. this query tries to determine whether or not combined report_id with product is unique
SELECT report_id, product, count(*) FROM staging_caers_events
GROUP BY report_id, product
ORDER BY count(*) DESC LIMIT 5;

--  report_id |   product   | count 
-- -----------+-------------+-------
--  213904    | EXEMPTION 4 |     3
--  194882    | EXEMPTION 4 |     3
--  178211    | EXEMPTION 4 |     3
--  191731    | EXEMPTION 4 |     3
--  216086    | EXEMPTION 4 |     3

-- 3. this query tries to determine whether or not combined report_id, product with product_type
-- is unique
SELECT report_id, product, product_type, count(*) FROM staging_caers_events
GROUP BY report_id, product, product_type
ORDER BY count(*) DESC LIMIT 5;

--  report_id |   product   | product_type | count 
-- -----------+-------------+--------------+-------
--  216086    | EXEMPTION 4 | CONCOMITANT  |     2
--  194882    | EXEMPTION 4 | CONCOMITANT  |     2
--  178211    | EXEMPTION 4 | CONCOMITANT  |     2
--  191731    | EXEMPTION 4 | CONCOMITANT  |     2
--  215288    | EXEMPTION 4 | SUSPECT      |     2

-- 4. this query tries to determine whether or not combined report_id, product, product_type,
-- product_code is unique
SELECT report_id, product, product_type, product_code, count(*) FROM staging_caers_events
GROUP BY report_id, product, product_type, product_code
ORDER BY count(*) DESC LIMIT 5;

--  report_id |                                        product                                        | product_type | product_code | count 
-- -----------+---------------------------------------------------------------------------------------+--------------+--------------+-------
--  183220    | ONE A DAY WOMENS VITACRAVES GUMMIES MULTIVITAMINS + MINERALS                          | SUSPECT      | 54           |     1
--  182667    | EXEMPTION 4                                                                           | SUSPECT      | 53           |     1
--  189122    | PRESERVISION AREDS PO                                                                 | CONCOMITANT  | 54           |     1
--  192097    | ONE A DAY WOMEN'S 50+ HEALTHY ADVANTAGE (MULTIVITAMINS + MINERALS) FILM-COATED TABLET | SUSPECT      | 54           |     1
--  185571    | VITAMIN C                                                                             | CONCOMITANT  | 54           |     1

-- 5. this query tries to determine whether or not description is functionally dependent on product_code
SELECT DISTINCT product_code, description FROM staging_caers_events
ORDER BY product_code desc nulls last;

--  product_code |                  description                  
-- --------------+-----------------------------------------------
--  9            |  Milk/Butter/Dried Milk Prod
--  9            | Milk/Butter/Dried Milk Prod
--  7            |  Snack Food Item
--  54           |  Vit/Min/Prot/Unconv Diet(Human/Animal)
--  53           |  Cosmetics
--  52           |  Miscellaneous Food Related Items
--  50           |  Color Additiv Food/Drug/Cosmetic
--  5            | Cereal Prep/Breakfast Food
--  5            |  Cereal Prep/Breakfast Food
--  46           |  Food Additives (Human Use)
--  45           |  Food Additives (Human Use)

-- 6. this query tries to determine whether or not caers_created_date is functionally dependent on date of event, or vice versa.
SELECT DISTINCT caers_created_date, date_of_event FROM staging_caers_events
ORDER BY date_of_event desc nulls last;

 -- caers_created_date | date_of_event 
--  2017-12-22         | 2017-12-17
--  2017-12-21         | 2017-12-16
--  2017-12-19         | 2017-12-16
--  2017-12-20         | 2017-12-14
--  2017-12-28         | 2017-12-14
--  2017-12-20         | 2017-12-13
--  2017-12-19         | 2017-12-12
--  2017-12-28         | 2017-12-12
--  2017-12-13         | 2017-12-12
--  2017-12-21         | 2017-12-11
--  2017-12-29         | 2017-12-11