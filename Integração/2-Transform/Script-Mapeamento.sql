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
	COMM_SAL 	------		NVL(EMP.COMM,0) + EMP.SAL + ( CASE DEP.DEPTNO                DECODE ( DEP.DEPTNO, 10, (EMP.SAL * 0.35),
													WHEN 10 THEN (EMP.SAL * 0.35)                             20, (EMP.SAL * 0.30),
													WHEN 20 THEN (EMP.SAL * 0.30)		                      30, (EMP.SAL * 0.25),
													WHEN 30 THEN (EMP.SAL * 0.25)                             40, (EMP.SAL * 0.28),
													WHEN 40 THEN (EMP.SAL * 0.28)                             50, (EMP.SAL * 0.20),
													WHEN 50 THEN (EMP.SAL * 0.20)                             60, (EMP.SAL * 0.23))
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