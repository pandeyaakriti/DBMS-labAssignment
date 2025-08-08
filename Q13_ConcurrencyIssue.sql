-- Session 1
START TRANSACTION;
UPDATE Bill SET amount = amount + 100 WHERE bill_id = 1;

-- Session 2 (before commit)
START TRANSACTION;
SELECT amount FROM Bill WHERE bill_id = 1;
