-- NV CO BAN
select * from QL_TRUONGHOC_X.V_PERSONAL_INF_NHANSU; 
BEGIN QL_TRUONGHOC_X.UPDATE_PHONE('1234567891'); END;
SELECT * FROM QL_TRUONGHOC_X.KHMO_CHITIET;
SELECT * FROM QL_TRUONGHOC_X.HOCPHAN;
select * from QL_TRUONGHOC_X.DONVI_CHITIET;

-- Giao Vu
SELECT * FROM QL_TRUONGHOC_X.V_THONGTIN_PHANCONGGIANGDAY;
SELECT * FROM QL_TRUONGHOC_X.DANGKY;
BEGIN QL_TRUONGHOC_X.ADD_PHANCONG_GIAOVU('NS011', 'HP080', 2, 2024, 'CQ'); END;
BEGIN QL_TRUONGHOC_X.DELETE_PHANCONG_GIAOVU('NS011', 'HP080', 2, 2024, 'CQ'); END;
BEGIN QL_TRUONGHOC_X.UPDATE_PHANCONGGIANGDAY_GIAOVU('NS011', 'HP080', 2, 2024, 'CQ', 'NS101'); END;

--    SELECT *
--    FROM QL_TRUONGHOC_X.PHANCONG where
--            MAHP = 'HP080' and
--            HK = 2 and
--            NAM = 2024 and
--            MACT = 'CQ';
SELECT * FROM QL_TRUONGHOC_X.DANGKY where masv = 'SV000001';
BEGIN QL_TRUONGHOC_X.DANGKY_MONHOC('SV000001', 'NS101', 'HP080', 2, 2024, 'CQ'); END;
BEGIN QL_TRUONGHOC_X.HUY_DANGKY_MONHOC('SV000001', 'NS101', 'HP080', 2, 2024, 'CQ'); END;


BEGIN QL_TRUONGHOC_X.THEM_DONVI( :P_MADV ,:P_TENDV ); END;

BEGIN QL_TRUONGHOC_X.THEM_SINHVIEN('SV999998', 'M?ch V? Ki?t', 'Y', TO_DATE('25-07-2003','DD-MM-YY'), 'Ha Noi', '1123456789' , 'CLC' , 'HTTT1' ); END;
SELECT * FROM QL_TRUONGHOC_X.SINHVIEN where masv = 'SV999998';