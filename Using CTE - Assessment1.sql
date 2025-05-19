-- Find customers who have at least one funded savings plan and one funded investment plan
-- Output includes: owner ID, full name, number of savings accounts, number of investment plans, and total confirmed deposits

WITH funded_savings AS (
    SELECT owner_id, COUNT(*) AS savings_count, SUM(confirmed_amount) AS total_savings
    FROM savings_savingsaccount
    WHERE confirmed_amount > 0
    GROUP BY owner_id
),
funded_investments AS (
    SELECT owner_id, COUNT(*) AS investment_count
    FROM plans_plan
    WHERE is_a_fund = 1 AND amount > 0
    GROUP BY owner_id
)
SELECT
    u.id AS owner_id,
    CONCAT(u.first_name, ' ', u.last_name) AS full_name,
    fs.savings_count,
    fi.investment_count,
    fs.total_savings / 100 AS total_deposits
FROM users_customuser u
JOIN funded_savings fs ON u.id = fs.owner_id
JOIN funded_investments fi ON u.id = fi.owner_id
ORDER BY total_deposits DESC
LIMIT 1000;
