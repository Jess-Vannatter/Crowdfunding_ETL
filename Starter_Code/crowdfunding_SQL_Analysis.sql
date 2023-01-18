SELECT * FROM campaign;

-- Challenge Bonus queries.
-- 1. (2.5 pts)
-- Retrieve all the number of backer_counts in descending order for each `cf_id` for the "live" campaigns. 
SELECT cf_id, backers_count
FROM campaign
WHERE outcome='live'
-- GROUP BY cf_id, backers_count, outcome
ORDER BY backers_count DESC;

-- checking count number of live campaigns
SELECT COUNT(outcome) FROM campaign WHERE outcome = 'live';




-- 2. (2.5 pts)
-- Using the "backers" table confirm the results in the first query.
SELECT cf_id, COUNT(backer_id) AS "Total Backers"
FROM backers
GROUP BY cf_id
ORDER BY "Total Backers" DESC;




-- 3. (5 pts)
-- Create a table that has the first and last name, and email address of each contact.
-- and the amount left to reach the goal for all "live" projects in descending order. 

SELECT Cn.first_name,
CN.last_name,
CN.email,
(CP.goal-CP.pledged) AS "Remaining Goal Amount"
INTO email_contacts_remaining_goal_amount
FROM contacts AS CN
JOIN campaign AS CP
ON CP.contact_id=CN.contact_id
WHERE CP.outcome = 'live'
ORDER BY "Remaining Goal Amount" DESC;

-- Check the table
SELECT * FROM email_contacts_remaining_goal_amount;


-- SELECT DISTINCT ON (cp.goal-cp.pledged) cn.first_name, 
-- cn.last_name, 
-- cn.email,
-- (cp.goal-cp.pledged) AS "Remaining Goal Amount"
-- --INTO email_contacts_remaining_goal_amount
-- FROM contacts AS cn
-- 	INNER JOIN campaign AS cp
-- 	ON (cn.contact_id=cp.contact_id)
-- 	INNER JOIN backers AS b
-- 	ON (cp.cf_id=b.cf_id)
-- ORDER BY "Remaining Goal Amount" DESC;

-- Check the table
SELECT * FROM email_contacts_remaining_goal_amount;




-- 4. (5 pts)
-- Create a table, "email_backers_remaining_goal_amount" that contains the email address of each backer in descending order, 
-- and has the first and last name of each backer, the cf_id, company name, description, 
-- end date of the campaign, and the remaining amount of the campaign goal as "Left of Goal". 

select sum("Remaining Goal Amount") FROM email_contacts_remaining_goal_amount;

SELECT * FROM campaign;

SELECT bk.email,
    bk.first_name, 
    bk.last_name, 
    bk.cf_id,
    cp.company_name,
    cp.description,
    cp.end_date,
    (cp.goal-cp.pledged) AS "Left of Goal"
INTO email_backers_remaining_goal_amount
FROM campaign AS cp
LEFT JOIN backers AS bk
ON (bk.cf_id=cp.cf_id)
WHERE cp.outcome = 'live'
GROUP BY bk.email,
       bk.first_name, 
       bk.last_name,
       bk.cf_id, 
       cp.company_name,
       cp.description,
       cp.end_date,
       "Left of Goal"
ORDER BY bk.last_name;

-- SELECT bk.email,
-- 	bk.first_name, 
-- 	bk.last_name, 
-- 	bk.cf_id,
-- 	cp.company_name,
-- 	cp.description,
-- 	cp.end_date,
-- 	(cp.goal-cp.pledged) AS "Left of Goal"
-- --INTO email_contacts_remaining_goal_amount
-- FROM backers AS bk
-- 	INNER JOIN campaign AS cp
-- 	ON (bk.cf_id=cp.cf_id)
-- 	WHERE cp.outcome = 'live'
-- -- 	INNER JOIN backers AS b
-- -- 	ON (cp.cf_id=b.cf_id)
-- ORDER BY "last_name", "email";


-- Check the table
SELECT * FROM email_contacts_remaining_goal_amount;