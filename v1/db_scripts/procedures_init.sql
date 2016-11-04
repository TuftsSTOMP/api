DELIMITER $$


--
-- Procedure: Stomper_CheckIn
-- Parameters: team id, material name, quantity to return
--

DROP PROCEDURE IF EXISTS Stomper_CheckIn $$
CREATE PROCEDURE Stomper_CheckIn (team_id INT, mat_name VARCHAR(40), Q INT)

BEGIN
	DECLARE finished INTEGER DEFAULT 0;
    DECLARE _zid INT;
    DECLARE ind_q INT;
	DEClARE transaction_cursor CURSOR FOR 
		SELECT tr.zid FROM Transaction AS tr INNER JOIN Material AS m USING (mid) 
		WHERE tr.tid = team_id AND tr.res_type = "remove" AND m.name = mat_name;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;
	
	open transaction_cursor;
		get_transaction: LOOP
 
 			FETCH transaction_cursor INTO _zid;
 
 			IF finished = 1 THEN 
 				LEAVE get_transaction;
 			END IF;
			
			SET ind_q = (SELECT quantity FROM Transaction WHERE zid = _zid);
			IF (Q<ind_q) THEN
				CALL ReturnQto_Material_and_Transaction(Q, _zid);
				LEAVE get_transaction;
			ELSE
				CALL ReturnQto_Material_and_Transaction(ind_q, _zid);
				SET Q = Q - ind_q;
				DELETE from Transaction where zid = _zid;
			END IF;
 
 		END LOOP get_transaction;
 	CLOSE transaction_cursor;

END$$


--
-- Procedure: ReturnQto_Material_and_Transaction
-- Parameters: Quantity to return, unique id of transaction
--
DROP PROCEDURE IF EXISTS ReturnQto_Material_and_Transaction $$
CREATE PROCEDURE  ReturnQto_Material_and_Transaction (return_quantity INT, _zid INT)
BEGIN
	
	UPDATE Transaction 
		SET quantity = quantity - return_quantity 
		WHERE zid = _zid;
	UPDATE Material as m INNER JOIN Transaction as tr USING (mid)
		SET m.q_removed = m.q_removed - return_quantity, m.q_avail = m.q_avail + return_quantity
		WHERE tr.zid = _zid;

END$$


--
-- Procedure: Validate_RemoveQfromMaterial
-- Parameters: Material name, quantity to remove from that material
--
DROP PROCEDURE IF EXISTS Validate_RemoveQfromMaterial $$
CREATE PROCEDURE  Validate_RemoveQfromMaterial (mat_name VARCHAR(40), remove_quantity INT)
BEGIN
	DECLARE _max INT;
	DECLARE _avail INT;
	DECLARE _mid INT DEFAULT NULL;
	
	SELECT mid, q_avail, max_checkout_q INTO _mid, _avail, _max FROM Material WHERE name = mat_name;
	
	IF (remove_quantity > _max) or (remove_quantity > _avail) THEN
		SET _mid = null;
	END IF;
	
	SELECT _mid;
END$$




--
-- Procedure: getTeamTransactionList
-- Parameters: Team id, transaction type

DROP PROCEDURE IF EXISTS getTeamTransactionList $$
CREATE PROCEDURE  getTeamTransactionList (tid INT, transaction_type VARCHAR(20))
BEGIN
		SELECT m.name, m.max_checkout_q, tr.quantity, tr.transaction_date, tr.action_date
			FROM Transaction AS tr 
			INNER JOIN Material AS m 
			USING (mid) 
			WHERE tr.tid = tid 
			AND tr.res_type = transaction_type;
END$$


--
-- Procedure: getTeamTransactionTotal
-- Parameters: Team id, transaction type

DROP PROCEDURE IF EXISTS getTeamTransactionTotal $$
CREATE PROCEDURE  getTeamTransactionTotal (tid INT, transaction_type VARCHAR(20))
BEGIN
		SELECT m.name, m.max_checkout_q, SUM(tr.quantity) AS quantity, tr.transaction_date, tr.action_date 
			FROM Transaction AS tr  
			INNER JOIN Material AS m 
			USING (mid) 
			WHERE tr.tid = tid
			AND tr.res_type = transaction_type 
			GROUP BY m.name;
END$$



DELIMITER ; --reset delimiter

