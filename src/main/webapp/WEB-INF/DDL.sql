CREATE TABLE USERS (
                       ID    VARCHAR2(50)    PRIMARY KEY    NOT NULL,
                       PWD    VARCHAR2(50)        NOT NULL,
                       NAME    VARCHAR2(50)        NOT NULL,
                       EMAIL    VARCHAR2(100)        NOT NULL
);

CREATE TABLE COMMUNITY (
                           IDX    NUMBER     PRIMARY KEY    NOT NULL,
                           TITLE    VARCHAR2(100)        NOT NULL,
                           POSTDATE    DATE  DEFAULT SYSDATE ,
                           VIEWS    NUMBER        DEFAULT 0 ,
                           LIKES    NUMBER        DEFAULT 0 ,
                           TYPE    VARCHAR2(2)        DEFAULT 'C'
);


CREATE TABLE ATTENDLIST (
                            IDX    NUMBER PRIMARY KEY    NOT NULL,
                            ID    VARCHAR2(50)        NOT NULL,
                            TEL    VARCHAR2(50)        NOT NULL,
                            ATTEND_DATE    DATE        NOT NULL
);