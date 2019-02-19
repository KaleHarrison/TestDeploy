-------------------------------------------------------------------------------
-- TABLES
-------------------------------------------------------------------------------
CREATE TABLE PLAYER
(
    P_ID NUMBER NOT NULL,
    P_USERNAME VARCHAR2(50) NOT NULL,
    P_PASSWORD VARCHAR2(50) NOT NULL,
    P_EMAIL VARCHAR2(50) NOT NULL,
    P_FIRSTNAME VARCHAR2(50) NOT NULL,
    P_LASTNAME VARCHAR2(50) NOT NULL,
    CONSTRAINT PK_P_ID PRIMARY KEY (P_ID),
    CONSTRAINT UNQ_P_USERNAME UNIQUE (P_USERNAME)
);

CREATE TABLE GAME
(
    G_ID NUMBER NOT NULL,
    G_NAME VARCHAR2(50) NOT NULL,
    G_TYPE VARCHAR2(50) NOT NULL,
    CONSTRAINT PK_G_ID PRIMARY KEY (G_ID),
    CONSTRAINT UNQ_G_NAME UNIQUE (G_NAME)
);

CREATE TABLE GAME_SESSION
(
    GS_ID NUMBER NOT NULL,
    P_ID NUMBER NOT NULL,
    G_ID NUMBER NOT NULL,
    GS_STATUS VARCHAR2(50) NOT NULL,
    GS_DATE VARCHAR2(50) NOT NULL,
    CONSTRAINT PK_GS_ID PRIMARY KEY (GS_ID),
    CONSTRAINT FK_P_ID FOREIGN KEY (P_ID) REFERENCES PLAYER(P_ID),
    CONSTRAINT FK_G_ID FOREIGN KEY (G_ID) REFERENCES GAME(G_ID)
);

SELECT * FROM PLAYER;
SELECT * FROM GAME;
SELECT * FROM GAME_SESSION;

INSERT INTO PLAYER VALUES(0, 'admin', 'admin', 'admin@admin.admin', 'admin', 'admin');
INSERT INTO GAME VALUES(0, 'TWENTY_QUESTIONS', 'TWENTY_QUESTIONS');
SELECT * FROM GAME_SESSION WHERE P_ID = 1 AND G_ID = 1 AND GS_Date = '';

EXEC DELETE_ALL_GAME_SESSION;
EXEC DELETE_ALL_PLAYER;
EXEC DELETE_ALL_GAME;
commit;
-------------------------------------------------------------------------------
-- SEQUENCERS
-------------------------------------------------------------------------------

CREATE SEQUENCE PLAYER_SEQ
    START WITH 1
    INCREMENT BY 1;
    
CREATE SEQUENCE GAME_SEQ
    START WITH 1
    INCREMENT BY 1;

CREATE SEQUENCE GAME_SESSION_SEQ
    START WITH 1
    INCREMENT BY 1;
    
-------------------------------------------------------------------------------
-- STORED PROCEDURES
-------------------------------------------------------------------------------

-- YUVI's - HASHING FUNCTION THAT COMBINES USERNAME, PASSWORD AND A SPECIAL WORD
CREATE OR REPLACE FUNCTION GET_PLAYER_HASH(USERNAME VARCHAR2, PASSWORD VARCHAR2) RETURN VARCHAR2
IS
EXTRA VARCHAR2(10) := 'SALT';
BEGIN
  RETURN TO_CHAR(DBMS_OBFUSCATION_TOOLKIT.MD5(
  INPUT => UTL_I18N.STRING_TO_RAW(DATA => USERNAME || PASSWORD || EXTRA)));
END;
/

CREATE OR REPLACE PROCEDURE DELETE_ALL_PLAYER
AS
BEGIN
    DELETE FROM (SELECT * FROM PLAYER);
end;
/

CREATE OR REPLACE PROCEDURE DELETE_ALL_GAME
AS
BEGIN
    DELETE FROM (SELECT * FROM GAME);
end;
/

CREATE OR REPLACE PROCEDURE DELETE_ALL_GAME_SESSION
AS
BEGIN
    DELETE FROM (SELECT * FROM GAME_SESSION);
end;
/

-------------------------------------------------------------------------------
-- TRIGGERS
-------------------------------------------------------------------------------
    
CREATE OR REPLACE TRIGGER PLAYER_B_INSERT
BEFORE INSERT ON PLAYER FOR EACH ROW
BEGIN
  -- INCREASE THE SEQUENCE
  IF :NEW.P_ID IS NULL THEN
    SELECT PLAYER_SEQ.NEXTVAL INTO :NEW.P_ID FROM DUAL;
  END IF;
END;
/

CREATE OR REPLACE TRIGGER GAME_B_INSERT
BEFORE INSERT ON GAME FOR EACH ROW
BEGIN
  -- INCREASE THE SEQUENCE
  IF :NEW.G_ID IS NULL THEN
    SELECT GAME_SEQ.NEXTVAL INTO :NEW.G_ID FROM DUAL;
  END IF;
END;
/
 
CREATE OR REPLACE TRIGGER GAME_SESSION_B_INSERT
BEFORE INSERT ON GAME_SESSION FOR EACH ROW
BEGIN
  -- INCREASE THE SEQUENCE
  IF :NEW.GS_ID IS NULL THEN
    SELECT GAME_SESSION_SEQ.NEXTVAL INTO :NEW.GS_ID FROM DUAL;
  END IF;
END;
/
 
-------------------------------------------------------------------------------
-- SYNONYMS
-------------------------------------------------------------------------------

CREATE OR REPLACE PUBLIC SYNONYM PLAYER FOR admin.PLAYER;
CREATE OR REPLACE PUBLIC SYNONYM GAME FOR admin.GAME;
CREATE OR REPLACE PUBLIC SYNONYM GAME_SESSION FOR admin.GAME_SESSION;
CREATE OR REPLACE PUBLIC SYNONYM PLAYER_SEQ FOR admin.PLAYER_SEQ;
CREATE OR REPLACE PUBLIC SYNONYM GAME_SEQ FOR admin.GAME_SEQ;
CREATE OR REPLACE PUBLIC SYNONYM GAME_SESSION_SEQ FOR admin.GAME_SESSION_SEQ;
CREATE OR REPLACE PUBLIC SYNONYM INSERT_PLAYER FOR admin.INSERT_PLAYER;
CREATE OR REPLACE PUBLIC SYNONYM INSERT_GAME FOR admin.INSERT_GAME;
CREATE OR REPLACE PUBLIC SYNONYM INSERT_GAME_SESSION FOR admin.INSERT_GAME_SESSION;
CREATE OR REPLACE PUBLIC SYNONYM DELETE_ALL_PLAYER FOR admin.DELETE_ALL_PLAYER;
CREATE OR REPLACE PUBLIC SYNONYM DELETE_ALL_GAME FOR admin.DELETE_ALL_GAME;
CREATE OR REPLACE PUBLIC SYNONYM DELETE_ALL_GAME_SESSION FOR admin.DELETE_ALL_GAME_SESSION;
CREATE OR REPLACE PUBLIC SYNONYM PLAYER_B_INSERT FOR admin.PLAYER_B_INSERT;
CREATE OR REPLACE PUBLIC SYNONYM GAME_B_INSERT FOR admin.GAME_B_INSERT;
CREATE OR REPLACE PUBLIC SYNONYM GAME_SESSION_B_INSERT FOR admin.GAME_SESSION_B_INSERT;