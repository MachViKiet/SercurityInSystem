-- Connect with LBACSYS account

ALTER SESSION SET CURRENT_SCHEMA = QL_TRUONGHOC_X;

CL SCR;
SHOW CON_NAME;
SELECT SYS_CONTEXT('USERENV', 'CURRENT_SCHEMA') AS CURRENT_SCHEMA FROM DUAL;


--BEGIN
--sa_sysdba.drop_policy
--(policy_name => 'policy_ThongBao',
--drop_column => true);
--END;
--/

--BEGIN
--sa_components.drop_group
--(policy_name => 'policy_ThongBao',
--short_name => 'CS2');
--END;

BEGIN
 SA_SYSDBA.CREATE_POLICY(
 policy_name => 'policy_ThongBao',
 column_name => 'label_ThongBao'
);
END;

GRANT policy_ThongBao_DBA TO ADMIN_OLS;
EXEC SA_SYSDBA.ENABLE_POLICY ('policy_ThongBao');

/* LABEL_TAG có ??nh d?ng 8 ch? s? 2 ch? s? ??u là LEVEL_NUM, 4 ch? s? ti?p theo là SUM(COMP_NUM), 2 ch? s? cu?i là MAX_OF'GROUP_NUM'

VD: Nhan cao nhat la: TK:HTTT,CNPM,KHMT,CNTT,TGMT,MMT:TH_X LABEL_TAG = 60210090
*/
-- a)Hay gan nhan cho nguoi dung la Truong khoa co the doc duoc toan bo thong bao
BEGIN
SA_LABEL_ADMIN.CREATE_LABEL(
    POLICY_NAME  => 'policy_ThongBao',
    LABEL_TAG  => '60210090',
    LABEL_VALUE  => 'TK:HTTT,CNPM,KHMT,CNTT,TGMT,MMT:TH_X',
    DATA_LABEL  => TRUE
);
END;
BEGIN
    SA_USER_ADMIN.SET_USER_LABELS(
        POLICY_NAME  => 'policy_ThongBao',
        USER_NAME  => 'ADMIN_OLS',
        MAX_READ_LABEL  => 'TK:HTTT,CNPM,KHMT,CNTT,TGMT,MMT:TH_X'
    );
END;
/
BEGIN
    SA_POLICY_ADMIN.APPLY_TABLE_POLICY(
        POLICY_NAME  => 'policy_ThongBao',
        SCHEMA_NAME  => 'QL_TRUONGHOC_X',
        TABLE_NAME  => 'THONGBAO',
        TABLE_OPTIONS  => 'LABEL_DEFAULT,READ_CONTROL'
    );
END;
/

INSERT INTO THONGBAO
-- a)
    SELECT 10, 'A) Thong bao den Truong Khoa', CHAR_TO_LABEL('policy_ThongBao', 'TK:HTTT,CNPM,KHMT,CNTT,TGMT,MMT:TH_X') FROM DUAL;
BEGIN 
    SA_USER_ADMIN.SET_USER_LABELS(
    POLICY_NAME  => 'policy_ThongBao',
    USER_NAME  => 'NS001',
    MAX_READ_LABEL  => 'TK:HTTT,CNPM,KHMT,CNTT,TGMT,MMT:TH_X'
    ); 
END;
/
-- b) Hay gan nhan cho cac Truong bo mon phu trach Co so 2 co the doc duoc
--  toan bo thong bao danh cho truong bo mon khong phan biet vi tri dia ly. 
INSERT INTO THONGBAO
    SELECT 20, 'B) Thong bao den Truong Don Vi HTTT Co So 1', CHAR_TO_LABEL('policy_ThongBao', 'TDV:HTTT:CS1') FROM DUAL UNION ALL
    SELECT 21, 'B1) Thong bao den Truong Don Vi HTTT Co So 2', CHAR_TO_LABEL('policy_ThongBao', 'TDV:HTTT:CS2') FROM DUAL UNION ALL
    SELECT 22, 'B2) Thong bao den Truong Don Vi HTTT', CHAR_TO_LABEL('policy_ThongBao', 'TDV:HTTT') FROM DUAL UNION ALL
    SELECT 23, 'B3) Thong bao den Truong Don Vi KHMT Co So 1', CHAR_TO_LABEL('policy_ThongBao', 'TDV:KHMT:CS1') FROM DUAL;
    
EXECUTE SA_LABEL_ADMIN.CREATE_LABEL('policy_ThongBao', '50010090', 'TDV:HTTT:TH_X');
EXECUTE SA_LABEL_ADMIN.CREATE_LABEL('policy_ThongBao', '50020090', 'TDV:CNPM:TH_X');
EXECUTE SA_LABEL_ADMIN.CREATE_LABEL('policy_ThongBao', '50030090', 'TDV:KHMT:TH_X');
EXECUTE SA_LABEL_ADMIN.CREATE_LABEL('policy_ThongBao', '50040090', 'TDV:CNTT:TH_X');
EXECUTE SA_LABEL_ADMIN.CREATE_LABEL('policy_ThongBao', '50050090', 'TDV:TGMT:TH_X');
EXECUTE SA_LABEL_ADMIN.CREATE_LABEL('policy_ThongBao', '50060090', 'TDV:MMT:TH_X');

EXECUTE SA_LABEL_ADMIN.CREATE_LABEL('policy_ThongBao', '50010070', 'TDV:HTTT:CS1');
EXECUTE SA_LABEL_ADMIN.CREATE_LABEL('policy_ThongBao', '50010080', 'TDV:HTTT:CS2');
EXECUTE SA_LABEL_ADMIN.CREATE_LABEL('policy_ThongBao', '50010000', 'TDV:HTTT');
EXECUTE SA_LABEL_ADMIN.CREATE_LABEL('policy_ThongBao', '50030070', 'TD:KHMT:CS1');

