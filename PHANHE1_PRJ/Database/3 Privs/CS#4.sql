-- C?p quy?n cho vai trò "Tr??ng ??n v?" t?t c? các quy?n c?a vai trò "Gi?ng viên"
GRANT RL_TRUONGHOC_GIANGVIEN TO RL_TRUONGHOC_TRUONGDONVI;
/
CL SCR;
-- T?o view ?? l?c ra d? li?u phân công gi?ng d?y c?a các gi?ng viên thu?c ??n v? mà ng??i dùng là tr??ng ??n v?
CREATE OR REPLACE VIEW QL_TRUONGHOC_X.PHANCONG_TRUONGDONVI AS
    SELECT p.magv, ns.hoten, p.mahp, hp.tenhp,p.hk, p.nam, p.mact
    FROM QL_TRUONGHOC_X.PHANCONG p
    JOIN QL_TRUONGHOC_X.HOCPHAN hp ON p.mahp = hp.mahp
    JOIN QL_TRUONGHOC_X.NHANSU ns ON p.MAGV = ns.MANV
    JOIN QL_TRUONGHOC_X.DONVI dv ON ns.MADV = dv.MADV
    JOIN QL_TRUONGHOC_X.NHANSU trgdv ON trgdv.MANV = (SELECT MANV
                                       FROM QL_TRUONGHOC_X.NHANSU
                                       WHERE MADV = dv.MADV
                                         AND VAITRO = 'Truong don vi')
    WHERE 'X_' || trgdv.MANV = SYS_CONTEXT('USERENV', 'SESSION_USER');

--drop view PHANCONG_TRUONGDONVI
CREATE OR REPLACE VIEW QL_TRUONGHOC_X.TRUONGDONVI_NHANSU AS
SELECT ns.manv, ns.hoten, ns.vaitro from NHANSU ns, NHANSU trdv
where 'X_' || trdv.manv = SYS_CONTEXT('USERENV', 'SESSION_USER') 
    and trdv.vaitro = 'Truong don vi' and ns.madv = trdv.madv
/
-- C?p quy?n SELECT cho vai trò "Tr??ng ??n v?" trên view v?a t?o
GRANT SELECT ON QL_TRUONGHOC_X.PHANCONG_TRUONGDONVI TO RL_TRUONGHOC_TRUONGDONVI;
GRANT SELECT ON QL_TRUONGHOC_X.TRUONGDONVI_NHANSU TO RL_TRUONGHOC_TRUONGDONVI;
/
-- T?o trigger ?? ki?m tra quy?n tr??c khi th?c hi?n thao tác INSERT, UPDATE ho?c DELETE trên b?ng PHANCONG
-- DROP TRIGGER QL_TRUONGHOC_X.TRG_PHANCONG_TRUONGDONVI;
--CREATE OR REPLACE TRIGGER QL_TRUONGHOC_X.TRG_PHANCONG_TRUONGDONVI
--BEFORE INSERT OR UPDATE OR DELETE ON QL_TRUONGHOC_X.PHANCONG
--FOR EACH ROW
--DECLARE
--    v_trgdv VARCHAR2(20);
--BEGIN
--    SELECT ns.MANV
--    INTO v_trgdv
--    FROM QL_TRUONGHOC_X.NHANSU ns
--    JOIN QL_TRUONGHOC_X.DONVI dv ON ns.MADV = dv.MADV
--    JOIN QL_TRUONGHOC_X.HOCPHAN hp ON dv.MADV = hp.MADV
--    WHERE hp.MAHP = :NEW.MAHP
--      AND ns.VAITRO = 'Truong don vi'
--      AND ROWNUM = 1; -- ??m b?o ch? l?y 1 dòng d? li?u
--
--    IF SYS_CONTEXT('USERENV', 'SESSION_USER') <> 'X_' || v_trgdv THEN
--        RAISE_APPLICATION_ERROR(-20000, 'B?n không có quy?n th?c hi?n thao tác này!');
--    END IF;
--EXCEPTION
--    WHEN NO_DATA_FOUND THEN
--        RAISE_APPLICATION_ERROR(-20001, 'Không tìm th?y tr??ng ??n v? ph? trách h?c ph?n này!');
--END;
--/

