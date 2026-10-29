DELIMITER $$
CREATE OR REPLACE TRIGGER skill_edit
BEFORE
	UPDATE
	ON empSkills
	FOR EACH ROW
BEGIN
	DECLARE jID int(10);
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

	DECLARE j1 CURSOR FOR
		SELECT jobMatch.jobID, skillA, skillB, skillC, skillD, skillE
		FROM jobMatch
		INNER JOIN jobPostings
		USING (jobid)
        where jobmatch.accid = NEW.accID;
	
	DECLARE CONTINUE HANDLER 
        FOR NOT FOUND SET finished = 1;	

	SET empSA := NEW.skillA;
	SET empSB := NEW.skillB;
	SET empSC := NEW.skillC;
	SET empSD := NEW.skillD;
	SET empSE := NEW.skillE;
	SET m := 0;
	
	OPEN j1;
	
	matches: LOOP
		FETCH j1 INTO jID, jobSA, jobSB, jobSC, jobSD, jobSE;
		IF finished = 1 THEN
			LEAVE matches;
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
		UPDATE jobMatch
		SET jobMatch.hit = m
		WHERE jobID = jID AND accID = OLD.accID;
		SET m := 0;
	END LOOP matches;
	
	CLOSE j1;
END$$
DELIMITER ;