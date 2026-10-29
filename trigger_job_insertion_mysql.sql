DELIMITER $$
CREATE OR REPLACE TRIGGER job_insertion
AFTER
	INSERT
	ON jobPostings
	FOR EACH ROW
BEGIN
	DECLARE aID int(10);
	DECLARE empSA varchar(50);
	DECLARE empSB varchar(50);
	DECLARE empSC varchar(50);
	DECLARE empSD varchar(50);
	DECLARE empSE varchar(50);
	
	DECLARE jobSA varchar(50);
	DECLARE jobSB varchar(50);
	DECLARE jobSC varchar(50);
	DECLARE jobSD varchar(50);
	DECLARE jobSE varchar(50);
	
	DECLARE m int(1);
	DECLARE finished INTEGER DEFAULT 0;
	
	DECLARE s1 CURSOR FOR
		SELECT empAcc.accID, skillA, skillB, skillC, skillD, skillE
		FROM empAcc
		INNER JOIN empSkills USING (accID);
	
	DECLARE CONTINUE HANDLER 
        FOR NOT FOUND SET finished = 1;	
	
	SET jobSA := NEW.skillA;
	SET jobSB := NEW.skillB;
	SET jobSC := NEW.skillC;
	SET jobSD := NEW.skillD;
	SET jobSE := NEW.skillE;
	SET m := 0;
	
	OPEN s1;
	
	matching: LOOP
		FETCH s1 INTO aID, empSA, empSB, empSC, empSD, empSE;
		IF finished = 1 THEN
			LEAVE matching;
		END IF;
		IF (empSA = jobSA or
			empSA = jobSB or
			empSA = jobSC or
			empSA = jobSD or
			empSA = jobSE) THEN
				SET m := m + 1;
		END IF;
		IF (empSB = jobSA or
			empSB = jobSB or
			empSB = jobSC or
			empSB = jobSD or
			empSB = jobSE) THEN
				SET m := m + 1;
		END IF;
		IF (empSC = jobSA or
			empSC = jobSB or
			empSC = jobSC or
			empSC = jobSD or
			empSC = jobSE) THEN
				SET m := m + 1;
		END IF;
		IF (empSD = jobSA or
			empSD = jobSB or
			empSD = jobSC or
			empSD = jobSD or
			empSD = jobSE) THEN
				SET m := m + 1;
		END IF;
		IF (empSE = jobSA or
			empSE = jobSB or
			empSE = jobSC or
			empSE = jobSD or
			empSE = jobSE) THEN
				SET m := m + 1;
		END IF;
		INSERT INTO jobMatch VALUES (aID, NEW.jobID, m);
		SET m := 0;
	END LOOP matching;
	
	CLOSE s1;
END$$
DELIMITER ;