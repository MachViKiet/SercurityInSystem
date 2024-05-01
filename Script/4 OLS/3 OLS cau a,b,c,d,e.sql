ALTER SESSION SET CURRENT_SCHEMA = QL_TRUONGHOC_X;

CL SCR;
SHOW CON_NAME;
SELECT SYS_CONTEXT('USERENV', 'CURRENT_SCHEMA') AS CURRENT_SCHEMA FROM DUAL;


BEGIN
sa_sysdba.drop_policy
(policy_name => 'policy_ThongBao',
drop_column => true);
END;
/

EXEC SA_SYSDBA.CREATE_POLICY( policy_name => 'policy_ThongBao', column_name => 'label_ThongBao' );

GRANT policy_ThongBao_DBA TO QL_TRUONGHOC_X;
--ENABLE POLICY VUA TAO -> KHOI DONG LAI SQLDEV
EXEC SA_SYSDBA.ENABLE_POLICY ('policy_ThongBao');
--->TAO LEVEL
EXECUTE SA_COMPONENTS.CREATE_LEVEL('policy_ThongBao',10,'SV','SINH VIEN');
EXECUTE SA_COMPONENTS.CREATE_LEVEL('policy_ThongBao',20,'NV','NHAN VIEN');
EXECUTE SA_COMPONENTS.CREATE_LEVEL('policy_ThongBao',30,'GV','GIAO VU');
EXECUTE SA_COMPONENTS.CREATE_LEVEL('policy_ThongBao',40,'GGV','GIANG VIEN');
EXECUTE SA_COMPONENTS.CREATE_LEVEL('policy_ThongBao',50,'TDV','TRUONG DON VI');
EXECUTE SA_COMPONENTS.CREATE_LEVEL('policy_ThongBao',60,'TK','TRUONG KHOA');
EXECUTE SA_COMPONENTS.CREATE_LEVEL('policy_ThongBao',70,'QTV','QUAN TRI VIEN');
--->TAO COMPARTMENT
EXECUTE SA_COMPONENTS.CREATE_COMPARTMENT('policy_ThongBao', 100, 'HTTT1','HE THONG THONG TIN');
EXECUTE SA_COMPONENTS.CREATE_COMPARTMENT('policy_ThongBao', 200, 'CNPM1','CONG NGHE PHAN MEM');   
EXECUTE SA_COMPONENTS.CREATE_COMPARTMENT('policy_ThongBao', 300, 'KHMT1', 'KHOA HOC MAY TINH');
EXECUTE SA_COMPONENTS.CREATE_COMPARTMENT('policy_ThongBao', 400, 'CNTT1', 'CONG NGHE TRI THUC');
EXECUTE SA_COMPONENTS.CREATE_COMPARTMENT('policy_ThongBao', 500, 'TGMT1', 'THI GIAC MAY TINH');
EXECUTE SA_COMPONENTS.CREATE_COMPARTMENT('policy_ThongBao', 600, 'MMTVT', 'MANG MAY TINH VA VIEN THONG');
--->TAO GROUP
--BEGIN
--sa_components.drop_group
--(policy_name => 'policy_ThongBao',
--short_name => 'CS002');
--END;
EXECUTE SA_COMPONENTS.CREATE_GROUP('policy_ThongBao',90,'TH_X','TRUONG HOC X');
EXECUTE SA_COMPONENTS.CREATE_GROUP('policy_ThongBao',70,'CS001','CO SO 1','TH_X');
EXECUTE SA_COMPONENTS.CREATE_GROUP('policy_ThongBao',80,'CS002','CO SO 2','TH_X');

SELECT * FROM DBA_SA_LEVELS;
SELECT * FROM DBA_SA_COMPARTMENTS;
SELECT * FROM DBA_SA_GROUPS;
SELECT * FROM DBA_SA_GROUP_HIERARCHY;
SELECT * FROM ALL_SA_LABELS;
SELECT * FROM ALL_SA_USER_LABELS;

