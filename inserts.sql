INSERT INTO EMPACC (email, password, fname, lname, phone, description)
VALUES ('bmage7@gmail.com', 'vgfdrtesf', 'black', 'mage', 1112223333, 'I do black magic');

INSERT INTO EMPSKILLS VALUES (1, 'fire', 'thunder', 'blizzard', 'petrify', 'ultima');

INSERT INTO EMPACC (email, password, fname, lname, phone, description)
VALUES ('wmage8@gmail.com', 'hjgtfrtesdf', 'white', 'mage', 1112223334, 'I do white magic');

INSERT INTO EMPSKILLS VALUES (2, 'cure', 'esuna', 'raise', 'haste', 'holy');

INSERT INTO EMPACC (email, password, fname, lname, phone, description)
VALUES ('rmage9@gmail.com', 'bvgfddfxcfg', 'red', 'mage', 1112223335, 'I do some white and black magic');

INSERT INTO EMPSKILLS VALUES (3, 'cure', 'esuna', 'fire', 'thunder', 'blizzard');

INSERT INTO COMPACC (username, password, compname, email, phone, address, description)
VALUES ('WoL_HR_Dep', 'jhgfdsrdfxcg', 'WoL_Inc', 'HR@WoL.org', 3334445555, '1111 FF Avenue 10203', 'we are looking to hire');

INSERT INTO COMPACC (username, password, compname, email, phone, address, description)
VALUES ('Panzer_HR', 'hgftrdtesdxcf', 'Panzer_Inc', 'pan@zer.org', 5556667777, '1111 AW Avenue 50607', 'we are looking to hire');

INSERT INTO JOBPOSTINGS (accID, skillA, skillB, skillC, skillD,  skillE, address, description)
VALUES (1, 'cure', 'esuna', 'raise', 'fire', 'blizzard', '1234 N Ivalice Ave', 'we need a magic guy');

INSERT INTO JOBPOSTINGS (accID, skillA, skillB, skillC, skillD,  skillE, address, description)
VALUES (2, 'sighting', 'repair excpert', 'swift turn', 'rapid unload', 'rapid reload', '5678 S Verdun St', 'we need a tankman');

SELECT accID FROM jobmatch
WHERE match = (SELECT MAX(match) FROM jobmatch) AND jobid = 1;

DELETE
FROM jobpostings
WHERE jobid = 2;

INSERT INTO EMPACC (email, password, fname, lname, phone, description)
VALUES ('gmage99@gmail.com', 'jhuygtrd', 'green', 'mage', 1112223339, 'I do white and green magic');

INSERT INTO EMPSKILLS VALUES (4, 'cure', 'haste', 'protect', 'shell', 'poison');

INSERT INTO applicants
VALUES (4, 1);