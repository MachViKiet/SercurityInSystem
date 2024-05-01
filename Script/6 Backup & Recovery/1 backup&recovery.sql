/*--Thuc hien tren cmd
-- Chuyen co so du lieu sang che do Archivelog
SQLPLUS / AS SYSDBA
SHUTDOWN IMMEDIATE;
STARTUP MOUNT;
ALTER DATABASE ARCHIVELOG;
ALTER DATABASE OPEN;

-- Kiem tra trang thai cua co so du lieu
SELECT INSTANCE_NAME, STATUS, DATABASE_STATUS, INSTANCE_ROLE from V$INSTANCE;
-- Kiem tra trang thai cua PDB
SELECT NAME, OPEN_MODE FROM V$PDBS;

-- ket noi voi rman
RMAN TARGET /
-- Kiem tra danh sach backup
LIST BACKUP OF DATABASE SUMMARY;
LIST BACKUP OF CONTROLFILE;

-- Xoa danh sach backup neu co
DELETE BACKUP;

-- Bat CONTROLFILE AUTOBACKUP 
CONFIGURE CONTROLFILE AUTOBACKUP ON;
*/
-- Kiem tra thong tin cua truong khoa trong danh sach nhan su 
CONN X_NS001/123@LOCALHOST:1521/XEPDB1;
select * from QL_TRUONGHOC_X.NHANSU
where MANV='NS001';
-- Kiem tra audit
CONN QL_TRUONGHOC_X/123@LOCALHOST:1521/XEPDB1;
select audit_type,dbusername ,SCN,  action_name, OBJECT_SCHEMA, OBJECT_NAME, EVENT_TIMESTAMP_UTC 
from unified_audit_trail
order by event_timestamp_utc desc;
-- Thuc hien tren cmd
/*-- Tao Full Backup 
BACKUP DATABASE PLUS ARCHIVELOG FORMAT 'D:/Oracle_Backups/fullbackups_%u';
*/
-- Thuc hien update nham sdt cua truong khoa
CONN X_NS001/123@LOCALHOST:1521/XEPDB1;
EXECUTE QL_TRUONGHOC_X.UPDATE_PHONE('0123456')
select * from QL_TRUONGHOC_X.NHANSU
where MANV='NS001';
-- Kiem tra audit
CONN QL_TRUONGHOC_X/123@LOCALHOST:1521/XEPDB1;
select audit_type,dbusername ,SCN,  action_name, OBJECT_SCHEMA, OBJECT_NAME, EVENT_TIMESTAMP_UTC 
from unified_audit_trail
order by event_timestamp_utc desc;

/*-- Thuc hien tren cmd
-- Recovery theo ky thuat PITR
LIST BACKUP OF DATABASE SUMMARY;

RUN {
    SHUTDOWN IMMEDIATE;
    STARTUP MOUNT;
    SET UNTIL SCN 6163547; -- SCN la SCN cua lenh UPDAT_PHONE duoc tim thay trong bang unified_audit_trail
    RESTORE DATABASE FROM TAG TAG20240401T205847;-- Tag co the duoc tim thay trong LIST BACKUP OF DATABASE SUMMARY;
    RECOVER DATABASE;
    ALTER DATABASE OPEN RESETLOGS;
}
*/
-- Kiem tra thong tin cua truong khoa xem da duoc khoi phuc chua
CONN X_NS001/123@LOCALHOST:1521/XEPDB1;
select * from QL_TRUONGHOC_X.NHANSU
where MANV='NS001';