
-- Tren quan he SINHVIEN, sinh vien chi duoc xem thong tin cua minh,
CREATE OR REPLACE FUNCTION GET_INF_BY_MASV_USERS(   -- Xong
    P_SCHEMA VARCHAR2, P_OBJ VARCHAR2
)
RETURN VARCHAR2
AS
    v_predicate VARCHAR2(1000);
BEGIN 
    v_predicate := '''X_'' || MASV = SYS_CONTEXT(''USERENV'', ''SESSION_USER'')';
    IF (USER like 'X_NS%' OR USER like 'QL_%') THEN
        RETURN NULL;
    END IF;
    RETURN v_predicate;
END;
/

-- XEM DANH SACH TAT CA HOC PHAN (HOCPHAN), KE HOACH MO MON (KHMO) CUA CHUONG TRINH DAO TAO MA SINH VIEN DANG THEO HOC

CREATE OR REPLACE VIEW INF_STUDENT_CAN_UPDATE AS   -- Xong
    SELECT DIACHI, DT FROM QL_TRUONGHOC_X.SINHVIEN ;
    
CREATE OR REPLACE PROCEDURE QL_TRUONGHOC_X.UPDATE_INF_STUDENT(
    P_DT IN VARCHAR2,  -- So dien thoai moi
    P_diachi IN VARCHAR2  -- So dien thoai moi
)
AS
BEGIN
    UPDATE QL_TRUONGHOC_X.INF_STUDENT_CAN_UPDATE SET DT = P_DT, DIACHI = P_diachi;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Cap nhat so dien thoai thanh cong.');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20002, 'Sinh vien khong ton tai trong he thong.');
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20003, 'Error occurred: ' || SQLERRM);
END;
/


CREATE OR REPLACE VIEW QL_TRUONGHOC_X.KHMO_CHITIET_SINHVIEN AS  -- Xong
    SELECT khmo.MAHP, hocphan.tenhp,khmo.magv , hocphan.sotc , khmo.hk, khmo.nam, hocphan.madv, khmo.mact  
    FROM QL_TRUONGHOC_X.PHANCONG khmo
    INNER JOIN QL_TRUONGHOC_X.HOCPHAN hocphan ON QL_TRUONGHOC_X.HOCPHAN.mahp = QL_TRUONGHOC_X.KHMO.mahp;
       
CREATE OR REPLACE FUNCTION GET_CT_BY_MASV(
    P_SCHEMA VARCHAR2, P_OBJ VARCHAR2
)
RETURN VARCHAR2
AS
    v_predicate VARCHAR2(1000);
BEGIN
    IF (USER like 'X_NS%' OR USER like 'QL_%') THEN
        RETURN NULL;
    END IF;
    return 'mact in ( 
        select sv.mact from QL_TRUONGHOC_X.SINHVIEN sv where 
        ''X_'' || MASV =  SYS_CONTEXT(''USERENV'', ''SESSION_USER''))';
END;
/

-- -------------------------------

-- THEM, XOA CAC DONG DU LIEU DANG KY HOC PHAN (DANGKY) LIEN QUAN DEN CHINH SINH VIEN DO TRONG HOC KY CUA NAM HOC HIEN TAI (NEU THOI DIEM HIEU CHINH
--DANG KY CON HOP LE)

CREATE OR REPLACE FUNCTION DS_LOPHOC_SV_CO_THE_DANGKY(
    P_SCHEMA VARCHAR2, P_OBJ VARCHAR2
)
RETURN VARCHAR2
AS
    v_predicate VARCHAR2(1000);
    current_month number;
    current_day number;
    current_year number;
    current_hk number;
    current_nam number;
    hk_start_date DATE;
    hk_end_date DATE;
BEGIN 
    IF (USER like 'X_NS%' OR USER like 'QL_%') THEN
        RETURN NULL;
    END IF;
    
        SELECT TO_NUMBER(TO_CHAR(SYSDATE, 'DD')),
               TO_NUMBER(TO_CHAR(SYSDATE, 'MM')),
               TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY'))
        INTO current_day, current_month, current_nam FROM dual;
        
        IF current_month IN (1,2,3) THEN
            current_hk := 1;
        ELSIF current_month IN (5,6,7) THEN
            current_hk := 2;
        ELSIF current_month IN (9,10,11) THEN
            current_hk := 3;
        ELSE
            current_hk := 3;
        END IF;
        
        IF (current_day BETWEEN 1 AND 20) THEN
            -- RETURN '0 = 1';
             RETURN 'HK = ' || current_hk || ' AND NAM = ' || current_nam; --|| ' AND ''X_'' || MASV = SYS_CONTEXT(''USERENV'', ''SESSION_USER'')';
        ELSE
            RETURN '0 = 1';
        END IF;

END;
/

CREATE OR REPLACE PROCEDURE QL_TRUONGHOC_X.SV_DANGKY_HOCPHAN(
    MASV VARCHAR,
    MAGV VARCHAR,
    MAHP VARCHAR,
    HK number,
    nam number,
    mact varchar
)
AS
    V_CURRENT_USER varchar2(10);
    V_MANV varchar2(12);
BEGIN
    V_CURRENT_USER := SYS_CONTEXT('USERENV', 'SESSION_USER');
    IF (USER like 'X_NS%' OR USER like 'QL_%') THEN
        RETURN;
    end if;
    if 'X_' || MASV = V_CURRENT_USER then
        INSERT INTO QL_TRUONGHOC_X.DANGKY
        SELECT MASV,MAGV, MAHP, HK, nam, mact ,0,0,0,0 from dual ;
        commit;
    end if;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20002, 'Nhan vien khong ton tai trong he thong.' || V_CURRENT_USER);
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20003, 'Error occurred: ' || SQLERRM);
END;
/

CREATE OR REPLACE PROCEDURE QL_TRUONGHOC_X.SV_HUY_DANGKY_HOCPHAN(
    PMASV VARCHAR,
    PMAGV VARCHAR,
    PMAHP VARCHAR,
    PHK number,
    Pnam number,
    Pmact char
)
AS
    V_CURRENT_USER varchar2(10);
    V_MANV varchar2(12);
BEGIN
    V_CURRENT_USER := SYS_CONTEXT('USERENV', 'SESSION_USER');
    IF (USER like 'X_NS%' OR USER like 'QL_%') THEN
        RETURN;
    end if;
    if 'X_' || PMASV = V_CURRENT_USER then
        DELETE FROM QL_TRUONGHOC_X.DANGKY
        WHERE MASV = PMASV and MAGV = PMAGV and MAHP = PMAHP and HK = PHK and nam = Pnam and mact = Pmact;
        commit;
        DBMS_OUTPUT.PUT_LINE('Xoá thành công'|| PMASV || PMAGV || PHK || Pnam || PMAHP || Pmact);
    end if;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20002, 'Nhan vien khong ton tai trong he thong.' || V_CURRENT_USER);
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20003, 'Da xay ra loi khi cap nhat hoc phan...' || V_CURRENT_USER);
END;
/

BEGIN
    DBMS_RLS.ADD_POLICY(
        OBJECT_SCHEMA => 'QL_TRUONGHOC_X',
        OBJECT_NAME   => 'SINHVIEN',
        POLICY_NAME   => 'GetInfByMaSV_Policy',
        POLICY_FUNCTION => 'GET_INF_BY_MASV_USERS',
        STATEMENT_TYPES => 'SELECT',
        UPDATE_CHECK => TRUE,
        ENABLE => TRUE
    );
END;
/  -- Xong

BEGIN
  DBMS_RLS.ADD_POLICY(
    object_schema    => 'QL_TRUONGHOC_X',
    object_name      => 'SINHVIEN',
    policy_name      => 'student_update_info_policy',
    function_schema  => 'QL_TRUONGHOC_X',
    policy_function  => 'GET_INF_BY_MASV_USERS',
    statement_types  => 'UPDATE',
    update_check     => TRUE,
    enable           => TRUE
  );
END;
/ -- Xong

BEGIN
    DBMS_RLS.ADD_POLICY(
        OBJECT_SCHEMA  => 'QL_TRUONGHOC_X',
        OBJECT_NAME    => 'KHMO_CHITIET_SINHVIEN',
        POLICY_FUNCTION => 'GET_CT_BY_MASV',
        STATEMENT_TYPES  => 'SELECT'
    );
END;
/ -- Xong


-- SINH VIEN DUOC XEM TAT CA THONG TIN TREN QUAN HE DANGKY TAI CAC DONG 
BEGIN
    DBMS_RLS.ADD_POLICY(
        OBJECT_SCHEMA  => 'QL_TRUONGHOC_X',
        OBJECT_NAME    => 'DANGKY',
        POLICY_NAME    => 'Sinhvien_DANGKY_policy3',
        POLICY_FUNCTION => 'GET_INF_BY_MASV_USERS',
        STATEMENT_TYPES  => 'SELECT'
    );
END;
/ -- Xong


BEGIN
    DBMS_RLS.ADD_POLICY(
        OBJECT_SCHEMA  => 'QL_TRUONGHOC_X',
        OBJECT_NAME    => 'DANGKY',
        POLICY_NAME    => 'Sinhvien_DANGKY_policy4',
        POLICY_FUNCTION => 'DS_LOPHOC_SV_CO_THE_DANGKY',
        STATEMENT_TYPES  => 'DELETE'
    );
END;
/ -- Xong



GRANT SELECT, UPDATE ON QL_TRUONGHOC_X.SINHVIEN TO RL_TRUONGHOC_SINHVIEN;
GRANT SELECT, UPDATE ON QL_TRUONGHOC_X.KHMO_CHITIET_SINHVIEN TO RL_TRUONGHOC_SINHVIEN;
GRANT SELECT, UPDATE ON QL_TRUONGHOC_X.INF_STUDENT_CAN_UPDATE TO RL_TRUONGHOC_SINHVIEN;
GRANT SELECT ON QL_TRUONGHOC_X.HOCPHAN TO RL_TRUONGHOC_SINHVIEN;
GRANT SELECT ON QL_TRUONGHOC_X.KHMO TO RL_TRUONGHOC_SINHVIEN;
GRANT SELECT ON QL_TRUONGHOC_X.DANGKY TO RL_TRUONGHOC_SINHVIEN;
GRANT DELETE, INSERT ON QL_TRUONGHOC_X.DANGKY TO RL_TRUONGHOC_SINHVIEN;
GRANT EXECUTE ON QL_TRUONGHOC_X.SV_DANGKY_HOCPHAN TO RL_TRUONGHOC_SINHVIEN;
GRANT EXECUTE ON QL_TRUONGHOC_X.SV_HUY_DANGKY_HOCPHAN TO RL_TRUONGHOC_SINHVIEN;
GRANT EXECUTE ON QL_TRUONGHOC_X.UPDATE_INF_STUDENT TO RL_TRUONGHOC_SINHVIEN;

--SELECT * FROM all_policies;
--
--BEGIN
--  DBMS_RLS.DROP_POLICY(
--    object_schema    => 'QL_TRUONGHOC_X',
--    object_name      => 'DANGKY',
--    policy_name      => 'Sinhvien_DANGKY_policy4'
--  );
--END;
--/


