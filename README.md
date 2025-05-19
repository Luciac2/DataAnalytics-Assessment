# DataAnalytics-Assessment

This repository contains my solutions for the SQL Proficiency Assessment, designed to evaluate skills in writing SQL queries to solve business problems using a relational database. The assessment includes four questions, each addressed in a separate SQL file: `Assessment_Q1.sql`, `Assessment_Q2.sql`, `Assessment_Q3.sql`, and `Assessment_Q4.sql`. This README provides explanations for my approach to each question and documents challenges encountered during the process.

## Repository Structure

DataAnalytics-Assessment/
├── Assessment_Q1.sql
├── Assessment_Q2.sql
├── Assessment_Q3.sql
├── Assessment_Q4.sql
└── README.md


## Per-Question Explanations

### Question 1: Find customers with funded savings and investment plans
**File**: `Assessment_Q1.sql`

**Objective**: Identify customers who have at least one funded savings account and one funded investment plan, returning their owner ID, full name, number of savings accounts, number of investment plans, and total confirmed deposits.

**Approach**:
- Used two Common Table Expressions (CTEs): `funded_savings` to aggregate savings accounts with positive `confirmed_amount` and `funded_investments` to aggregate investment plans with `is_a_fund = 1` and positive `amount`.
- Joined the CTEs with `users_customuser` to get customer details, ensuring only customers with both savings and investment plans are included.
- Divided `total_savings` by 100 to convert from kobo to naira (assumed based on typical currency handling).
- Ordered results by `total_deposits` descending and limited to 1000 rows for performance.

**Key Considerations**:
- Ensured accurate filtering of funded accounts using `confirmed_amount > 0` and `amount > 0`.
- Used `CONCAT` for full name to handle varying name formats.
- Optimized joins to avoid unnecessary rows.

### Question 2: Categorize customers by transaction frequency
**File**: `Assessment_Q2.sql`

**Objective**: Categorize customers into High, Medium, and Low frequency based on average monthly transaction frequency, returning the category, customer count, and average transactions per month.

**Approach**:
- Created a nested subquery to calculate transactions per customer per month, grouping by `owner_id` and transaction month (`DATE_FORMAT`).
- Calculated the average transactions per month per customer in an outer query.
- Used a `CASE` statement to assign categories: High (≥10 transactions), Medium (3–9 transactions), Low (<3 transactions).
- Grouped by `frequency_category` to compute customer counts and averages, ordering categories using `FIELD` for consistent presentation.

**Key Considerations**:
- Handled monthly grouping carefully to ensure accurate transaction counts.
- Rounded averages to one decimal place for readability.
- Used `FIELD` to enforce a logical order (High, Medium, Low) in the output.

### Question 3: Identify inactive savings accounts
**File**: `Assessment_Q3.sql`

**Objective**: Find savings accounts with no inflow transactions in the last year, returning plan ID, owner ID, account type, last transaction date, and inactivity days.

**Approach**:
- Created a CTE (`last_inflow`) to find the most recent transaction date for each savings account with positive `confirmed_amount`.
- Filtered accounts where the last transaction was over 365 days ago using `DATE_SUB`.
- Calculated inactivity days with `DATEDIFF`.
- Ordered by `inactivity_days` descending and limited to 1000 rows.

**Key Considerations**:
- Ensured only inflow transactions (`confirmed_amount > 0`) were considered.
- Used a static 'Savings' value for the `type` column as specified.
- Optimized the CTE to group by both `plan_id` and `owner_id` to handle multiple accounts per customer.

### Question 4: Estimate Customer Lifetime Value (CLV)
**File**: `Assessment_Q4.sql`

**Objective**: Estimate CLV using account tenure and average profit per transaction, assuming profit is 0.1% of the transaction amount.

**Approach**:
- Created a CTE (`customer_activity`) to compute customer tenure (`TIMESTAMPDIFF`), total transactions, and average transaction amount.
- Calculated CLV as `(total_transactions / tenure_months) * 12 * (avg_transaction_amount * 0.001)`, annualizing the transaction rate and applying the profit margin.
- Used `NULLIF` to avoid division by zero for new customers with zero tenure.
- Rounded CLV to two decimal places, ordered by CLV descending, and limited to 1000 rows.

**Key Considerations**:
- Handled edge cases like zero tenure with `NULLIF`.
- Ensured only positive `confirmed_amount` transactions were included.
- Assumed 0.1% profit per transaction as specified.

## Challenges and Resolutions
1. **Currency Conversion in Q1**:
   - **Challenge**: The requirement didn’t explicitly state the currency unit, but dividing by 100 suggested kobo-to-naira conversion.
   - **Resolution**: Applied the division and noted the assumption in comments for clarity.

2. **Monthly Grouping in Q2**:
   - **Challenge**: Accurately grouping transactions by month required careful date formatting.
   - **Resolution**: Used `DATE_FORMAT` with `%Y-%m` to ensure consistent monthly buckets.

3. **Inactivity Period in Q3**:
   - **Challenge**: Ensuring the 365-day inactivity filter was precise and performant.
   - **Resolution**: Used `DATE_SUB` and validated the logic to capture exactly one year.

4. **CLV Calculation in Q4**:
   - **Challenge**: Handling zero tenure for new customers could cause division errors.
   - **Resolution**: Implemented `NULLIF` to return NULL for invalid divisions, ensuring robust calculations.

## Notes
- All SQL queries are formatted with clear indentation and include comments for complex sections as required.
- The solutions aim for accuracy, efficiency, and readability, optimizing joins and aggregations where possible.
- The database schema was assumed based on the provided table descriptions, with standard naming conventions (e.g., `confirmed_amount`, `transaction_date`).

For any questions or further details, please contact me via the submission email.
