/* =============
   Task 1  
   ============= */

SELECT 
  title,
   context 
   INSTR()
 FROM staging.sql_squad
 WHERE regexp_matches(context, title); -- two arguments are string and substring  


 /* =============
   Task 2  
   ============= */


SELECT 
  title,
   context,
   INSTR(context, title) -- no match if there is no match
 FROM staging.sql_squad
 WHERE NOT regexp_matches(context, title); -- two arguments are string and substring




    /* =============
    Task 3  
    ============= */
    -- shows rows if contextstarting with file

    -- use LIKE operator with wildcard %

SELECT 
 *
FROM staging.sql_squad
WHERE context LIKE CONCAT(title, '%');  
-- check the results for Southern_California
-- the results are not ok due to the wildcard


-- if you use reqular expression function, underscore will be a literal character
SELECT 
* FROM staging.sql_squad
WHERE regexp_matches(context, CONCAT('^', title));


/* =============
   Task 4  
   ============= */

   -- show a new colimn which is the first answer from the AI model
   -- without pattern matching

   SELECT 
 answers[18:], -- slicing
 answers[19],  -- indexing
 CASE
   WHEN answers[18] = ',' THEN NULL
   ELSE answers[18:]
   END AS striped_answers,
   INSTR(striped_answers, '''') AS first_qutaion_index, -- a single qutation needs to be typed as ''
   striped_answers[:first_qutaion_index-1] AS first_answers,
   answers
   FROM staging.sql_squad;


    /* =============
    Task 5
    ============= */

    -- generate the same results from task 4 


    SELECT 
 
  -- don't allow single qutation inside ' and ',  
  regexp_extract(answers, '''([^'']+)'',') AS first_answer,   
  -- allows upper and lower case letters, digits, space, comma 
  regexp_extract(answers, '''([A-Za-z0-9 ,]+)'',') AS first_answer_1,
  -- use the gruping optional argument in regexp_extract function
  regexp_extract(answers, '''([A-Za-z0-9 ,]+)'',', 1) AS first_answer_2,
  answers 
FROM staging.sql_squad;