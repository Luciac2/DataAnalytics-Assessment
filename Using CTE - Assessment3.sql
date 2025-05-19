-- Identify savings accounts that have had no inflow transactions in the last 1 year

WITH last_inflow AS (
    SELECT
        s.plan_id, -- The plan ID for the savings account
        s.owner_id, -- The owner (customer) of the savings account
        MAX(s.transaction_date) AS last_transaction_date -- The most recent transaction date for each plan and owner
    FROM savings_savingsaccount s
    WHERE s.confirmed_amount > 0 -- Only consider transactions with a positive confirmed amount (inflows)
    GROUP BY s.plan_id, s.owner_id -- Group by plan and owner to get the last inflow per account
)
SELECT
    plan_id, -- The plan ID for the savings account
    owner_id, -- The owner (customer) of the savings account
    'Savings' AS type, -- Static value to indicate this is a savings account
    last_transaction_date, -- The date of the last inflow transaction
    DATEDIFF(CURDATE(), last_transaction_date) AS inactivity_days -- Number of days since the last inflow
FROM last_inflow
WHERE last_transaction_date < DATE_SUB(CURDATE(), INTERVAL 365 DAY) -- Only include accounts with no inflow in the last year
ORDER BY inactivity_days DESC -- Show accounts with the longest inactivity first
LIMIT 1000; -- Limit results to the top 1000 inactive accounts