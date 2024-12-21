/*
Mastering SQL Joins and Filtering in SAS Studio 🌟

This assignment demonstrates SQL queries in SAS Studio with a focus on:
- Joining tables with `PROC SQL`
- Handling ambiguous column names with qualifiers
- Filtering results using `WHERE` clauses
- Sorting results using `ORDER BY`
- Advanced SQL concepts for efficiency and clarity
*/

-- Firstly, Create your Library in SAS (the following path corresponds to my library)
libname sq '~/my_shared_file_links/u63724591/data tables';

-- Now, lets begin the Show!
-- Step 1a: Default Join 🤔
-- Concept: Avoiding Cartesian Products
-- When performing joins, ensure the ON condition is properly defined to avoid combining every row in one table with every row in another.
proc sql;
SELECT * 
FROM sq.smallcustomer
INNER JOIN sq.smalltransaction 
  ON smallcustomer.AccountID = smalltransaction.AccountID;
quit;

-- Step 1b: Problems with Default Join 🚩
/*
1. Ambiguity: If both tables have a column with the same name (like AccountID), it’s hard to differentiate them.
2. Too much data: Selecting `*` fetches all columns, including unnecessary ones, which can clutter the report.
*/

-- Step 2: A Cleaner Inner Join 🧹
-- Concept: Selecting Specific Columns
-- Fetching only the necessary columns reduces data transfer and improves performance.
proc sql;
SELECT FirstName, LastName, State, Income, DateTime, MerchantID, Amount 
FROM sq.smallcustomer
INNER JOIN sq.smalltransaction 
  ON smallcustomer.AccountID = smalltransaction.AccountID;
quit;

-- Step 3: Adding AccountID 🪪
-- Concept: Resolving Column Name Conflicts
-- Use table qualifiers when columns with the same name exist in both tables.
proc sql;
SELECT FirstName, LastName, State, Income, DateTime, MerchantID, Amount, AccountID 
FROM sq.smallcustomer
INNER JOIN sq.smalltransaction 
  ON smallcustomer.AccountID = smalltransaction.AccountID;
quit;

-- Step 4: Qualify AccountID to Avoid Confusion 🎯
-- Concept: Using Qualifiers for Clarity
-- Always qualify ambiguous column names with the table name to improve query readability and avoid errors.
proc sql;
SELECT FirstName, LastName, State, Income, DateTime, MerchantID, Amount, smallcustomer.AccountID 
FROM sq.smallcustomer
INNER JOIN sq.smalltransaction 
  ON smallcustomer.AccountID = smalltransaction.AccountID;
quit;

-- Step 5: Filtering for New York Customers 🗽
-- Concept: Sorting and Filtering Efficiency
-- Applying filters (WHERE) before sorting (ORDER BY) ensures optimal performance by reducing the dataset early.
proc sql;
SELECT FirstName, LastName, State, Income, DateTime, MerchantID, Amount, smallcustomer.AccountID 
FROM sq.smallcustomer
INNER JOIN sq.smalltransaction 
  ON smallcustomer.AccountID = smalltransaction.AccountID
WHERE State = 'NY'
ORDER BY Amount DESC;
quit;

-- Step 7: Joining State Data 🌍
-- Concept: Using Table Aliases for Readability
-- Table aliases simplify query writing, especially when dealing with long table names or multiple joins.
proc sql;
SELECT Name, StateName, PopEstimate1, PopEstimate2, PopEstimate3
FROM sq.statepopulation AS p 
INNER JOIN sq.statecode AS s
  ON p.Name = s.StateCode
ORDER BY StateName;
quit;

-- Additional Concept: Optimizing Joins with Indexes 📈
-- Ensure that join conditions involve indexed columns to speed up query execution, especially for large datasets.
