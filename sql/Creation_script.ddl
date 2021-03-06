CREATE DATABASE dbd_project;
USE dbd_project;
CREATE TABLE PRJCT
(
   PRJCT_NUM            VARCHAR(10) NOT NULL ,
   PRJCT_NM             VARCHAR(50) NOT NULL ,
   OUTSET_DE            DATE NOT NULL ,
   ENDDE                DATE NOT NULL ,
   ORNT                 VARCHAR(10) NOT NULL 
);

CREATE UNIQUE INDEX XPK프로젝트 ON PRJCT(PRJCT_NUM   ASC);

ALTER TABLE PRJCT
   ADD CONSTRAINT  XPK프로젝트 PRIMARY KEY (PRJCT_NUM);

CREATE TABLE DEV_PRJCT
(
   PRJCT_NUM            VARCHAR(10) NOT NULL ,
   PARTCPTN_BGNDE       DATE NOT NULL ,
   DTY                  VARCHAR(10) NOT NULL ,
   SKLST                VARCHAR(10) NULL ,
   PARTCPTN_ENDDE       DATE NOT NULL ,
   EMP_NUM              VARCHAR(10) NOT NULL 
);

CREATE UNIQUE INDEX XPK개발자프로젝트 ON DEV_PRJCT
(PRJCT_NUM   ASC,EMP_NUM   ASC);

ALTER TABLE DEV_PRJCT
   ADD CONSTRAINT  XPK개발자프로젝트 PRIMARY KEY (PRJCT_NUM,EMP_NUM);

CREATE TABLE APRSL
(
   APRSL_KND            VARCHAR(10) NOT NULL ,
   APRSL_ITEM           VARCHAR(10) NOT NULL ,
   GRAD                 INT(2) NULL ,
   APRSL_CN             VARCHAR(255) NULL ,
   PRJCT_NUM            VARCHAR(10) NOT NULL ,
   APRSE                VARCHAR(10) NOT NULL ,
   APRSL_NUM            VARCHAR(10) NOT NULL 
);

CREATE UNIQUE INDEX XPK평가 ON APRSL
(APRSE   ASC,PRJCT_NUM   ASC,APRSL_KND   ASC,APRSL_ITEM   ASC,APRSL_NUM   ASC);

ALTER TABLE APRSL
   ADD CONSTRAINT  XPK평가 PRIMARY KEY (APRSE,PRJCT_NUM,APRSL_KND,APRSL_ITEM,APRSL_NUM);

CREATE TABLE CLTCDSRT
(
   CLTCD                VARCHAR(10) NOT NULL ,
   COMPANY_NM           VARCHAR(50) NULL 
);

CREATE UNIQUE INDEX XPK고객사코드분류 ON CLTCDSRT
(CLTCD   ASC);

ALTER TABLE CLTCDSRT
   ADD CONSTRAINT  XPK고객사코드분류 PRIMARY KEY (CLTCD);

CREATE TABLE APRSL_EMP
(
   PRJCT_NUM            VARCHAR(10) NOT NULL ,
   APRSL_NUM            VARCHAR(10) NOT NULL 
);

CREATE UNIQUE INDEX XPK평가직원 ON APRSL_EMP
(APRSL_NUM   ASC);

ALTER TABLE APRSL_EMP
   ADD CONSTRAINT  XPK평가직원 PRIMARY KEY (APRSL_NUM);

CREATE TABLE DEV
(
   EMP_NUM              VARCHAR(10) NOT NULL ,
   CAREER               INT(2) NULL ,
   TCHNLGY_GRAD         VARCHAR(10) NULL 
);

CREATE UNIQUE INDEX XPK개발자 ON DEV
(EMP_NUM   ASC);

ALTER TABLE DEV
   ADD CONSTRAINT  XPK개발자 PRIMARY KEY (EMP_NUM);

CREATE TABLE EMP
(
   EMP_NUM              VARCHAR(10) NOT NULL ,
   EMP_NM               VARCHAR(50) NOT NULL ,
   IDNUM                VARCHAR(14) NOT NULL ,
   ACDMCR               VARCHAR(50) NOT NULL ,
   ID                   VARCHAR(50) NOT NULL ,
   EMP_SRTCD            VARCHAR(5) NOT NULL 
);

CREATE UNIQUE INDEX XPK직원 ON EMP
(EMP_NUM   ASC);

ALTER TABLE EMP
   ADD CONSTRAINT  XPK직원 PRIMARY KEY (EMP_NUM);

ALTER TABLE DEV_PRJCT
   ADD (CONSTRAINT R_13 FOREIGN KEY (PRJCT_NUM) REFERENCES PRJCT (PRJCT_NUM));

ALTER TABLE DEV_PRJCT
   ADD (CONSTRAINT R_59 FOREIGN KEY (EMP_NUM) REFERENCES DEV (EMP_NUM));

ALTER TABLE APRSL
   ADD (CONSTRAINT R_29 FOREIGN KEY (PRJCT_NUM, APRSE) REFERENCES DEV_PRJCT (PRJCT_NUM, EMP_NUM));

ALTER TABLE APRSL
   ADD (CONSTRAINT R_62 FOREIGN KEY (APRSL_NUM) REFERENCES APRSL_EMP (APRSL_NUM));

ALTER TABLE APRSL_EMP
   ADD (CONSTRAINT R_64 FOREIGN KEY (PRJCT_NUM, APRSL_NUM) REFERENCES DEV_PRJCT (PRJCT_NUM, EMP_NUM));

ALTER TABLE DEV
   ADD (CONSTRAINT R_4 FOREIGN KEY (EMP_NUM) REFERENCES EMP (EMP_NUM) ON DELETE CASCADE);