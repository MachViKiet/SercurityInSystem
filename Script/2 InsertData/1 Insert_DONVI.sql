--DU LIEU BANG DON VI
INSERT INTO QL_TRUONGHOC_X.DONVI (MADV, TENDV)
    SELECT 'VPK01','Van Phong Khoa' from dual union all
    SELECT 'HTTT1','Bo Mon He Thong Thong Tin' from dual union all
    SELECT 'CNPM1','Bo Mon Cong Nghe Phan Mem' from dual union all
    SELECT 'CNTT1','Bo Mon Cong Nghe Thong Tin' from dual union all
    SELECT 'TGMT1','Bo Mon Thi Giac May Tinh' from dual union all
    SELECT 'KHMT1','Bo Mon Khoa Hoc May Tinh' from dual union all
    SELECT 'MMTVT','Bo Mon Mang May Tinh Va Vien Thong' from dual ;
   
INSERT INTO QL_TRUONGHOC_X.COSO (MACS, TENCS, DIACHI)
    SELECT 'CS001','Co so 1', '224, Nguyen Van Cu, Q5, TPHCM' from dual union all
    SELECT 'CS002','Co so 2', 'Linh Trung, Thu Duc, TPHCM' from dual;
     