/* LABEL_TAG có ??nh d?ng 8 ch? s? 2 ch? s? ??u là LEVEL_NUM, 4 ch? s? ti?p theo là SUM(COMP_NUM), 2 ch? s? cu?i là MAX_OF'GROUP_NUM'

VD: Nhan cao nhat la: TK:HTTT,CNPM,KHMT,CNTT,TGMT,MMT:TH_X LABEL_TAG = 60210090
*/
-- a)Hay gan nhan cho nguoi dung la Truong khoa co the doc duoc toan bo thong bao


EXEC SA_LABEL_ADMIN.CREATE_LABEL( POLICY_NAME  => 'policy_ThongBao', LABEL_TAG  => '60210090', LABEL_VALUE  => 'TK:HTTT1,CNPM1,KHMT1,CNTT1,TGMT1,MMTVT:TH_X', DATA_LABEL  => TRUE);
EXEC SA_LABEL_ADMIN.CREATE_LABEL( POLICY_NAME  => 'policy_ThongBao', LABEL_TAG  => '50210090', LABEL_VALUE  => 'TDV:HTTT1,CNPM1,KHMT1,CNTT1,TGMT1,MMTVT:CS001', DATA_LABEL  => TRUE);
EXEC SA_LABEL_ADMIN.CREATE_LABEL( POLICY_NAME  => 'policy_ThongBao', LABEL_TAG  => '50210080', LABEL_VALUE  => 'TDV:HTTT1,CNPM1,KHMT1,CNTT1,TGMT1,MMTVT:CS002', DATA_LABEL  => TRUE);

EXEC SA_POLICY_ADMIN.APPLY_TABLE_POLICY( POLICY_NAME  => 'policy_ThongBao', SCHEMA_NAME  => 'QL_TRUONGHOC_X', TABLE_NAME  => 'THONGBAO', TABLE_OPTIONS  => 'LABEL_DEFAULT,READ_CONTROL');


select * from THONGBAO;

INSERT INTO THONGBAO (THONGBAO, LABEL_THONGBAO ) values ('A. Thong bao den Truong Khoa - TK:HTTT1,CNPM1,KHMT1,CNTT1,TGMT1,MMTVT:TH_X', CHAR_TO_LABEL('policy_ThongBao', 'TK:HTTT1,CNPM1,KHMT1,CNTT1,TGMT1,MMTVT:TH_X'));
INSERT INTO THONGBAO (THONGBAO, LABEL_THONGBAO ) values ('A. Thong bao den tat ca TDV co so 1 - TDV:HTTT1,CNPM1,KHMT1,CNTT1,TGMT1,MMTVT:CS001', CHAR_TO_LABEL('policy_ThongBao', 'TDV:HTTT1,CNPM1,KHMT1,CNTT1,TGMT1,MMTVT:CS001'));
INSERT INTO THONGBAO (THONGBAO, LABEL_THONGBAO ) values ('A. Thong bao den tat ca TDV co so 2 - TDV:HTTT1,CNPM1,KHMT1,CNTT1,TGMT1,MMTVT:CS002', CHAR_TO_LABEL('policy_ThongBao', 'TDV:HTTT1,CNPM1,KHMT1,CNTT1,TGMT1,MMTVT:CS002'));


EXEC SA_USER_ADMIN.SET_USER_LABELS( POLICY_NAME  => 'policy_ThongBao', USER_NAME  => 'QL_TRUONGHOC_X', MAX_READ_LABEL  => 'TK:HTTT1,CNPM1,KHMT1,CNTT1,TGMT1,MMTVT:TH_X');
EXEC SA_USER_ADMIN.SET_USER_LABELS( POLICY_NAME  => 'policy_ThongBao', USER_NAME  => 'X_NS001', MAX_READ_LABEL  => 'TK:HTTT1,CNPM1,KHMT1,CNTT1,TGMT1,MMTVT:TH_X' ); 

