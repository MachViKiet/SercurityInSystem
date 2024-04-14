--CS#1
--Xem dong du lieu cua ch�nh m�nh 
--Drop View QL_TRUONGHOC_X.V_PERSONAL_INF_NHANSU;
CREATE OR REPLACE VIEW QL_TRUONGHOC_X.V_PERSONAL_INF_NHANSU AS
    SELECT * FROM QL_TRUONGHOC_X.NHANSU WHERE 'X_' || MANV = SYS_CONTEXT('USERENV', 'SESSION_USER');
GRANT SELECT ON QL_TRUONGHOC_X.V_PERSONAL_INF_NHANSU TO RL_TRUONGHOC_NHANVIENCOBAN;

CREATE OR REPLACE VIEW QL_TRUONGHOC_X.KHMO_CHITIET AS
    SELECT khmo.MAHP, hocphan.tenhp, hocphan.sotc , khmo.hk, khmo.nam, hocphan.madv, khmo.mact  FROM QL_TRUONGHOC_X.KHMO INNER JOIN QL_TRUONGHOC_X.HOCPHAN ON QL_TRUONGHOC_X.HOCPHAN.mahp = QL_TRUONGHOC_X.KHMO.mahp;
GRANT SELECT ON QL_TRUONGHOC_X.KHMO_CHITIET TO RL_TRUONGHOC_NHANVIENCOBAN;

CREATE OR REPLACE VIEW QL_TRUONGHOC_X.DONVI_CHITIET AS
    SELECT donvi.madv, donvi.tendv, nhansu.hoten as HOTENTRUONGDONVI ,donvi.truongdonvi as MATRUONGDONVI  FROM QL_TRUONGHOC_X.DONVI LEFT JOIN QL_TRUONGHOC_X.NHANSU  ON QL_TRUONGHOC_X.DONVI.TRUONGDONVI = QL_TRUONGHOC_X.NHANSU.MANV;
GRANT SELECT ON QL_TRUONGHOC_X.DONVI_CHITIET TO RL_TRUONGHOC_NHANVIENCOBAN;


/
--select * from QL_TRUONGHOC_X.NHANSU where vaitro = 'Nhan vien co ban';
--SELECT * FROM DBA_ROLE_PRIVS where GRANTED_ROLE like 'RL_TRUONGHOC_NHANVIENCOBAN'
--SELECT * FROM DBA_ROLE_PRIVS where GRANTEE like 'X_NS010';
--SELECT * FROM ROLE_TAB_PRIVS where ROLE like 'RL_TRUONGHOC_NHANVIENCOBAN';
--SELECT * FROM ROLE_TAB_PRIVS where table_name like 'NHANSU_MY_INFO';

--Xem thong tin cua tat ca SINHVIEN,DONVI, HOCPHAN, KHMO.
GRANT SELECT ON SINHVIEN TO RL_TRUONGHOC_NHANVIENCOBAN;
GRANT SELECT ON DONVI TO RL_TRUONGHOC_NHANVIENCOBAN;
GRANT SELECT ON HOCPHAN TO RL_TRUONGHOC_NHANVIENCOBAN;
GRANT SELECT ON KHMO TO RL_TRUONGHOC_NHANVIENCOBAN;

/
--Chinh sua so dien thoai cua chinh minh 
--DROP PROCEDURE UPDATE_PHONE;
SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE QL_TRUONGHOC_X.UPDATE_PHONE(
    P_NEW_PHONE IN VARCHAR2  -- So dien thoai moi
)
AS
    V_CURRENT_USER varchar2(10);
    V_MANV varchar2(12);
BEGIN
    V_CURRENT_USER := SYS_CONTEXT('USERENV', 'SESSION_USER');
    SELECT MANV INTO V_MANV FROM QL_TRUONGHOC_X.NHANSU WHERE 'X_' || MANV = V_CURRENT_USER;
    IF V_MANV IS NOT NULL THEN
        UPDATE QL_TRUONGHOC_X.NHANSU SET DT = P_NEW_PHONE WHERE MANV = V_MANV;
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Cap nhat so dien thoai thanh cong.');
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20002, 'Nhan vien khong ton tai trong he thong.' || V_CURRENT_USER);
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20003, 'Da xay ra loi khi cap nhat so dien thoai...' || V_CURRENT_USER);
END;
/
GRANT EXECUTE ON QL_TRUONGHOC_X.UPDATE_PHONE TO RL_TRUONGHOC_NHANVIENCOBAN;
--TEST CS#1 
--SELECT * FROM QL_TRUONGHOC_X.NHANSU_MY_INFO;

