---------------------------------------- S E Q U E N C E --------------------------------------------
CREATE SEQUENCE SEQ_EMP 
 START WITH     1
 MAXVALUE	99999
 INCREMENT BY   1
 NOCACHE
 CYCLE    --NO CYCLE = defaul
;

--GRANT SELECT, INSERT, UPDATE, DELETE ON SEQ_EMP TO ODI_OWNER;
-------------------------------- T A B L E    D E P A R T A M E N T O ---------------------------------------------
CREATE TABLE DEPARTAMENTO (
	DEPTNO		NUMBER  		NOT NULL,
	DNAME	 	VARCHAR2(100)   NOT NULL,
	DEPTNO_C	NUMBER			NOT NULL
);

ALTER TABLE DEPARTAMENTO ADD CONSTRAINT PK_DPTNO PRIMARY KEY (DEPTNO);


INSERT INTO DEPARTAMENTO VALUES (10, 'PRESIDENT', 35);	
INSERT INTO DEPARTAMENTO VALUES (20, 'MANAGER', 30);	
INSERT INTO DEPARTAMENTO VALUES (30, 'ANALYST', 25);
INSERT INTO DEPARTAMENTO VALUES (40, 'SALESMAN', 28);
INSERT INTO DEPARTAMENTO VALUES (50, 'CLERK', 20);	
INSERT INTO DEPARTAMENTO VALUES (60, 'VENDEDOR', 23);	
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

