CREATE OR REPLACE TRIGGER job_insertion
AFTER
	INSERT
	ON jobPostings
	FOR EACH ROW
DECLARE
	CURSOR s1 IS
		SELECT empAcc.accID, skillA, skillB, skillC, skillD, skillE
		FROM empAcc INNER JOIN empSkills
		ON empAcc.accID = empSkills.accID;
	jobSA jobPostings.skillA%type;
	jobSB jobPostings.skillB%type;
	jobSC jobPostings.skillC%type;
	jobSD jobPostings.skillD%type;
	jobSE jobPostings.skillE%type;
	match number := 0;
BEGIN
	jobSA := :NEW.skillA;
	jobSB := :NEW.skillB;
	jobSC := :NEW.skillC;
	jobSD := :NEW.skillD;
	jobSE := :NEW.skillE;
	
	FOR r IN s1
	LOOP
		IF (r.skillA = jobSA or
			r.skillA = jobSB or
			r.skillA = jobSC or
			r.skillA = jobSD or
			r.skillA = jobSE) THEN
				match := match + 1;
		END IF;
		IF (r.skillB = jobSA or
			r.skillB = jobSB or
			r.skillB = jobSC or
			r.skillB = jobSD or
			r.skillB = jobSE) THEN
				match := match + 1;
		END IF;
		IF (r.skillC = jobSA or
			r.skillC = jobSB or
			r.skillC = jobSC or
			r.skillC = jobSD or
			r.skillC = jobSE) THEN
				match := match + 1;
		END IF;
		IF (r.skillD = jobSA or
			r.skillD = jobSB or
			r.skillD = jobSC or
			r.skillD = jobSD or
			r.skillD = jobSE) THEN
				match := match + 1;
		END IF;
		IF (r.skillE = jobSA or
			r.skillE = jobSB or
			r.skillE = jobSC or
			r.skillE = jobSD or
			r.skillE = jobSE) THEN
				match := match + 1;
		END IF;
		INSERT INTO jobMatch VALUES (r.accID, :NEW.jobID, match);
		match := 0;
	END LOOP;
	
	dbms_output.put_line('Matching complete. check table');
END; 
/

CREATE OR REPLACE TRIGGER job_deletion
BEFORE
	DELETE
	ON jobPostings
	FOR EACH ROW
BEGIN
	DELETE
	FROM applicants
	WHERE jobID = :OLD.jobID;
	
	DELETE
	FROM jobMatch
	WHERE jobID = :OLD.jobID;
	
	dbms_output.put_line('job posting deleted. associations removed');
END; 
/

CREATE OR REPLACE TRIGGER skill_edit
BEFORE
	UPDATE
	ON empSkills
	FOR EACH ROW
DECLARE
	CURSOR jl IS
		SELECT jobMatch.jobID, skillA, skillB, skillC, skillD, skillE
		FROM jobMatch INNER JOIN jobPostings
		ON jobMatch.jobid = jobpostings.jobid
        where jobmatch.accid = :NEW.accID;
	empSA empSkills.skillA%type;
	empSB empSkills.skillB%type;
	empSC empSkills.skillC%type;
	empSD empSkills.skillD%type;
	empSE empSkills.skillE%type;
	m number := 0;
BEGIN
	empSA := :NEW.skillA;
	empSB := :NEW.skillB;
	empSC := :NEW.skillC;
	empSD := :NEW.skillD;
	empSE := :NEW.skillE;
	
	FOR r IN jl
	LOOP
		IF (r.skillA = empSA or
			r.skillA = empSB or
			r.skillA = empSC or
			r.skillA = empSD or
			r.skillA = empSE) THEN
				m := m + 1;
		END IF;
		IF (r.skillB = empSA or
			r.skillB = empSB or
			r.skillB = empSC or
			r.skillB = empSD or
			r.skillB = empSE) THEN
				m := m + 1;
		END IF;
		IF (r.skillC = empSA or
			r.skillC = empSB or
			r.skillC = empSC or
			r.skillC = empSD or
			r.skillC = empSE) THEN
				m := m + 1;
		END IF;
		IF (r.skillD = empSA or
			r.skillD = empSB or
			r.skillD = empSC or
			r.skillD = empSD or
			r.skillD = empSE) THEN
				m := m + 1;
		END IF;
		IF (r.skillE = empSA or
			r.skillE = empSB or
			r.skillE = empSC or
			r.skillE = empSD or
			r.skillE = empSE) THEN
				m := m + 1;
		END IF;
		UPDATE jobMatch
		SET jobMatch.match = m
		WHERE jobID = r.jobID AND accID = :OLD.accID;
		m := 0;
	END LOOP;
	
	dbms_output.put_line('skills edited. Matching complete.');
END; 
/

CREATE OR REPLACE TRIGGER new_account_applicant
After
	INSERT
	ON applicants
	FOR EACH ROW
DECLARE
	r_count number;
	
	jobSA jobPostings.skillA%type;
	jobSB jobPostings.skillB%type;
	jobSC jobPostings.skillC%type;
	jobSD jobPostings.skillD%type;
	jobSE jobPostings.skillE%type;
	
	empSA empSkills.skillA%type;
	empSB empSkills.skillB%type;
	empSC empSkills.skillC%type;
	empSD empSkills.skillD%type;
	empSE empSkills.skillE%type;
	
	match number := 0;
BEGIN
	SELECT COUNT(*) 
	INTO r_count
	FROM jobMatch
	WHERE accID = :NEW.accID;
	
	SELECT skillA, skillB, skillC, skillD, skillE
	INTO jobSA, jobSB, jobSC, jobSD, jobSE
	FROM jobPostings
	WHERE jobID = :NEW.jobID;
	
	SELECT skillA, skillB, skillC, skillD, skillE
	INTO empSA, empSB, empSC, empSD, empSE
	FROM empSkills
	WHERE accID = :NEW.accID;
	
	IF r_count = 0 THEN
		IF (empSA = jobSA or
			empSA = jobSB or
			empSA = jobSC or
			empSA = jobSD or
			empSA = jobSE) THEN
				match := match + 1;
		END IF;
		IF (empSB = jobSA or
			empSB = jobSB or
			empSB = jobSC or
			empSB = jobSD or
			empSB = jobSE) THEN
				match := match + 1;
		END IF;
		IF (empSC = jobSA or
			empSC = jobSB or
			empSC = jobSC or
			empSC = jobSD or
			empSC = jobSE) THEN
				match := match + 1;
		END IF;
		IF (empSD = jobSA or
			empSD = jobSB or
			empSD = jobSC or
			empSD = jobSD or
			empSD = jobSE) THEN
				match := match + 1;
		END IF;
		IF (empSE = jobSA or
			empSE = jobSB or
			empSE = jobSC or
			empSE = jobSD or
			empSE = jobSE) THEN
				match := match + 1;
		END IF;
		INSERT INTO jobMatch VALUES (:New.accID, :NEW.jobID, match);
	end if;
	
	dbms_output.put_line('new applicant added');
END; 
/