DECLARE 
    CUR SYS_REFCURSOR; 
    USR char(5); 
    DV char(5); 
BEGIN
    OPEN CUR FOR SELECT MANV, MADV FROM NHANSU WHERE VAITRO = 'Truong don vi' AND MACS = 2;
    LOOP 
        FETCH CUR INTO USR, DV;
        EXIT WHEN CUR%NOTFOUND;
        DV := TRIM(DV);
        SA_USER_ADMIN.SET_USER_LABELS(
            POLICY_NAME  => 'policy_ThongBao',
            USER_NAME    => USR,
            MAX_READ_LABEL  => 'TDV:' || DV || ':TH_X'
        );
    END LOOP; 
    CLOSE CUR;
END;
/
-- c)Hay gan nhan cho 01 Giao vu co the doc toan bo thong bao danh cho giao vu. -- NS0100
INSERT INTO THONGBAO
    SELECT 30, 'C) Thong bao den Giao Vu Co So 1', CHAR_TO_LABEL('policy_ThongBao', 'GV::CS1') FROM DUAL UNION ALL
    SELECT 31, 'C1) Thong bao den Giao Vu CNPM Co So 1, 2', CHAR_TO_LABEL('policy_ThongBao', 'GV:CNPM:CS1,CS2') FROM DUAL UNION ALL
    SELECT 32, 'C2) Thong bao den Giao Vu CNTT, TGMT Co So 2', CHAR_TO_LABEL('policy_ThongBao', 'GV:CNTT,TGMT:CS2') FROM DUAL; 

EXECUTE SA_LABEL_ADMIN.CREATE_LABEL('policy_ThongBao', '30210090', 'GV:HTTT,CNPM,KHMT,CNTT,TGMT,MMT:TH_X');
EXECUTE SA_LABEL_ADMIN.CREATE_LABEL('policy_ThongBao', '30000070', 'GV::CS1');
EXECUTE SA_LABEL_ADMIN.CREATE_LABEL('policy_ThongBao', '30020080', 'GV:CNPM:CS1,CS2');
EXECUTE SA_LABEL_ADMIN.CREATE_LABEL('policy_ThongBao', '30090080', 'GV:CNTT,TGMT:CS2');

EXECUTE SA_USER_ADMIN.SET_USER_LABELS('policy_ThongBao', 'NS0100', 'GV:HTTT,CNPM,KHMT,CNTT,TGMT,MMT:TH_X');
/
-- d) Hay cho biet nhan cua dong thong bao t1 de t1 duoc phat tan (doc) boi tat ca Truong don vi. 
INSERT INTO THONGBAO
    SELECT 40, 'D) T1', CHAR_TO_LABEL('policy_ThongBao', 'TDV') FROM DUAL;

EXECUTE SA_LABEL_ADMIN.CREATE_LABEL('policy_ThongBao', '50000000', 'TDV');

DECLARE 
    CUR SYS_REFCURSOR; 
    USR char(5); 
BEGIN
    OPEN CUR FOR SELECT MANV FROM NHANSU WHERE VAITRO = 'Truong don vi';
    LOOP 
        FETCH CUR INTO USR;
        EXIT WHEN CUR%NOTFOUND;
        SA_USER_ADMIN.SET_USER_LABELS(
            POLICY_NAME  => 'policy_ThongBao',
            USER_NAME    => USR,
            MAX_READ_LABEL  => 'TDV'
        );
    END LOOP; 
    CLOSE CUR;
END;
/
-- e) Hay cho biet nhan cua dong thong bao t2 de phat tan t2 den Sinh vien thuoc nganh HTTT hoc o Co so 1. 
INSERT INTO THONGBAO
    SELECT 50, 'E) T2', CHAR_TO_LABEL('policy_ThongBao', 'SV:HTTT:CS1') FROM DUAL;

EXECUTE SA_LABEL_ADMIN.CREATE_LABEL('policy_ThongBao', '10010070', 'SV:HTTT:CS1');
DECLARE 
    CUR SYS_REFCURSOR; 
    USR VARCHAR2(6);
BEGIN
    OPEN CUR FOR 
        SELECT MASV 
        FROM SINHVIEN 
        WHERE MANGANH = 'HTTT' AND MACS = 1;

    LOOP 
        FETCH CUR INTO USR;
        EXIT WHEN CUR%NOTFOUND;
        SA_USER_ADMIN.SET_USER_LABELS(
            POLICY_NAME  => 'POL_A01_THONGBAO',
            USER_NAME    => USR,
            MAX_READ_LABEL  => 'S:HTTT:CS1'
        );
    END LOOP; 

    CLOSE CUR;
END;
/

commit
select*from THONGBAO;
/* Cac user dung de test
a) CREATE USER NS001 IDENTIFIED BY 123; -- Truong khoa
b),d)CREATE USER NS002 IDENTIFIED BY 123; --TDV HTTT CS1
CREATE USER NS004 IDENTIFIED BY 123; --TDV KHMT CS1
CREATE USER NS008 IDENTIFIED BY 123; --TDV HTTT CS2
c)CREATE USER NS100 IDENTIFIED BY 123; --Giao Vu 
GRANT CONNECT TO NS001, NS002, NS004, NS008, NS100;
GRANT CREATE SESSION TO NS001, NS002, NS004, NS008, NS100;
GRANT SELECT ON THONGBAO TO NS001, NS002, NS004, NS008, NS100;
select*from QL_TRUONGHOC_X.THONGBAO;
*/