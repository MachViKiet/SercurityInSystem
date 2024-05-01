
select * from V$OPTION WHERE PARAMETER = 'Unified Auditing';
SELECT * FROM V$OPTION WHERE PARAMETER = 'Unified Auditing';


CREATE AUDIT POLICY role_dba_adit_pol ROLES DBA CONTAINER = ALL

--1. kich hoat viec ghi nhat ky he thong
ALTER SYSTEM SET LOG_ARCHIVE_DEST = '/archive' SCOPE=SPFILE;
ALTER SYSTEM SET LOG_ARCHIVE_FORMAT = 'arch_%t_%s_%r.log' SCOPE=SPFILE;
ALTER SYSTEM SET LOG_ARCHIVE_START = TRUE SCOPE=SPFILE;

SHUTDOWN IMMEDIATE;
STARTUP;

--2. thuc hien ghi nhat ky he thong dung Standard audit: theo doi hanh vi cua nhung user
--nao tren nhung doi tuong cu the, tren cac doi tuong khac nhau (table, view, stored procedure, function), 
--hay chi dinh theo doi cac hanh vi hien thanh cong hay khong thanh cong

ALTER SYSTEM SET AUDIT_TRAIL=DB, EXTENDED SCOPE=SPFILE;


--3. Thuc hien Fine-grained Audit 
----a. Hanh vi cap nhat quan he DANGKY tai cac truong lien quan den diem so nhung nguoi do khong thuoc vai tro Giang vien
CREATE OR REPLACE CONTEXT check_vaitro USING SET_CHECK_VAITRO;
/
CREATE OR REPLACE PACKAGE SET_CHECK_VAITRO 
IS 
   PROCEDURE SET_VAITRO; 
END; 
/

select * from STMT_AUDIT_OPTION_MAP;
audit table by QL_TRUONGHOC_X;

audit table by QL_TRUONGHOC_X whenever successful;
audit role by QL_TRUONGHOC_X;

audit select table, update table, delete table by QL_TRUONGHOC_X by access;
audit delete table by QL_TRUONGHOC_X;

 -- T?t auditing:
--noaudit insert,update on DBAVIET.EMP by QL_TRUONGHOC_X;
--noAUDIT delete on DBAVIET.EMP by QL_TRUONGHOC_X;

-- Audit ho?t ??ng SELECT/DML c?a 1 user (DBAVIET):
audit select table,insert table,update table,delete table by QL_TRUONGHOC_X by access;
audit execute procedure by QL_TRUONGHOC_X by access;
audit all by QL_TRUONGHOC_X by access;

AUDIT ALL BY ACCESS;
AUDIT SELECT TABLE;
CREATE OR REPLACE PACKAGE BODY SET_CHECK_VAITRO  
IS
    PROCEDURE SET_VAITRO
    IS
        VAITRO_ QL_TRUONGHOC_X.NHANSU.VAITRO%TYPE;
    BEGIN 
        SELECT VAITRO INTO VAITRO_ 
        FROM QL_TRUONGHOC_X.NHANSU
        WHERE MANV = SYS_CONTEXT('USERENV', 'SESSION_USER');
        
        DBMS_SESSION.SET_CONTEXT('check_vaitro', 'vaitro', VAITRO_);
    EXCEPTION 
        WHEN NO_DATA_FOUND THEN NULL;
    END;
END;
/
DROP TRIGGER SET_CHECK_VAITTO_TRG;
CREATE TRIGGER SET_CHECK_VAITTO_TRG AFTER LOGON ON DATABASE 
BEGIN
    SET_CHECK_VAITRO.SET_VAITRO;
END;
/


BEGIN
dbms_fga.DROP_policy (
    object_schema => 'QL_TRUONGHOC_X',
    object_name => 'DANGKY',
    policy_name => 'UPDATE_DANGKY');
END;

BEGIN
dbms_fga.add_policy (
    object_schema => 'QL_TRUONGHOC_X',
    object_name => 'DANGKY',
    policy_name => 'UPDATE_DANGKY',
    statement_types => 'UPDATE',
    audit_column => 'DIEMTH, DIEMQT, DIEMCK, DIEMTK',
    audit_condition => 'SYS_CONTEXT(''check_vaitro'',''vaitro'') != ''GIANG VIEN'''
);
END;

SELECT AUDIT_TYPE,DBUSERNAME,ACTION_NAME,OBJECT_NAME,EVENT_TIMESTAMP_UTC FROM UNIFIED_AUDIT_TRAIL  WHERE FGA_POLICY_NAME = 'UPDATE_DANGKY';

----b. hanh vi cua nguoi dung nay co the doc tren truong PHUCAP cua nguoi khac o quan he NHANSU
BEGIN
    DBMS_FGA.ADD_POLICY (
        OBJECT_SCHEMA => 'QL_TRUONGHOC_X',
        OBJECT_NAME => 'NHANSU',
        POLICY_NAME => 'SELECT_PHUCAP',
        AUDIT_COLUMN => 'PHUCAP',
        AUDIT_CONDITION => 'USER != OWNER'
    );
END;
/

SELECT AUDIT_TYPE,DBUSERNAME,ACTION_NAME,OBJECT_NAME,EVENT_TIMESTAMP_UTC FROM UNIFIED_AUDIT_TRAIL  WHERE FGA_POLICY_NAME = 'SELECT_PHUCAP';

