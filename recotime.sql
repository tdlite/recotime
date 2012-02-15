/* DATABASE RECOTIME */
CREATE DATABASE 'C:\WINDOWS\RECOTIME.FDB'
USER 'recotime' PASSWORD 'cxv3nk9w' 
PAGE_SIZE = 8192 
DEFAULT CHARACTER SET WIN1251;

/* GENERATORS */
CREATE GENERATOR GEN_USERID;
SET GENERATOR GEN_USERID TO 0;

CREATE GENERATOR GEN_EVENTID;
SET GENERATOR GEN_EVENTID TO 0;

/* TABLE USERS */
CREATE TABLE USERS (
USERID INTEGER NOT NULL,
GROUPID INTEGER NOT NULL,
USERNAME VARCHAR(255) NOT NULL,
FULLNAME VARCHAR(255),
CITYNAME VARCHAR(255),
WORKTIME VARCHAR(255),
ENABLED SMALLINT NOT NULL,
PRIMARY KEY (USERID));

/* TABLE GROUPS */
CREATE TABLE GROUPS (
GROUPID INTEGER NOT NULL,
GROUPNAME VARCHAR(255),
EMAIL VARCHAR(255),
PRIMARY KEY (GROUPID));

/* TABLE EVENTS */
CREATE TABLE EVENTS (
EVENTID INTEGER NOT NULL,
EVENTTIME TIMESTAMP NOT NULL,
EVENTTEXT VARCHAR(1024),
USERID INTEGER NOT NULL,
PRIMARY KEY (EVENTID));

/* TABLE PARAMS */
CREATE TABLE PARAMS (
PARAMID INTEGER NOT NULL,
PARAMDATA BLOB SUB_TYPE 0 SEGMENT SIZE 80,
PRIMARY KEY (PARAMID));

SET TERM ^ ;

/* PROCEDURE GET_USERINFO */
CREATE PROCEDURE GET_USERINFO (USERNAME VARCHAR(255), FULLNAME VARCHAR(255), CITYNAME VARCHAR(255))
RETURNS (USERID INTEGER, EMAIL VARCHAR(255), WORKTIME VARCHAR(255), ENABLED SMALLINT)
AS
BEGIN
  USERID = NULL;
  EMAIL = NULL;
  WORKTIME = '9:30';
  ENABLED = 1;
  SELECT USERID, EMAIL, WORKTIME, ENABLED FROM USERS
  LEFT JOIN GROUPS ON USERS.GROUPID = GROUPS.GROUPID
  WHERE USERNAME = UPPER(:USERNAME) INTO :USERID, :EMAIL, :WORKTIME, :ENABLED;
  IF (USERID IS NULL) THEN
  BEGIN
    USERID = GEN_ID(GEN_USERID, 1);
    INSERT INTO USERS (USERID, GROUPID, USERNAME, FULLNAME, CITYNAME, WORKTIME, ENABLED)
    VALUES (:USERID, 0, UPPER(:USERNAME), :FULLNAME, :CITYNAME, :WORKTIME, :ENABLED);
    SELECT EMAIL FROM GROUPS
    WHERE GROUPID = 0 INTO :EMAIL;
  END
END^

/* PROCEDURE CHECK_ENTRY */
CREATE PROCEDURE CHECK_ENTRY (USERID INTEGER, EVENTTIME TIMESTAMP)
RETURNS (EXIST SMALLINT)
AS
DECLARE VARIABLE EVENTID INTEGER;
BEGIN
  EVENTID = NULL;  
  SELECT FIRST 1 SKIP 0 EVENTID FROM EVENTS
  WHERE USERID = :USERID AND EVENTTIME > CAST(:EVENTTIME AS DATE) INTO :EVENTID;
  IF (EVENTID IS NULL) THEN
  BEGIN
    EXIST = 0;
    EVENTID = GEN_ID(GEN_EVENTID, 1);
    INSERT INTO EVENTS (EVENTID, EVENTTIME, USERID)
    VALUES (:EVENTID, :EVENTTIME, :USERID);
  END
  ELSE EXIST = 1;
END^

/* PROCEDURE SET_COMMENT */
CREATE PROCEDURE SET_COMMENT (USERID INTEGER, COMMENT VARCHAR(1024))
AS
DECLARE VARIABLE EVENTID INTEGER;
DECLARE VARIABLE EVENTTIME TIMESTAMP;
BEGIN
  EVENTID = NULL;
  EVENTTIME = NULL;
  SELECT MAX(EVENTTIME) FROM EVENTS
  WHERE USERID = :USERID INTO :EVENTTIME;
  IF (EVENTTIME IS NULL) THEN EXIT;  
  SELECT EVENTID FROM EVENTS
  WHERE USERID = :USERID AND EVENTTIME = :EVENTTIME INTO :EVENTID;
  IF (EVENTID IS NULL) THEN EXIT;  
  UPDATE EVENTS SET EVENTTEXT = :COMMENT
  WHERE EVENTID = :EVENTID;
END^

SET TERM ; ^ 