-- b) Hay gan nhan cho cac Truong bo mon phu trach Co so 2 co the doc duoc
--  toan bo thong bao danh cho truong bo mon khong phan biet vi tri dia ly. 
EXECUTE SA_LABEL_ADMIN.CREATE_LABEL('policy_ThongBao', '50010090', 'TDV:HTTT1:TH_X');
EXECUTE SA_LABEL_ADMIN.CREATE_LABEL('policy_ThongBao', '50020090', 'TDV:CNPM1:TH_X');
EXECUTE SA_LABEL_ADMIN.CREATE_LABEL('policy_ThongBao', '50030090', 'TDV:KHMT1:TH_X');
EXECUTE SA_LABEL_ADMIN.CREATE_LABEL('policy_ThongBao', '50040090', 'TDV:CNTT1:TH_X');
EXECUTE SA_LABEL_ADMIN.CREATE_LABEL('policy_ThongBao', '50050090', 'TDV:TGMT1:TH_X');
EXECUTE SA_LABEL_ADMIN.CREATE_LABEL('policy_ThongBao', '50060090', 'TDV:MMTVT:TH_X');

EXECUTE SA_LABEL_ADMIN.CREATE_LABEL('policy_ThongBao', '50010070', 'TDV:HTTT1:CS001');
EXECUTE SA_LABEL_ADMIN.CREATE_LABEL('policy_ThongBao', '50010080', 'TDV:HTTT1:CS002');
EXECUTE SA_LABEL_ADMIN.CREATE_LABEL('policy_ThongBao', '50010000', 'TDV:HTTT1');
EXECUTE SA_LABEL_ADMIN.CREATE_LABEL('policy_ThongBao', '50030070', 'TDV:KHMT1:CS001');

INSERT INTO THONGBAO ( thongbao, label_thongbao )
    SELECT 'B) Thong bao den Truong Don Vi HTTT Co So 1 - TDV:HTTT1:CS001', CHAR_TO_LABEL('policy_ThongBao', 'TDV:HTTT1:CS001') FROM DUAL UNION ALL
    SELECT 'B1) Thong bao den Truong Don Vi HTTT Co So 2 - TDV:HTTT:CS002', CHAR_TO_LABEL('policy_ThongBao', 'TDV:HTTT1:CS002') FROM DUAL UNION ALL
    SELECT 'B2) Thong bao den Truong Don Vi HTTT - TDV:HTTT1', CHAR_TO_LABEL('policy_ThongBao', 'TDV:HTTT1') FROM DUAL UNION ALL
    SELECT 'B3) Thong bao den Truong Don Vi HTTT - TDV:CNTT1:TH_X', CHAR_TO_LABEL('policy_ThongBao', 'TDV:CNTT1:TH_X') FROM DUAL UNION ALL
    SELECT 'B4) Thong bao den Truong Don Vi KHMT Co So 1 - TDV:KHMT:CS001', CHAR_TO_LABEL('policy_ThongBao', 'TDV:KHMT1:CS001') FROM DUAL;

DECLARE 
    CUR SYS_REFCURSOR; 
    USR char(5); 
    DV char(5); 
BEGIN
    OPEN CUR FOR SELECT MANV, MADV FROM NHANSU WHERE VAITRO = 'Truong don vi' and madv <> 'VPK01' and MACS = 'CS002';
    LOOP 
        FETCH CUR INTO USR, DV;
        EXIT WHEN CUR%NOTFOUND;
        DV := TRIM(DV);
        SA_USER_ADMIN.SET_USER_LABELS(
            POLICY_NAME  => 'policy_ThongBao',
            USER_NAME    => 'X_' || USR,
            MAX_READ_LABEL  => 'TDV:' || DV || ':TH_X'
        );
    END LOOP; 
    CLOSE CUR;
