
-- we will use zenith bank for all our queries but the query should be repeated for all the other companies

-- What are the top 10 transactions by amount for each company? 
SELECT amount as "transaction amount", transaction_id
FROM  Zenith_Bank_Ghana_Limited_data
ORDER BY Amount DESC
LIMIT 10;

-- What is the average transaction amount for each company?
SELECT  AVG(Amount)
FROM  Zenith_Bank_Ghana_Limited_data;


-- How many transactions were made through each communication method for each company?
SELECT  Communication_Method, COUNT(*)
FROM Zenith_Bank_Ghana_Limited_data
GROUP BY  Communication_Method;

-- What is the total transaction amount for each month for each company?
SELECT  EXTRACT(MONTH FROM timestamp) AS Month, SUM(Amount)
FROM Zenith_Bank_Ghana_Limited_data
GROUP BY  EXTRACT(MONTH FROM timestamp)
ORDER BY Month;

-- What are the top 5 customers by total transaction amount for each company?
SELECT  name, SUM(amount) AS Total_Amount
FROM Zenith_Bank_Ghana_Limited_data
GROUP BY name
ORDER BY Total_Amount DESC
LIMIT 5;

-- Which app preference is most popular for each company?
SELECT app_Preference, COUNT(*)
FROM Zenith_Bank_Ghana_Limited_data
GROUP BY  app_Preference
ORDER BY COUNT(*) DESC
LIMIT 1;

-- How many unique customers made transactions for each company?
SELECT  COUNT(DISTINCT name) AS Unique_Customers
FROM Zenith_Bank_Ghana_Limited_data;

-- What is the total transaction amount for each communication method for each company?
SELECT communication_method, SUM(amount)
FROM Zenith_Bank_Ghana_Limited_data
GROUP BY  communication_method;

-- How many transactions occurred in each hour of the day for each company?
SELECT  EXTRACT(HOUR FROM timestamp) AS Hour, COUNT(*)
FROM Zenith_Bank_Ghana_Limited_data
GROUP BY EXTRACT(HOUR FROM timestamp)
ORDER BY Hour;


-- select the communication mode of 10 active customers
SELECT  name, communication_method, amount 
FROM Zenith_Bank_Ghana_Limited_data
WHERE amount  >= 1000
GROUP BY communication_method
ORDER BY amount DESC
LIMIT 10; 

-- select customers who transaction is between 3500 and 10000
SELECT name, communication_method
FROM  Zenith_Bank_Ghana_Limited_data
WHERE amount BETWEEN 3500 AND 10000







