CREATE OR REPLACE VIEW QL_TRUONGHOC_X.V_THONGTIN_DANGKYHOCPHAN AS
    select khmo.mahp, hp.tenhp, khmo.hk, khmo.nam, khmo.mact from QL_TRUONGHOC_X.KHMO khmo INNER JOIN QL_TRUONGHOC_X.HOCPHAN hp  ON khmo.mahp = hp.mahp; 

CREATE OR REPLACE VIEW QL_TRUONGHOC_X.V_THONGTIN_HOCPHAN_DANGMO AS
    select khmo.mahp, hp.tenhp, khmo.hk, khmo.nam, khmo.mact from QL_TRUONGHOC_X.KHMO khmo INNER JOIN QL_TRUONGHOC_X.HOCPHAN hp  ON khmo.mahp = hp.mahp; 
 
CREATE OR REPLACE VIEW QL_TRUONGHOC_X.V_THONGTIN_PHANCONGGIANGDAY AS
    select pc.mahp, hp.tenhp,ns.manv, ns.hoten as GV_PHU_TRACH, pc.hk, pc.nam, pc.mact, hp.madv
    from QL_TRUONGHOC_X.PHANCONG pc 
    INNER JOIN QL_TRUONGHOC_X.HOCPHAN hp  ON pc.mahp = hp.mahp
    INNER JOIN QL_TRUONGHOC_X.NHANSU ns  ON pc.magv = ns.manv; 
/


CREATE OR REPLACE PROCEDURE QL_TRUONGHOC_X.UPDATE_PHANCONGGIANGDAY_GIAOVU(
    P_OLD_MAGV IN VARCHAR2, P_OLD_MAHP IN VARCHAR2, P_OLD_HK IN NUMBER, P_OLD_NAM IN NUMBER, P_OLD_CT IN VARCHAR2,
    P_NEW_MAGV IN VARCHAR2
)
AS
    V_CURRENT_USER varchar2(10);
    V_MANV varchar2(12);
    v_Count NUMBER;
BEGIN
    V_CURRENT_USER := SYS_CONTEXT('USERENV', 'SESSION_USER');
    
    SELECT MANV INTO V_MANV FROM QL_TRUONGHOC_X.NHANSU WHERE 'X_' || MANV = V_CURRENT_USER;
    
    v_Count := 0;

    -- Ki?m tra xem MANV c� t?n t?i trong b?ng A.MANV kh�ng
    SELECT COUNT(*)
    INTO v_Count
    FROM QL_TRUONGHOC_X.HOCPHAN
    WHERE madv like 'VPK%' and mahp = P_OLD_MAHP;
    
    IF v_Count = 0 THEN
         RAISE_APPLICATION_ERROR(-20002, 'H?c Ph?n Kh�ng Thu?c Ph? Tr�ch c?a V?n Ph�ng Khoa');
         return ;
    END IF;
    
    IF V_MANV IS NOT NULL THEN
        UPDATE QL_TRUONGHOC_X.PHANCONG 
        SET 
            MAGV = P_NEW_MAGV
        WHERE 
            MAGV = P_OLD_MAGV and
            MAHP = P_OLD_MAHP and
            HK = P_OLD_HK and
            NAM = P_OLD_NAM and
            MACT = P_OLD_CT and
            P_OLD_MAHP in ( select MAHP from QL_TRUONGHOC_X.HOCPHAN where madv like 'VPK%');
        COMMIT;

    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20002, 'Nhan vien khong ton tai trong he thong.' || V_CURRENT_USER);
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20001, 'Error occurred: ' || SQLERRM);
END;
/

CREATE OR REPLACE PROCEDURE QL_TRUONGHOC_X.DELETE_PHANCONG_GIAOVU(
    P_OLD_MAGV IN VARCHAR2, P_OLD_MAHP IN VARCHAR2, P_OLD_HK IN NUMBER, P_OLD_NAM IN NUMBER, P_OLD_CT IN VARCHAR2 
)
AS
    V_USER CHAR(10);
    V_MAHP CHAR(10);