END;
/
-- c)Hay gan nhan cho 01 Giao vu co the doc toan bo thong bao danh cho giao vu. -- NS0100
INSERT INTO THONGBAO (thongbao, label_thongbao)
    SELECT  'C) Thong bao den Giao Vu Co So 1 - GV::CS001', CHAR_TO_LABEL('policy_ThongBao', 'GV::CS001') FROM DUAL UNION ALL
    SELECT  'C1) Thong bao den Giao Vu CNPM Co So 1, 2 - GV:CNPM1:CS001,CS002', CHAR_TO_LABEL('policy_ThongBao', 'GV:CNPM1:CS001,CS002') FROM DUAL UNION ALL
    SELECT  'C2) Thong bao den Giao Vu CNTT, TGMT Co So 2 - GV:CNTT1,TGMT1:CS002', CHAR_TO_LABEL('policy_ThongBao', 'GV:CNTT1,TGMT1:CS002') FROM DUAL; 

EXECUTE SA_LABEL_ADMIN.CREATE_LABEL('policy_ThongBao', '30210090', 'GV:HTTT1,CNPM1,KHMT1,CNTT1,TGMT1,MMTVT:TH_X');
EXECUTE SA_LABEL_ADMIN.CREATE_LABEL('policy_ThongBao', '30000070', 'GV::CS001');
EXECUTE SA_LABEL_ADMIN.CREATE_LABEL('policy_ThongBao', '30020080', 'GV:CNPM1:CS001,CS002');
EXECUTE SA_LABEL_ADMIN.CREATE_LABEL('policy_ThongBao', '30090080', 'GV:CNTT1,TGMT1:CS002');

EXECUTE SA_USER_ADMIN.SET_USER_LABELS('policy_ThongBao', 'X_NS101', 'GV:HTTT1,CNPM1,KHMT1,CNTT1,TGMT1,MMTVT:TH_X');
/
-- d) Hay cho biet nhan cua dong thong bao t1 de t1 duoc phat tan (doc) boi tat ca Truong don vi. 
INSERT INTO THONGBAO (thongbao, label_thongbao)
    SELECT 'D) T1 - TDV', CHAR_TO_LABEL('policy_ThongBao', 'TDV') FROM DUAL;

EXECUTE SA_LABEL_ADMIN.CREATE_LABEL('policy_ThongBao', '50000000', 'TDV');

-- e) Hay cho biet nhan cua dong thong bao t2 de phat tan t2 den Sinh vien thuoc nganh HTTT hoc o Co so 1. 
INSERT INTO THONGBAO (thongbao, label_thongbao)
    SELECT 'E) T2', CHAR_TO_LABEL('policy_ThongBao', 'SV:HTTT1:CS001') FROM DUAL;

EXECUTE SA_LABEL_ADMIN.CREATE_LABEL('policy_ThongBao', '10010070', 'SV:HTTT1:CS001');

DECLARE 
    CUR SYS_REFCURSOR; 
    USR VARCHAR2(10);
    COSO VARCHAR2(6);
    NGANH VARCHAR2(6);
BEGIN
    OPEN CUR FOR 
        SELECT MASV, MACS , MANGANH
        FROM SINHVIEN;

    LOOP 
        EXIT WHEN CUR%NOTFOUND;
        FETCH CUR INTO USR, COSO, NGANH;

        SA_USER_ADMIN.SET_USER_LABELS(
            POLICY_NAME  => 'policy_ThongBao',
            USER_NAME    => 'X_' || USR,
            MAX_READ_LABEL  => 'SV:'|| NGANH ||':' || COSO
        );
    END LOOP; 

    CLOSE CUR;
END;
/

commit;

-- f) Hay cho biet nhan cua dong thong bao t2 de phat tan t2 den Truong Don Vi thuoc nganh KHMT hoc o Co so 1. 

DECLARE 
    CUR SYS_REFCURSOR; 
    USR char(5); 
    DV char(5); 
