-- NV CO BAN
select * from QL_TRUONGHOC_X.V_PERSONAL_INF_NHANSU; 
BEGIN QL_TRUONGHOC_X.UPDATE_PHONE('1234567891'); END;/
SELECT * FROM QL_TRUONGHOC_X.KHMO_CHITIET;
SELECT * FROM QL_TRUONGHOC_X.HOCPHAN;
select * from QL_TRUONGHOC_X.DONVI_CHITIET;
SELECT * FROM QL_TRUONGHOC_X.SINHVIEN;

-- Giang Vien
SELECT * FROM QL_TRUONGHOC_X.PHANCONG_MY_INFO;
SELECT * FROM QL_TRUONGHOC_X.DK_MY_CLASSES;

BEGIN
    QL_TRUONGHOC_X.UPDATE_GRADES(10,10,10, 10,'HP005', 'SV005543', 1, 2023, 'VP');
END;