---------- ---------- --------- ---------- ---------- ----------
--INSERT 	  EMPNO ENAME JOB MGR HIREDATE SAL COMM  DEPTNO
---------- ---------- --------- ---------- ---------- ----------                               
INSERT INTO EMP VALUES (7369, 'SMITH CLERK'	    ,7902, '17/12/1980', 800 , ''  , 50, 'DESC-36-9');
INSERT INTO EMP VALUES (7499, 'ALLEN SALESMAN'  ,7698, '20/02/1981', 1600, 300 , 40, 'DESC-49-9');
INSERT INTO EMP VALUES (7521, 'WARD SALESMAN'   ,7698, '22/02/1981', 1250, 500 , 40, 'DESC-52-1');
INSERT INTO EMP VALUES (7566, 'JONES MANAGER'   ,7839, '02/04/1981', 2975,  '' , 20, 'DESC-56-6');
INSERT INTO EMP VALUES (7654, 'MARTIN SALESMAN'	,7698, '28/09/1981', 1250,1400 , 40, 'DESC-65-4');
INSERT INTO EMP VALUES (7698, 'BLAKE MANAGER' 	,7839, '01/05/1981', 2850, ''  , 20, 'DESC-69-8');
INSERT INTO EMP VALUES (7782, 'CLARK MANAGER' 	,7839, '09/06/1981', 2450, ''  , 20, 'DESC-78-2');
INSERT INTO EMP VALUES (7788, 'SCOTT ANALYST' 	,7566, '09/12/1982', 3000, ''  , 30, 'DESC-78-8');
INSERT INTO EMP VALUES (7839, 'KING PRESIDENT' 	, '' , '17/11/1981', 5000, ''  , 10, 'DESC-83-9');
INSERT INTO EMP VALUES (7844, 'TURNER SALESMAN' ,7698, '08/09/1981', 1500, 0   , 40, 'DESC-84-4');
INSERT INTO EMP VALUES (7876, 'ADAMS CLERK' 	,7788, '12/01/1983', 1100, ''  , 50, 'DESC-87-6');
INSERT INTO EMP VALUES (7900, 'JAMES CLERK' 	,7698, '03/12/1981', 950 , ''  , 50, 'DESC-90-3');
INSERT INTO EMP VALUES (7902, 'FORD ANALYST' 	,7566, '03/12/1981', 3000, ''  , 30, 'DESC-90-2');
INSERT INTO EMP VALUES (7934, 'MILLER CLERK' 	,7782, '23/01/1982', 1300, ''  , 50, 'DESC-93-4');
-------------------------------- T A B L E    O D I    E M P ------------------------------------------ 
CREATE TABLE ODI_EMP (
	SEQEMP 		NUMBER 		NOT NULL,
	EMPNO 		NUMBER 		 NOT NULL,
	ENAME 		VARCHAR2(50) NOT NULL,
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
-------------------------------- M A P E A M E N T O    O D I ---------------------------------------------
	SEQEMP 		------ 		:SEQ_EMP.NEXTVAL
	EMPNO 		------		EMP.EMPNO
	ENAME 		------		EMP.ENAME
	MGR	  		------		EMP.MGR
	HIREDATE 	------		TO_DATE(EMP.HIREDATE, 'YYYY/MM/DD')
	SAL			------		TO_NUMBER(EMP.SAL, '9G999G999D00', 'nls_numeric_characters = .,')
	COMM 		------		EMP.COMM
	AUMENTO		------ 		CASE DEP.DEPTNO                             DECODE ( DEP.DEPTNO, 10, (EMP.SAL * 0.35),
								WHEN 10 THEN (EMP.SAL * 0.35)                                20, (EMP.SAL * 0.30),
								WHEN 20 THEN (EMP.SAL * 0.30)			                     30, (EMP.SAL * 0.25),
								WHEN 30 THEN (EMP.SAL * 0.25)                                40, (EMP.SAL * 0.28),
								WHEN 40 THEN (EMP.SAL * 0.28)                                50, (EMP.SAL * 0.20),
								WHEN 50 THEN (EMP.SAL * 0.20)                                60, (EMP.SAL * 0.23))
								WHEN 60 THEN (EMP.SAL * 0.23)                                
								ELSE 0                                                       
							END 
	COMM_SAL 	------		NVL(EMP.COMM,0) + EMP.SAL + ( CASE DEP.DEPTNO 
													WHEN 10 THEN (EMP.SAL * 0.35)                            
													WHEN 20 THEN (EMP.SAL * 0.30)			            
													WHEN 30 THEN (EMP.SAL * 0.25)                            
													WHEN 40 THEN (EMP.SAL * 0.28)                            
													WHEN 50 THEN (EMP.SAL * 0.20)                            
													WHEN 60 THEN (EMP.SAL * 0.23)                            
													ELSE 0
												END ) 
	DEPTNO		------		EMP.DEPTNO
	DESC_EMP	------		DEPT.DNAME
	NVEMP		------		REGEXP_SUBSTR(emp.desc_emp, '(\d)+',1,2)
	DNAME	 	------		CASE (REGEXP_SUBSTR(emp.desc_emp, '(\d)+',1,2)) 
								WHEN 1 THEN ('Profissional com baixo nível de performance, precisa de treinamento.')
								WHEN 2 THEN ('Profissional com baixo nível de performance, precisa de treinamento.')
								WHEN 3 THEN ('Profissional com baixo nível de performance, precisa de treinamento.')
								WHEN 4 THEN ('Profissional com baixo nível de performance, precisa de treinamento.')
								WHEN 5 THEN ('Profissional com baixo nível de performance, precisa de treinamento.')
								WHEN 6 THEN ('Profissional com alto nível de performance, não precisa de treinamento.')
								WHEN 7 THEN ('Profissional com alto nível de performance, não precisa de treinamento.')
								WHEN 8 THEN ('Profissional com alto nível de performance, não precisa de treinamento.')
								WHEN 9 THEN ('Profissional com alto nível de performance, não precisa de treinamento.')
							ELSE ('ERRO')
	DATACARGA	------		SYSDATE
-------------------------------------- R O L L B A C K ---------------------------------------------
DROP TABLE DEPARTAMENTO;
DROP TABLE EMP;
DROP SEQUENCE SEQ_EMP;