BEGIN
    OPEN CUR FOR SELECT MANV, MADV FROM NHANSU WHERE VAITRO = 'Truong don vi' and madv <> 'VPK01' and MACS = 'CS001';
    LOOP 
        FETCH CUR INTO USR, DV;
        EXIT WHEN CUR%NOTFOUND;
        DV := TRIM(DV);
        SA_USER_ADMIN.SET_USER_LABELS(
            POLICY_NAME  => 'policy_ThongBao',
            USER_NAME    => 'X_' || USR,
            MAX_READ_LABEL  => 'TDV:' || DV || ':CS001'
        );
    END LOOP; 
    CLOSE CUR;
END;
/

EXECUTE SA_LABEL_ADMIN.CREATE_LABEL('policy_ThongBao', '50000020', 'TDV:KHMT1');
INSERT INTO THONGBAO (thongbao, label_thongbao)
    SELECT 'F) T3 - TDV:KHMT1', CHAR_TO_LABEL('policy_ThongBao', 'TDV:KHMT1') FROM DUAL;

-- f) Hay cho biet nhan cua dong thong bao t2 de phat tan t2 den Truong Don Vi thuoc nganh KHMT hoc o Co so 1 vaf Co So 2. 
EXECUTE SA_LABEL_ADMIN.CREATE_LABEL('policy_ThongBao', '50000001', 'TDV:KHMT1:CS001,CS002');
INSERT INTO THONGBAO (thongbao, label_thongbao)
    SELECT 'G) T4 - TDV:KHMT1:CS001,CS002', CHAR_TO_LABEL('policy_ThongBao', 'TDV:KHMT1:CS001,CS002') FROM DUAL;   

--select * from NHANSU;
-- e) 
-- Gan nhan cho giang vien NS038 co the xem duoc moi thong bao cua HTTT1, MTTVT va KHMT tai co so 2
EXECUTE SA_LABEL_ADMIN.CREATE_LABEL('policy_ThongBao', '40040001', 'GGV:HTTT1,MMTVT,KHMT1:CS002');
begin 
    SA_USER_ADMIN.SET_USER_LABELS(
            POLICY_NAME  => 'policy_ThongBao',
            USER_NAME    => 'X_NS038',
            MAX_READ_LABEL  => 'GGV:HTTT1,MMTVT,KHMT1:CS002'
        );
END;  

-- Nhan cho phep tat ca nguo dung o co so 2 trong he thong co the xem duoc. 
EXECUTE SA_LABEL_ADMIN.CREATE_LABEL('policy_ThongBao', '00000002', 'SV::CS002');
INSERT INTO THONGBAO (thongbao, label_thongbao)
    SELECT 'E) T5 - SV::CS002', CHAR_TO_LABEL('policy_ThongBao', 'SV::CS002') FROM DUAL;

-- Gan nhan cho phep giang vien NS017 - nhan vien co ban co the xem duoc thong bao cua giang vien bo mon KHMT
EXECUTE SA_LABEL_ADMIN.CREATE_LABEL('policy_ThongBao', '50000002', 'GGV:KHMT1');
begin 
    SA_USER_ADMIN.SET_USER_LABELS(
            POLICY_NAME  => 'policy_ThongBao',
            USER_NAME    => 'X_NS017',
            MAX_READ_LABEL  => 'GGV:KHMT1'
        );
END;
/* Cac user dung de test
select * from NHANSU
a) CREATE USER NS001 IDENTIFIED BY 123; -- Truong khoa
b),d)CREATE USER NS002 IDENTIFIED BY 123; --TDV HTTT CS001
CREATE USER NS004 IDENTIFIED BY 123; --TDV KHMT CS001
CREATE USER NS008 IDENTIFIED BY 123; --TDV HTTT CS002
c)CREATE USER NS100 IDENTIFIED BY 123; --Giao Vu 
GRANT CONNECT TO NS001, NS002, NS004, NS008, NS100;
GRANT CREATE SESSION TO NS001, NS002, NS004, NS008, NS100;
GRANT SELECT ON THONGBAO TO NS001, NS002, NS004, NS008, NS100;
select*from QL_TRUONGHOC_X.THONGBAO;
*/