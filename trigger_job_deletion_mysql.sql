DELIMITER $$
CREATE OR REPLACE TRIGGER job_deletion
BEFORE
	DELETE
	ON jobPostings
	FOR EACH ROW
BEGIN
	DELETE
	FROM applicants
	WHERE jobID = OLD.jobID;
	
	DELETE
	FROM jobMatch
	WHERE jobID = OLD.jobID;
END$$
DELIMITER ;