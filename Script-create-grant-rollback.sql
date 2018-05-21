---------------------------------------- S E Q U E N C E --------------------------------------------
CREATE SEQUENCE SEQ_EMP 
 START WITH     1
 MAXVALUE	99999
 INCREMENT BY   1
 NOCACHE
 CYCLE    --NO CYCLE = defaul
;


-------------------------------- T A B L E    D E P A R T A M E N T O ---------------------------------------------
CREATE TABLE DEPARTAMENTO (
	DEPTNO		NUMBER  		NOT NULL,
	DNAME	 	VARCHAR2(100)   NOT NULL,
	DEPTNO_C	NUMBER			NOT NULL
);

ALTER TABLE DEPARTAMENTO ADD CONSTRAINT PK_DPTNO PRIMARY KEY (DEPTNO);

--------------------------------- T A B L E         E M P  ---------------------------------------------
CREATE TABLE EMP (
	EMPNO 		NUMBER 		 NOT NULL,
	ENAME 		VARCHAR2(50) NOT NULL,
	MGR	  		NUMBER,
	HIREDATE 	DATE,
	SAL			NUMBER,
	COMM 		NUMBER,
	DEPTNO		NUMBER,
	DESC_EMP	VARCHAR2(400)
);

ALTER TABLE EMP ADD CONSTRAINT PK_EMPNO PRIMARY KEY (EMPNO);
ALTER TABLE EMP ADD CONSTRAINT FK_EMPNO FOREIGN KEY (DEPTNO) REFERENCES DEPARTAMENTO(DEPTNO);

-------------------------------- T A B L E    O D I    E M P ------------------------------------------ 
CREATE TABLE ODI_EMP (
	SEQEMP 		NUMBER 			NOT NULL,
	EMPNO 		NUMBER 		 	NOT NULL,
	ENAME 		VARCHAR2(50) 	NOT NULL,
	MGR	  		VARCHAR2(100),
	HIREDATE 	DATE,
	SAL			NUMBER,
	COMM 		NUMBER,
	AUMENTO		NUMBER,
	COMM_SAL	NUMBER,
	DEPTNO		NUMBER,
	DESC_EMP	VARCHAR2(400),
	NVEMP		VARCHAR2(100),
	DNAME	 	VARCHAR2(100),
	DATACARGA	DATE
);

-------------------------------------- G R A N T ' s ---------------------------------------------
GRANT SELECT, INSERT, UPDATE, DELETE ON SEQ_EMP TO ODI_MASTER;
GRANT SELECT, INSERT, UPDATE, DELETE ON DEPARTAMENTO TO ODI_MASTER;
GRANT SELECT, INSERT, UPDATE, DELETE ON EMP TO ODI_MASTER;
GRANT SELECT, INSERT, UPDATE, DELETE ON ODI_EMP TO ODI_MASTER;

-------------------------------------- R O L L B A C K ---------------------------------------------
DROP TABLE DEPARTAMENTO;
DROP TABLE EMP;
DROP SEQUENCE SEQ_EMP;