CREATE OR REPLACE PROCEDURE QL_TRUONGHOC_X.UPDATE_PHANCONG(
    P_MAGV IN CHAR,          
    P_MAHP IN CHAR,       
    P_HK IN NUMBER,    
    P_NAM IN NUMBER,         
    P_CT IN VARCHAR2,
    P_NEW_MAGV IN CHAR
)
AS
    V_USER CHAR(10);
    V_MAGV CHAR(10);
    V_CURMAGV CHAR(10);
BEGIN
    V_USER := SYS_CONTEXT('USERENV', 'SESSION_USER');
    SELECT manv INTO V_MAGV 
    FROM QL_TRUONGHOC_X.TRUONGDONVI_NHANSU WHERE MANV = P_MAGV ;
    
    IF V_MAGV IS NOT NULL THEN
            UPDATE QL_TRUONGHOC_X.PHANCONG
            SET MAGV = P_NEW_MAGV
            WHERE MAHP = P_MAHP and HK = P_HK and NAM = P_NAM and mact = P_CT and MAGV = P_MAGV;
    else 
        RAISE_APPLICATION_ERROR(-20001, 'Nhan su khong thuoc quyen quan ly.');
    END IF;
    

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Cap nhat phan cong thanh cong.');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20001, 'Khong tom thay du lieu khmo.');
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20001, 'Error occurred: ' || SQLERRM);
END;
/

CREATE OR REPLACE PROCEDURE QL_TRUONGHOC_X.DELETE_PHANCONG(
    P_MAGV IN CHAR,          
    P_MAHP IN CHAR,       
    P_HK IN NUMBER,    
    P_NAM IN NUMBER,         
    P_CT IN VARCHAR2          
)
AS
    V_USER CHAR(10);
    V_MAGV CHAR(10);
BEGIN
    V_USER := SYS_CONTEXT('USERENV', 'SESSION_USER');
    SELECT manv INTO V_MAGV 
    FROM QL_TRUONGHOC_X.TRUONGDONVI_NHANSU WHERE MANV = P_MAGV ;
    IF V_MAGV IS NOT NULL THEN
        DELETE FROM QL_TRUONGHOC_X.PHANCONG
        WHERE MAHP = P_MAHP and HK = P_HK and NAM = P_NAM and mact = P_CT and MAGV = P_MAGV;
    else 
        RAISE_APPLICATION_ERROR(-20001, 'Nhan su khong thuoc quyen quan ly.');
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

CREATE OR REPLACE PROCEDURE QL_TRUONGHOC_X.ADD_PHANCONG(
    P_MAGV IN CHAR,          
    P_MAHP IN CHAR,       
    P_HK IN NUMBER,    
    P_NAM IN NUMBER,         
    P_CT IN VARCHAR2          
)
AS
    V_USER CHAR(10);
    V_MAGV CHAR(10);
BEGIN
    V_USER := SYS_CONTEXT('USERENV', 'SESSION_USER');
    SELECT manv INTO V_MAGV 
    FROM QL_TRUONGHOC_X.TRUONGDONVI_NHANSU WHERE MANV = P_MAGV ;
    IF V_MAGV IS NOT NULL THEN
        insert into QL_TRUONGHOC_X.PHANCONG ( MAGV, MAHP, HK, NAM, MACT )
        values( P_MAGV, P_MAHP, P_HK, P_NAM, P_CT );
        COMMIT;
    else 
        RAISE_APPLICATION_ERROR(-20001, 'Nhan su khong thuoc quyen quan ly.');
    END IF;

    DBMS_OUTPUT.PUT_LINE('Cap nhat phan cong thanh cong.');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20001, 'Khong tom thay du lieu giang vien.');
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20001, 'Error occurred: ' || SQLERRM);
END;
/

-- C?p quy?n INSERT, UPDATE, DELETE trên b?ng PHANCONG cho vai trò "Tr??ng ??n v?"
-- GRANT INSERT, UPDATE, DELETE ON QL_TRUONGHOC_X.PHANCONG TO RL_TRUONGHOC_TRUONGDONVI;
GRANT EXECUTE ON QL_TRUONGHOC_X.UPDATE_PHANCONG TO RL_TRUONGHOC_TRUONGDONVI;
GRANT EXECUTE ON QL_TRUONGHOC_X.DELETE_PHANCONG TO RL_TRUONGHOC_TRUONGDONVI;
GRANT EXECUTE ON QL_TRUONGHOC_X.ADD_PHANCONG TO RL_TRUONGHOC_TRUONGDONVI;

/