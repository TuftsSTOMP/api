DELIMITER $$


--
-- Procedure: Stomper_CheckIn
-- Parameters: team id, material name, quantity to return
--

DROP PROCEDURE IF EXISTS Stomper_CheckIn $$
CREATE PROCEDURE Stomper_CheckIn (team_id INT, mat_name VARCHAR(40), Q INT)

BEGIN

	IF (SELECT reusable FROM Material WHERE name = mat_name) = 1 THEN 
 		CALL Stomper_CheckIn_Reusable(team_id, mat_name, Q);
 	ELSE
 		CALL Stomper_CheckIn_NonReusable(team_id, mat_name, Q);
 	END IF;

END$$


--
-- Procedure: Stomper_CheckIn_Reusable
-- Parameters: team id, material name, quantity to return
--

DROP PROCEDURE IF EXISTS Stomper_CheckIn_Reusable $$
CREATE PROCEDURE Stomper_CheckIn_Reusable (team_id INT, mat_name VARCHAR(40), Q INT)

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
-- Procedure: Stomper_CheckIn_NonReusable
-- Parameters: team id, material name, quantity to return
--

DROP PROCEDURE IF EXISTS Stomper_CheckIn_NonReusable $$
CREATE PROCEDURE Stomper_CheckIn_NonReusable (team_id INT, mat_name VARCHAR(40), Q INT)

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
				UPDATE Material as m INNER JOIN Transaction as tr USING (mid)
						SET m.q_removed = 0
						WHERE tr.zid = _zid;
				SET Q = 0;
			ELSE
				CALL ReturnQto_Material_and_Transaction(ind_q, _zid);
				SET Q = Q - ind_q;
			END IF;
			
			DELETE from Transaction where zid = _zid;
 
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
-- Procedure: Guest_ReturnMaterial
-- Parameters: Material name, quantity to return from that material
--
DROP PROCEDURE IF EXISTS Guest_ReturnMaterial $$
CREATE PROCEDURE  Guest_ReturnMaterial (mat_name VARCHAR(40), remove_quantity INT)
BEGIN

	DECLARE _mid INT DEFAULT NULL;
	
	SELECT mid INTO _mid FROM Material WHERE name = mat_name;

	UPDATE Material SET 
		q_removed = GREATEST(0, q_removed - remove_quantity),
		q_avail = q_avail + remove_quantity
		WHERE mid = _mid;
END$$



--
-- Procedure: getTeamTransactionList
-- Parameters: Team id, transaction type

DROP PROCEDURE IF EXISTS getTeamTransactionList $$
CREATE PROCEDURE  getTeamTransactionList (tid INT, transaction_type VARCHAR(20))
BEGIN
		SELECT m.name, tr.quantity, tr.transaction_date, tr.action_date
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
		SELECT m.name, SUM(tr.quantity) AS quantity, tr.transaction_date, tr.action_date 
			FROM Transaction AS tr  
			INNER JOIN Material AS m 
			USING (mid) 
			WHERE tr.tid = tid
			AND tr.res_type = transaction_type 
			GROUP BY m.name;
END$$



--
-- Procedure: newTeacher
-- Parameters: first_name, last name, email, school

DROP PROCEDURE IF EXISTS newTeacher $$
CREATE PROCEDURE  newTeacher (first_name VARCHAR(30), last_name VARCHAR(30), email VARCHAR(50), school_name VARCHAR(30))
BEGIN
		INSERT INTO Teacher (f_name, l_name, email, sid) 
			VALUES 
		(first_name, last_name, email, (SELECT sid from School where name = school_name));
END$$


--
-- Procedure: newSchool
-- Parameters: first_name, last name, email, school

DROP PROCEDURE IF EXISTS newSchool $$
CREATE PROCEDURE  newSchool (
	name VARCHAR(30),
	address VARCHAR(50),
	city VARCHAR(20),
	zip INT,
	main_phone CHAR(11))
BEGIN
	INSERT INTO School (name, address, city, zip, main_phone) 
	VALUES 
		(name, address, city, zip, main_phone);
END$$


--
-- Procedure: newClass
-- Parameters: teacher email, time range, day of the week, grade

DROP PROCEDURE IF EXISTS newClass $$
CREATE PROCEDURE  newClass (
	teacher_email VARCHAR(50),
	time_range VARCHAR(30),
	weekday VARCHAR(30),
	grade INT)
BEGIN

	INSERT INTO Class (teid, time_start, time_end, weekday, grade) 
	VALUES 
		((SELECT teid from Teacher where email = teacher_email), 
			(SELECT SUBSTRING_INDEX(time_range, '-', 1)), 
			(SELECT SUBSTRING_INDEX(time_range, '-', -1)), 
			weekday, 
			grade);
END$$


--
-- Procedure: newStomper
-- Parameters: stomper info

DROP PROCEDURE IF EXISTS newStomper $$
CREATE PROCEDURE  newStomper (
	f_name VARCHAR(30),
	l_name VARCHAR(30),
	email VARCHAR(50),
	username VARCHAR(20),
	password VARCHAR(30),
	roleName VARCHAR(30))
BEGIN

	INSERT INTO Stomper (f_name, l_name, email, username, pwd, role_id)
	VALUES 
		(f_name, 
		l_name, 
		email, 
		username, 
		SHA1(password),
		(SELECT role_id from UserRole where role_name = roleName));
END$$



--
-- Procedure: newTeam
-- Parameters: team information

DROP PROCEDURE IF EXISTS newTeam $$
CREATE PROCEDURE newTeam (
	teacher_email VARCHAR(50),
	_weekday VARCHAR(30))
BEGIN

	INSERT INTO Team (cid)
		(SELECT cid
			FROM Class AS cl
			INNER JOIN Teacher AS t
			USING (teid)
			WHERE t.email = teacher_email
			AND weekday = _weekday);
END$$


--
-- Procedure: newStomperTeam
-- Parameters: stomp team pairing

DROP PROCEDURE IF EXISTS newStomperTeam $$
CREATE PROCEDURE newStomperTeam (
	first_name VARCHAR(30),
	last_name VARCHAR(30),
	teacher_email VARCHAR(50),
	_weekday VARCHAR(30))
BEGIN

	INSERT INTO Stomper_Team (tid, uid)
	VALUES
		((SELECT tid 
			FROM Team as team
			INNER JOIN Class as c
			USING (cid)
			INNER JOIN Teacher as t
			USING (teid)
			WHERE t.email = teacher_email
			AND c.weekday = _weekday),
		(SELECT uid from Stomper WHERE f_name = first_name AND l_name = last_name));
END$$




--
-- Procedure: newMaterial
-- Parameters: new material information

DROP PROCEDURE IF EXISTS newMaterial $$
CREATE PROCEDURE newMaterial (
	m_name VARCHAR(40), 
	m_quantity INT, 
	m_max_checkout_q INT, 
	m_low_q_thresh INT, 
	m_reusable TINYINT(1))
BEGIN

	INSERT INTO Material (name, q_avail, max_checkout_q, low_q_thresh, reusable) 
	VALUES 
		(m_name, m_quantity, m_max_checkout_q, m_low_q_thresh, m_reusable);
END$$

DELIMITER ; --reset delimiter

