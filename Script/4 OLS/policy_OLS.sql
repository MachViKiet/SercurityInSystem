-- Connect with SYS AS SYSDBA account
ALTER SESSION SET CURRENT_SCHEMA = QL_TRUONGHOC_X;

SELECT VALUE FROM v$option WHERE parameter = 'Oracle Label Security';
SELECT status FROM dba_ols_status WHERE name = 'OLS_CONFIGURE_STATUS';
---> BAT OLS NEU CHUA BAT/ CHUA DANG KY THI DANG KY OLS VA BAT OLS
BEGIN
    LBACSYS.CONFIGURE_OLS;
    -- C�c c�u l?nh PL/SQL kh�c ? ?�y n?u c?n
END;

EXEC LBACSYS.OLS_ENFORCEMENT.ENABLE_OLS; -- This procedure enables it
---> KHOI DONG LAI
SHUTDOWN IMMEDIATE;
STARTUP;
---> KIEM TRA PDB CO CHUA (VI KO THE TAO OLS TREN CDB)
select * from v$services;
---> UNLOCK LBACSYS (OLS ADMIN)
ALTER USER lbacsys IDENTIFIED BY lbacsys ACCOUNT UNLOCK;
SELECT * FROM DBA_PDBS WHERE pdb_name = 'XEPDB1';
SELECT SYS_CONTEXT('USERENV', 'CON_NAME') AS CONTAINER_NAME FROM DUAL;
SELECT SYS_CONTEXT('USERENV', 'CURRENT_SCHEMA') AS CURRENT_SCHEMA FROM DUAL;

---> NEU CO ROI THI MO PDB
ALTER PLUGGABLE DATABASE XEPDB1 OPEN READ WRITE;
---> CHUYEN QUA PDB
ALTER SESSION SET CONTAINER= XEPDB1;
SHOW CON_NAME;
--DROP USER QL_TRUONGHOC_X CASCADE;
--CREATE USER QL_TRUONGHOC_X IDENTIFIED BY 123 CONTAINER = CURRENT;

GRANT CONNECT,RESOURCE TO QL_TRUONGHOC_X; --CAP QUYEN CONNECT VA RESOURCE
GRANT UNLIMITED TABLESPACE TO QL_TRUONGHOC_X; --CAP QUOTA CHO QL_TRUONGHOC_X
GRANT SELECT ANY DICTIONARY TO QL_TRUONGHOC_X; --CAP QUYEN DOC DICTIONARY

---> CAP QUYEN EXECUTE CHO QL_TRUONGHOC_X
GRANT EXECUTE ON LBACSYS.SA_COMPONENTS TO QL_TRUONGHOC_X WITH GRANT OPTION;
GRANT EXECUTE ON LBACSYS.sa_user_admin TO QL_TRUONGHOC_X WITH GRANT OPTION;
GRANT EXECUTE ON LBACSYS.sa_label_admin TO QL_TRUONGHOC_X WITH GRANT OPTION;
GRANT EXECUTE ON sa_policy_admin TO QL_TRUONGHOC_X WITH GRANT OPTION;
GRANT EXECUTE ON char_to_label TO QL_TRUONGHOC_X WITH GRANT OPTION;
---> ADD QL_TRUONGHOC_X V�O LBAC_DBA
GRANT LBAC_DBA TO QL_TRUONGHOC_X;
GRANT EXECUTE ON sa_sysdba TO QL_TRUONGHOC_X;
GRANT EXECUTE ON TO_LBAC_DATA_LABEL TO QL_TRUONGHOC_X;
