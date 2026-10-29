create table empAcc 
( accID         number  (10) GENERATED ALWAYS AS IDENTITY,
  email         varchar2(50) ,
  password      varchar2(50) ,
  fName         varchar2(50) ,
  lName         varchar2(50) ,
  phone         number  (10) ,
  description   varchar2(255), 
  PRIMARY KEY   (accID) );

create table empSkills 
( accID         number  (10) ,
  skillA        varchar2(50) ,
  skillB        varchar2(50) ,
  skillC        varchar2(50) ,
  skillD        varchar2(50) ,
  skillE        varchar2(50) ,
  FOREIGN KEY (accID) REFERENCES empAcc(accID) );

create table compAcc 
( accID         number  (10) GENERATED ALWAYS AS IDENTITY,
  userName      varchar2(50) ,
  password      varchar2(50) ,
  compName      varchar2(50) ,
  email         varchar2(50) ,
  phone         number  (10) ,
  address       varchar2(100) ,
  description   varchar2(255), 
  PRIMARY KEY   (accID) );

create table jobPostings
( accID         number  (10) ,
  jobID         number  (10) GENERATED ALWAYS AS IDENTITY,
  skillA        varchar2(50) ,
  skillB        varchar2(50) ,
  skillC        varchar2(50) ,
  skillD        varchar2(50) ,
  skillE        varchar2(50) ,
  address       varchar2(100),
  description   varchar2(255), 
  FOREIGN KEY (accID) REFERENCES compAcc(accID) ,
  PRIMARY KEY (jobID) );
  
create table jobMatch
( accID number  (10) ,
  jobID number  (10) ,
  match number  (1)  ,
  FOREIGN KEY (accID) REFERENCES empAcc(accID) ,
  FOREIGN KEY (jobID) REFERENCES jobPostings(jobID) );
  
create table applicants
( accID number  (10) ,
  jobID number  (10) ,
  FOREIGN KEY (accID) REFERENCES empAcc(accID) ,
  FOREIGN KEY (jobID) REFERENCES jobPostings(jobID) );