BEGIN
    V_USER := SYS_CONTEXT('USERENV', 'SESSION_USER');
    SELECT mahp INTO V_MAHP
    FROM QL_TRUONGHOC_X.HOCPHAN WHERE madv = 'VPK01' and mahp = P_OLD_MAHP ;
    IF V_MAHP IS NOT NULL THEN
        DELETE FROM QL_TRUONGHOC_X.PHANCONG
        WHERE MAGV = P_OLD_MAGV and
            MAHP = P_OLD_MAHP and
            HK = P_OLD_HK and
            NAM = P_OLD_NAM and
            MACT = P_OLD_CT;
    else 
        RAISE_APPLICATION_ERROR(-20001, 'H?c Ph?n khong thuoc quyen quan ly cua van phong khoa');
    END IF;
    

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Cap nhat phan cong thanh cong.');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20001, 'Khong tom thay du lieu phan cong.');
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20001, 'Error occurred: ' || SQLERRM);
END;
/


CREATE OR REPLACE PROCEDURE QL_TRUONGHOC_X.ADD_PHANCONG_GIAOVU(
    P_MAGV IN CHAR,          
    P_MAHP IN CHAR,       
    P_HK IN NUMBER,    
    P_NAM IN NUMBER,         
    P_CT IN VARCHAR2          
)
AS
    V_USER CHAR(10);
    V_MAHP CHAR(10);
BEGIN
    V_USER := SYS_CONTEXT('USERENV', 'SESSION_USER');
    SELECT mahp INTO V_MAHP
    FROM QL_TRUONGHOC_X.HOCPHAN WHERE madv = 'VPK01' and mahp = P_MAHP ;
    IF V_MAHP IS NOT NULL THEN
        insert into QL_TRUONGHOC_X.PHANCONG ( MAGV, MAHP, HK, NAM, MACT )
        values( P_MAGV, P_MAHP, P_HK, P_NAM, P_CT );
        COMMIT;
    else 
        RAISE_APPLICATION_ERROR(-20001, 'H?c Ph?n khong thuoc quyen quan ly cua van phong khoa.');
    END IF;

    DBMS_OUTPUT.PUT_LINE('Cap nhat phan cong thanh cong.');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20001, 'Data not found: ' || SQLERRM);
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20001, 'Error occurred: ' || SQLERRM);
END;
/


CREATE OR REPLACE PROCEDURE QL_TRUONGHOC_X.DANGKY_MONHOC(
    P_MASV IN CHAR,
    P_MAGV IN CHAR,          
    P_MAHP IN CHAR,       
    P_HK IN NUMBER,    
    P_NAM IN NUMBER,         
    P_CT IN VARCHAR2
)
AS
    V_USER CHAR(10);
BEGIN
    V_USER := SYS_CONTEXT('USERENV', 'SESSION_USER');

    insert into QL_TRUONGHOC_X.DANGKY ( MASV, MAGV, MAHP, HK, NAM, MACT, DIEMTH, DIEMQT, DIEMCK, DIEMTK )
        values( P_MASV, P_MAGV, P_MAHP, P_HK, P_NAM, P_CT, 0,0,0,0 );
    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Cap nhat dang ky thanh cong.');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20001, 'Data not found: ' || SQLERRM);
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20001, 'Error occurred: ' || SQLERRM);
END;
/


CREATE OR REPLACE PROCEDURE QL_TRUONGHOC_X.HUY_DANGKY_MONHOC(
    P_MASV IN CHAR,
    P_MAGV IN CHAR,          
    P_MAHP IN CHAR,       
    P_HK IN NUMBER,    
    P_NAM IN NUMBER,         
    P_CT IN VARCHAR2
)
AS
    V_USER CHAR(10);
    V_MAHP CHAR(10);
BEGIN
    V_USER := SYS_CONTEXT('USERENV', 'SESSION_USER');

    DELETE FROM QL_TRUONGHOC_X.DANGKY
    WHERE  MASV = P_MASV and
           MAGV = P_MAGV and
           MAHP = P_MAHP and
           HK = P_HK and
           NAM = P_NAM and
           MACT = P_CT;
    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Cap nhat dang ky thanh cong.');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20001, 'Data not found: ' || SQLERRM);
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20001, 'Error occurred: ' || SQLERRM);
END;
/




GRANT SELECT, INSERT, UPDATE ON SINHVIEN TO RL_TRUONGHOC_GIAOVU;
GRANT SELECT ON PHANCONG TO RL_TRUONGHOC_GIAOVU;
GRANT SELECT, INSERT, UPDATE ON DONVI TO RL_TRUONGHOC_GIAOVU;
GRANT SELECT, INSERT, UPDATE ON HOCPHAN TO RL_TRUONGHOC_GIAOVU;
GRANT SELECT, INSERT, UPDATE ON KHMO TO RL_TRUONGHOC_GIAOVU;
GRANT SELECT, INSERT, UPDATE ON DANGKY TO RL_TRUONGHOC_GIAOVU;

