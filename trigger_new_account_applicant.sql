DELIMITER $$
CREATE OR REPLACE TRIGGER new_account_applicant
After
	INSERT
	ON applicants
	FOR EACH ROW
BEGIN
	DECLARE r_count int(1);
	
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
	
	SELECT COUNT(*) 
	INTO r_count
	FROM jobMatch
	WHERE accID = NEW.accID;
	
	SELECT skillA, skillB, skillC, skillD, skillE
	INTO jobSA, jobSB, jobSC, jobSD, jobSE
	FROM jobPostings
	WHERE jobID = NEW.jobID;
	
	SELECT skillA, skillB, skillC, skillD, skillE
	INTO empSA, empSB, empSC, empSD, empSE
	FROM empSkills
	WHERE accID = NEW.accID;
	
	SET m := 0;
	
	IF (r_count = 0) THEN
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
		INSERT INTO jobMatch VALUES (New.accID, NEW.jobID, m);
	END IF;
END$$
DELIMITER ;