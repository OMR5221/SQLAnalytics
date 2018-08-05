CREATE OR REPLACE PROCEDURE check_account (
	account_id_in IN accounts.id%TYPE)
-- Uses IS/AS rather than DECLARE
IS
	-- Declaration space of the procedure:
	l_balance_remaining NUMBER;
	l_balance_below_min EXCEPTION;
	l_account_name accounts.name%TYPE
	v_min_balance NUMBER := 500
	
BEGIN

	SELECT name INTO l_account_name
	FROM accounts
	WHERE id = account_id_in
	;
	
	l_balance_remaining := account_balance(account_id_in);
	
	DBMS_OUTPUT.PUT_LINE('Balance for ' || l_account_name || ' = ' l_balance_remaining);
	
	IF l_balance_remaining < v_min_balance THEN
		RAISE l_balance_below_min;
	END IF;
	
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		-- No account for for the id:
		log_error(...);
		RAISE;
	WHEN l_balance_below_min THEN
		log_error(...);
		RAISE VALUE_ERROR;
END;

