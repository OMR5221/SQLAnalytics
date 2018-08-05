PROCEDURE pay_out_balance (
	account_id_in IN accounts.id%TYPE)
-- Uses IS/AS rather than DECLARE
IS
	-- Declaration space of the procedure:
	l_balance_remaining NUMBER;
BEGIN
	LOOP
	
		l_balance_remaining := account_balance(account_id_in);
		
		IF l_balance_remaining < 500 THEN
			DBMS_OUTPUT.PUT_LINE('LOW BALANCE: Stopping bill payments');
			EXIT;
		ELSE
			-- Run another external function
			apply_balance(account_id_in, l_balance_remaining);
		END IF;
	END LOOP;
END pay_out_balance;