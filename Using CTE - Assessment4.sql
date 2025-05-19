-- Estimate Customer Lifetime Value (CLV) using account tenure and average profit per transaction
-- Formula: CLV = (total_transactions / tenure_months) * 12 * avg_profit_per_transaction
-- Assume: profit per transaction = 0.1% of amount

WITH customer_activity AS (
    SELECT
        u.id AS customer_id, -- Unique ID for each customer
        CONCAT(u.first_name, ' ', u.last_name) AS full_name, -- Full name of the customer
        u.date_joined, -- Date the customer joined
        TIMESTAMPDIFF(MONTH, u.date_joined, CURDATE()) AS tenure_months, -- Number of months since the customer joined
        COUNT(s.id) AS total_transactions, -- Total number of savings accounts (or transactions) for the customer
        AVG(s.confirmed_amount) AS avg_transaction_amount -- Average confirmed amount in savings accounts
    FROM users_customuser u
    LEFT JOIN savings_savingsaccount s 
        ON u.id = s.owner_id AND s.confirmed_amount > 0 -- Join savings accounts with positive confirmed amounts
    GROUP BY u.id, u.first_name, u.last_name, u.date_joined -- Group by customer details
)

SELECT
    customer_id, -- Customer's unique ID
    full_name, -- Customer's full name
    tenure_months, -- Number of months since joining
    total_transactions, -- Total number of transactions
    ROUND(
        (total_transactions / NULLIF(tenure_months, 0)) * 12 * (avg_transaction_amount * 0.001), 
        2
    ) AS estimated_clv -- Estimated Customer Lifetime Value (annualized transaction rate * average transaction amount * 0.001)
FROM customer_activity
ORDER BY estimated_clv DESC -- Sort by estimated CLV, highest first
LIMIT 1000; -- Limit results to top 1000 customers