GRANT SELECT ON QL_TRUONGHOC_X.V_THONGTIN_DANGKYHOCPHAN TO RL_TRUONGHOC_GIAOVU;
GRANT SELECT ON QL_TRUONGHOC_X.V_THONGTIN_PHANCONGGIANGDAY TO RL_TRUONGHOC_GIAOVU;

GRANT SELECT ON QL_TRUONGHOC_X.V_PERSONAL_INF_NHANSU TO RL_TRUONGHOC_GIAOVU;
GRANT EXECUTE ON QL_TRUONGHOC_X.UPDATE_PHANCONGGIANGDAY_GIAOVU TO RL_TRUONGHOC_GIAOVU;
GRANT EXECUTE ON QL_TRUONGHOC_X.DELETE_PHANCONG_GIAOVU TO RL_TRUONGHOC_GIAOVU;
GRANT EXECUTE ON QL_TRUONGHOC_X.ADD_PHANCONG_GIAOVU TO RL_TRUONGHOC_GIAOVU;
GRANT EXECUTE ON QL_TRUONGHOC_X.HUY_DANGKY_MONHOC TO RL_TRUONGHOC_GIAOVU;
GRANT EXECUTE ON QL_TRUONGHOC_X.DANGKY_MONHOC TO RL_TRUONGHOC_GIAOVU;




-- 


CREATE OR REPLACE PROCEDURE QL_TRUONGHOC_X.THEM_DONVI(
    MADV IN CHAR,
    TENDONVI IN VARCHAR2
)
AS
BEGIN
    insert into QL_TRUONGHOC_X.DONVI ( MADV, TENDV, TRUONGDONVI )
        values( MADV, TENDONVI, null );
    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Cap nhat dang ky thanh cong.');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20001, 'Data not found: ' || SQLERRM);
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20001, 'Error occurred: ' || SQLERRM);
END;
/

CREATE OR REPLACE PROCEDURE QL_TRUONGHOC_X.CAPNHAT_DONVI(
    MADONVI IN CHAR,
    TENDONVI IN VARCHAR2
)
AS
BEGIN
    UPDATE QL_TRUONGHOC_X.DONVI 
    SET TENDV = TENDONVI
    WHERE MADV = MADONVI;
    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Cap nhat don vi thanh cong.');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20001, 'Data not found: ' || SQLERRM);
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20001, 'Error occurred: ' || SQLERRM);
END;
/


-------


CREATE OR REPLACE PROCEDURE QL_TRUONGHOC_X.THEM_SINHVIEN(
    MASV varchar2,
    HOTEN varchar2,
    PHAI char,  -- Y or N
    NGAYSINH date,
    DIACHI varchar2,
    DT char,
    MACT char,
    MANGANH char
)
AS
BEGIN
    insert into QL_TRUONGHOC_X.SINHVIEN ( MASV, HOTEN, PHAI, NGAYSINH, DIACHI, DT, MACT, MANGANH, SOTCTL, DTBTL )
        values( MASV, HOTEN, PHAI, NGAYSINH, DIACHI, DT, MACT, MANGANH, 0,0 );
    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Cap nhat sinh vien thanh cong.');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20001, 'Data not found: ' || SQLERRM);
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20001, 'Error occurred: ' || SQLERRM);
END;
/

CREATE OR REPLACE PROCEDURE QL_TRUONGHOC_X.CAPNHAT_SINHVIEN(
    I_MASV varchar2,
    I_HOTEN varchar2,
    I_PHAI char,  -- Y or N
    I_NGAYSINH date,
    I_DIACHI varchar2,
    I_DT char,
    I_MACT char,
    I_MANGANH char
)
AS
    CONDITION VARCHAR2(300);
BEGIN
    UPDATE QL_TRUONGHOC_X.SINHVIEN 
    SET  HOTEN = I_HOTEN ,
        PHAI = I_PHAI,
        NGAYSINH = I_NGAYSINH,
        DIACHI = I_DIACHI,
        DT = I_DT,
        MACT = I_MACT,
        MANGANH = I_MANGANH    
    where MASV = I_MASV;

    DBMS_OUTPUT.PUT_LINE('Cap nhat sinh vien thanh cong.');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20001, 'Data not found: ' || SQLERRM);
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20001, 'Error occurred: ' || SQLERRM);
END;
/


