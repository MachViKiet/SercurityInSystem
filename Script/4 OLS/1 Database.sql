-- conn QL_TRUONGHOC_X
drop table THONGBAO;
create table THONGBAO(
    id number primary key,
    THONGBAO varchar(200)
);
select * from QL_TRUONGHOC_X.THONGBAO;
truncate table QL_TRUONGHOC_X.TRUONGHOCX_THONGBAO;
--INSERT INTO QL_TRUONGHOC_X.TRUONGHOCX_THONGBAO
--    SELECT 'Thong bao 1' FROM DUAL UNION ALL
--    SELECT 'Thong bao 1' FROM DUAL UNION ALL
--    SELECT 'B) Thong bao den Truong Don Vi HTTT Co So 1' FROM DUAL UNION ALL
--    SELECT 'B1) Thong bao den Truong Don Vi HTTT Co So 2' FROM DUAL UNION ALL
--    SELECT 'B2) Thong bao den Truong Don Vi HTTT' FROM DUAL UNION ALL
--    SELECT 'B3) Thong bao den Truong Don Vi KHMT Co So 1' FROM DUAL;
    
    
--INSERT INTO QL_TRUONGHOC_X.TRUONGHOCX_THONGBAO
--    SELECT 'A) Thong bao den Truong Khoa', CHAR_TO_LABEL('policy_ThongBao', 'TK:HTTT,CNPM,KHMT,CNTT,TGMT,MMT:CS1') FROM DUAL UNION ALL
--    SELECT 'A) Thong bao den CS2', CHAR_TO_LABEL('policy_ThongBao', 'TK:HTTT,CNPM,KHMT,CNTT,TGMT,MMT:CS2') FROM DUAL UNION ALL
--    SELECT 'B) Thong bao den Truong Don Vi HTTT Co So 1', CHAR_TO_LABEL('policy_ThongBao', 'TDV:HTTT:CS1') FROM DUAL UNION ALL
--    SELECT 'B1) Thong bao den Truong Don Vi HTTT Co So 2', CHAR_TO_LABEL('policy_ThongBao', 'TDV:HTTT:CS2') FROM DUAL UNION ALL
--    SELECT 'B2) Thong bao den Truong Don Vi HTTT', CHAR_TO_LABEL('policy_ThongBao', 'TDV:HTTT') FROM DUAL UNION ALL
--    SELECT 'B3) Thong bao den Truong Don Vi KHMT Co So 1', CHAR_TO_LABEL('policy_ThongBao', 'TDV:KHMT:CS1') FROM DUAL;


