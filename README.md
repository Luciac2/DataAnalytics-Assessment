# DataAnalytics-Assessment

---

## ✅ Assessment Breakdown

### 🔹 `Assessment_Q1.sql`
**Objective:**  
Identify the top 1,000 customers who have both savings and investment plans, with the highest total confirmed deposits.

**Logic:**  
- Join `users_customuser`, `savings_savingsaccount`, and `plans_plan`
- Filter for customers with both confirmed savings and funded investment plans
- Calculate total deposits and return the top 1,000 customers

---

### 🔹 `Assessment_Q2.sql`
**Objective:**  
Classify customers based on average monthly transaction frequency into High, Medium, or Low frequency users.

**Logic:**  
- Count monthly transactions per customer
- Use `CASE` to categorize based on frequency thresholds
- Group results to summarize total customers in each category

---

### 🔹 `Assessment_Q3.sql`
**Objective:**  
Identify savings accounts that have been inactive for over a year.

**Logic:**  
- Find the most recent transaction date per account
- Calculate days since last transaction
- Filter for accounts with over 365 days of inactivity

---

### 🔹 `Assessment_Q4.sql`
**Objective:**  
Estimate the Customer Lifetime Value (CLV) for each user.

**Logic:**  
- Calculate transaction frequency per month
- Estimate average profit per transaction
- Multiply by tenure to estimate CLV
- Sort by highest estimated CLV

---

## 🛠️ Tools Used

- SQL (MySQL syntax)
- Text Editor (notepad)
- Git & GitHub for version control

---

## 📬 Submission

All files are committed and pushed to this public repository according to the instructions.  
The repository link will be submitted via the email-provided link.

---

## 👤 Author

**Lucia Onyedikachi**  
_Data Analyst Trainee & SQL Enthusiast_

---