-------


CREATE OR REPLACE PROCEDURE QL_TRUONGHOC_X.THEM_HOCPHAN(
    MAHP char,
    TENHP varchar,
    SOTC number,
    STLT number,
    STTH number,
    SOSVTD number,
    MADV char
)
AS
BEGIN
    insert into QL_TRUONGHOC_X.HOCPHAN ( MAHP, TENHP, SOTC, STLT, STTH, SOSVTD, MADV )
        values( MAHP, TENHP, SOTC, STLT, STTH, SOSVTD, MADV );
    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Cap nhat hoc phan thanh cong.');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20001, 'Data not found: ' || SQLERRM);
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20001, 'Error occurred: ' || SQLERRM);
END;
/

CREATE OR REPLACE PROCEDURE QL_TRUONGHOC_X.CAPNHAT_HOCPHAN(
    MAHP char,
    TENHP varchar,
    SOTC number,
    STLT number,
    STTH number,
    SOSVTD number,
    MADV char
)
AS
    CONDITION VARCHAR2(300);
BEGIN
    UPDATE QL_TRUONGHOC_X.HOCPHAN 
    SET  TENHP = TENHP,
        SOTC = SOTC,
        STLT = STLT,
        STTH = STTH,
        SOSVTD = SOSVTD,
        MADV = MADV    
    where MAHP = MAHP;

    DBMS_OUTPUT.PUT_LINE('Cap nhat hocphan thanh cong.');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20001, 'Data not found: ' || SQLERRM);
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20001, 'Error occurred: ' || SQLERRM);
END;
/



-------


CREATE OR REPLACE PROCEDURE QL_TRUONGHOC_X.THEM_KHMO(
    MAHP char,
    HK number,
    NAM varchar,
    MACT varchar -- CQ, CLC, CTTT, VP
)
AS
BEGIN
    insert into QL_TRUONGHOC_X.KHMO ( MAHP, HK, NAM, MACT )
        values( MAHP, HK, NAM, MACT );
    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Cap nhat khmo thanh cong.');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20001, 'Data not found: ' || SQLERRM);
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20001, 'Error occurred: ' || SQLERRM);
END;
/

CREATE OR REPLACE PROCEDURE QL_TRUONGHOC_X.CAPNHAT_KHMO(
    MAHP char,
    HK number,
    NAM varchar,
    MACT varchar -- CQ, CLC, CTTT, VP
)
AS
    CONDITION VARCHAR2(300);
BEGIN
    UPDATE QL_TRUONGHOC_X.KHMO 
    SET  HK = HK,
        NAM = NAM,
        MACT = MACT 
    where MAHP = MAHP;

    DBMS_OUTPUT.PUT_LINE('Cap nhat hocphan thanh cong.');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20001, 'Data not found: ' || SQLERRM);
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20001, 'Error occurred: ' || SQLERRM);
END;
/


GRANT EXECUTE ON QL_TRUONGHOC_X.CAPNHAT_DONVI TO RL_TRUONGHOC_GIAOVU;
GRANT EXECUTE ON QL_TRUONGHOC_X.THEM_DONVI TO RL_TRUONGHOC_GIAOVU;
GRANT EXECUTE ON QL_TRUONGHOC_X.CAPNHAT_SINHVIEN TO RL_TRUONGHOC_GIAOVU;
GRANT EXECUTE ON QL_TRUONGHOC_X.THEM_SINHVIEN TO RL_TRUONGHOC_GIAOVU;
GRANT EXECUTE ON QL_TRUONGHOC_X.CAPNHAT_HOCPHAN TO RL_TRUONGHOC_GIAOVU;
GRANT EXECUTE ON QL_TRUONGHOC_X.THEM_HOCPHAN TO RL_TRUONGHOC_GIAOVU;
GRANT EXECUTE ON QL_TRUONGHOC_X.CAPNHAT_KHMO TO RL_TRUONGHOC_GIAOVU;
GRANT EXECUTE ON QL_TRUONGHOC_X.THEM_KHMO TO RL_TRUONGHOC_GIAOVU;

