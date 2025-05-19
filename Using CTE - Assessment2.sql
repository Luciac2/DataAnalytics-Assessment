-- Categorize customers by average monthly transaction frequency into High, Medium, and Low

SELECT
    frequency_category, -- The frequency category (High, Medium, Low)
    COUNT(owner_id) AS customer_count, -- Number of customers in each category
    ROUND(AVG(avg_transactions_per_month), 1) AS avg_transactions_per_month -- Average monthly transactions for the category
FROM (
    SELECT
        owner_id, -- Customer's unique ID
        AVG(transactions_per_month) AS avg_transactions_per_month, -- Average transactions per month for the customer
        CASE
            WHEN AVG(transactions_per_month) >= 10 THEN 'High Frequency' -- 10 or more transactions per month
            WHEN AVG(transactions_per_month) BETWEEN 3 AND 9 THEN 'Medium Frequency' -- 3 to 9 transactions per month
            ELSE 'Low Frequency' -- Less than 3 transactions per month
        END AS frequency_category -- Assign frequency category based on average
    FROM (
        -- Count number of transactions per customer per month
        SELECT
            s.owner_id, -- Customer's unique ID
            COUNT(*) AS transactions_per_month -- Number of transactions in a given month
        FROM savings_savingsaccount s
        WHERE s.confirmed_amount > 0 -- Only consider transactions with positive confirmed amount
        GROUP BY s.owner_id, DATE_FORMAT(s.transaction_date, '%Y-%m') -- Group by customer and month
    ) AS monthly_activity
    GROUP BY owner_id -- Group by customer to calculate their average monthly transactions
) AS categorized_customers
GROUP BY frequency_category -- Group by frequency category to get counts and averages
ORDER BY FIELD(frequency_category, 'High Frequency', 'Medium Frequency', 'Low Frequency'); -- Order categories as High, Medium, Low