--SELECT * FROM QL_TRUONGHOC_X.SINHVIEN;
--SELECT * FROM QL_TRUONGHOC_X.DONVI;
--SELECT * FROM QL_TRUONGHOC_X.HOCPHAN;
--SELECT * FROM QL_TRUONGHOC_X.KHMO;

--BEGIN
--    QL_TRUONGHOC_X.UPDATE_PHONE('123456789');
--END;
--/

--CS#2
--Giang vien co vai tro nhu mot Nhan vien co ban
GRANT RL_TRUONGHOC_NHANVIENCOBAN TO RL_TRUONGHOC_GIANGVIEN;

--Xem du lieu phan cong day lien quan den ban than
-- DROP VIEW PHANCONG_MY_INFO;
CREATE OR REPLACE VIEW QL_TRUONGHOC_X.PHANCONG_MY_INFO AS
    SELECT hp.mahp , hp.tenhp, hp.sotc, hp.stlt, hp.stth, hp.sosvtd, pc.mact, pc.hk, pc.nam FROM QL_TRUONGHOC_X.PHANCONG pc JOIN QL_TRUONGHOC_X.HOCPHAN hp ON pc.MAHP = hp.MAHP
    WHERE 'X_' || MAGV = USER;
    
-- select * FROM QL_TRUONGHOC_X.PHANCONG pc JOIN QL_TRUONGHOC_X.HOCPHAN hp ON pc.MAHP = hp.MAHP
GRANT SELECT ON QL_TRUONGHOC_X.PHANCONG_MY_INFO TO RL_TRUONGHOC_GIANGVIEN;

--Xem du lieu tren quan he DANGKY lien quan den cac lop hoc phan ma giang vien duoc phan cong day
--DROP VIEW DK_MY_CLASSES;
CREATE VIEW QL_TRUONGHOC_X.DK_MY_CLASSES AS
    SELECT * FROM DANGKY WHERE MAHP IN (SELECT MAHP FROM QL_TRUONGHOC_X.PHANCONG_MY_INFO) AND 'X_' || MAGV = USER ;
    
GRANT SELECT ON QL_TRUONGHOC_X.DK_MY_CLASSES TO RL_TRUONGHOC_GIANGVIEN;

--Cap nhat du lieu diem cua cac sinh vien co tham gia lop hoc phan ma giang vien do duoc phan cong giang day
--DROP PROCEDURE UPDATE_GRADES;
select * from DANGKY
CREATE OR REPLACE PROCEDURE QL_TRUONGHOC_X.UPDATE_GRADES (
    P_NEW_DIEMTH IN NUMBER,    
    P_NEW_DIEMQT IN NUMBER,    
    P_NEW_DIEMCK IN NUMBER,    
    P_NEW_DIEMTK IN NUMBER,    
    P_MAHP IN CHAR,          
    P_MASV IN CHAR,       
    P_HK IN NUMBER,    
    P_NAM IN NUMBER,         
    P_CT IN VARCHAR2          
)
AS
    V_MAGV CHAR(10);
BEGIN
    V_MAGV := SYS_CONTEXT('USERENV', 'SESSION_USER');
    UPDATE DANGKY
    SET DIEMTH = P_NEW_DIEMTH,
        DIEMQT = P_NEW_DIEMQT,
        DIEMCK = P_NEW_DIEMCK,
        DIEMTK = P_NEW_DIEMTK
    WHERE MAHP = P_MAHP
    AND 'X_' || MAGV = V_MAGV
    AND MASV = P_MASV
    AND HK = P_HK
    AND NAM = P_NAM
    AND MACT = P_CT;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Cap nhat diem so thanh cong.');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20001, 'Khong tom thay du lieu giang vien.');
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20002, 'Da xay ra loi khi cap nhat diem so.');
END;
/
GRANT EXECUTE ON QL_TRUONGHOC_X.UPDATE_GRADES TO RL_TRUONGHOC_GIANGVIEN;
--TEST CS#2
--SELECT * FROM QL_TRUONGHOC_X.NHANSU_MY_INFO;
--SELECT * FROM QL_TRUONGHOC_X.PHANCONG_MY_INFO;
--SELECT * FROM QL_TRUONGHOC_X.DK_MY_CLASSES;
--BEGIN
--    QL_TRUONGHOC_X.UPDATE_GRADES(7.5, 8.0, 9.0, 8.5, 'HP001', 'SV210001', '2', '2022', 'CTTT');
--END;