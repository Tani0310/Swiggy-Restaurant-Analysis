-- ============================================
-- Swiggy Restaurant Data Analysis
-- Tool: MySQL
-- Author: Taniya Jain
-- ============================================

CREATE DATABASE swiggy;
USE swiggy;

-- ============================================
-- BASIC QUERIES
-- ============================================

-- 1. Select all columns from the restaurant table
SELECT * FROM restaurant;

-- 2. Display the names and cities of all restaurants
SELECT name, city FROM restaurant;

-- 3. Find all restaurants located in Bangalore
SELECT name, city FROM restaurant
WHERE city = 'Bangalore';

-- 4. List the names and ratings of restaurants with a rating greater than 4.0
SELECT name, rating FROM restaurant
WHERE rating > 4.0;

-- 5. Find restaurants where the cost is less than or equal to 300
SELECT name, cost FROM restaurant
WHERE cost <= 300;

-- 6. Display all distinct cuisine types available in the dataset
SELECT DISTINCT cuisine FROM restaurant;

-- 7. Find all restaurants serving Biryani cuisine
SELECT name, cuisine FROM restaurant
WHERE cuisine = 'Biryani';

-- ============================================
-- SORTING & FILTERING
-- ============================================

-- 8. Show the top 5 restaurants with the highest ratings
SELECT name, rating
FROM restaurant
ORDER BY rating DESC
LIMIT 5;

-- 9. List restaurants with a rating count greater than 1000
SELECT name, rating_count FROM restaurant
WHERE rating_count > 1000;

-- 10. Count the total number of restaurants in the dataset
SELECT COUNT(*) AS num_rest FROM restaurant;

-- 11. Find the average cost of all restaurants
SELECT AVG(cost) FROM restaurant;

SELECT * FROM restaurant
WHERE cost > 297.6414;

-- 12. Display restaurant names and costs ordered by cost in ascending order
SELECT name, cost FROM restaurant
ORDER BY cost ASC;

-- ============================================
-- AGGREGATION & GROUPING
-- ============================================

-- 13. Find the average rating of restaurants for each city
SELECT city, AVG(rating) FROM restaurant
GROUP BY city;

-- 14. Count the number of restaurants available in each city
CREATE VIEW v1 AS
SELECT city, COUNT(name) FROM restaurant
GROUP BY city;

-- 15. Find the maximum and minimum cost of restaurants for each cuisine
SELECT cuisine, MAX(cost) AS max_cost, MIN(cost) AS min_cost
FROM restaurant
WHERE cost > 50
GROUP BY cuisine;

-- 16. List cuisines that have more than 10 restaurants
SELECT cuisine, COUNT(*) AS count_cuisines
FROM restaurant
GROUP BY cuisine
HAVING COUNT(*) > 10
ORDER BY count_cuisines ASC;

-- 17. Find the top 3 cities with the highest number of restaurants
SELECT city, COUNT(*) AS restaurant_count
FROM restaurant
GROUP BY city
ORDER BY restaurant_count DESC
LIMIT 3;

-- 18. Display the average cost of restaurants for each cuisine
SELECT cuisine, AVG(cost) FROM restaurant
GROUP BY cuisine;

-- 19. Find cities where the average restaurant rating is greater than 4.0
SELECT city, AVG(rating) FROM restaurant
GROUP BY city
HAVING AVG(rating) > 4.0;

-- 20. List restaurants whose cost is higher than the average cost of all restaurants
SELECT name, cost FROM restaurant
WHERE cost > (SELECT AVG(cost) FROM restaurant);

-- 21. Find the total number of ratings (rating_count) for each city
SELECT city, SUM(rating_count) AS total_ratings
FROM restaurant
GROUP BY city;

-- 22. Display cuisines ordered by their average rating in descending order
SELECT cuisine, AVG(rating) AS avg_rating
FROM restaurant
GROUP BY cuisine
ORDER BY avg_rating DESC;

-- ============================================
-- SUBQUERIES
-- ============================================

-- 23. Find restaurants that have the highest rating within their city
SELECT name, city, rating
FROM restaurant r1
WHERE rating = (
    SELECT MAX(rating)
    FROM restaurant r2
    WHERE r1.city = r2.city
);

-- 24. List cities that have more than one cuisine type available
SELECT city, COUNT(DISTINCT cuisine) AS cuisine_types
FROM restaurant
GROUP BY city
HAVING COUNT(DISTINCT cuisine) > 1;

-- 25. Find the restaurant(s) with the maximum rating_count in the dataset
SELECT name, rating_count
FROM restaurant
WHERE rating_count = (
    SELECT MAX(rating_count)
    FROM restaurant
);

-- ============================================
-- ADVANCED
-- ============================================

-- 26. Calculate restaurants having the highest number of franchises
SELECT name, COUNT(*) AS franchise_count
FROM restaurant
GROUP BY name
ORDER BY franchise_count DESC
LIMIT 5;
