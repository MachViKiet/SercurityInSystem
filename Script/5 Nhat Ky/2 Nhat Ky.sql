select * from SYS.AUD$ where userid <> 'QL_TRUONGHOC_X' and userid <> 'LBACSYS'; ;

select audit_type,dbusername ,SCN,  action_name, OBJECT_SCHEMA, OBJECT_NAME, EVENT_TIMESTAMP_UTC 
from unified_audit_trail
order by event_timestamp_utc desc;

create table C##ADMIN.TES22 (
    id number primary key
)

commit;

select system_privilege_used from unified_audit_trail;

DROP AUDIT POLICY X_NS001_audit_pol;
NOAUDIT POLICY X_NS001_audit_pol BY X_NS001;
create audit policy X_NS001_audit_pol
    privileges CREATE TABLE
    ACTIONS select,update on QL_TRUONGHOC_X.V_PERSONAL_INF_NHANSU,
        select,update on QL_TRUONGHOC_X.V_PERSONAL_INF_NHANSU,
        execute on QL_TRUONGHOC_X.UPDATE_PHONE;
audit policy X_NS001_audit_pol by X_NS001;

NOAUDIT POLICY X_NS001_audit_pol BY X_SV000001;
DROP AUDIT POLICY SINHVIEN_audit_pol;
create audit policy SINHVIEN_audit_pol
    privileges CREATE TABLE
    ACTIONS execute on QL_TRUONGHOC_X.UPDATE_INF_STUDENT by session
audit policy X_NS001_audit_pol by X_SV000001 WHENEVER SUCCESSFUL;
audit all on QL_TRUONGHOC_X.SINHVIEN by access;
AUDIT ALL;
    

create audit policy admin_audit_pol_tes222
    ACTIONS select on C##ADMIN.TES22 ;
audit policy admin_audit_pol_tes222 by X_NS001;



-----------
CREATE OR REPLACE FUNCTION update_grade_is_not_teacher 
RETURN BOOLEAN 
AS
    v_role_name varchar(10);
BEGIN
    select vaitro into v_role_name from QL_TRUONGHOC_X.NHANSU ns where 'X_' || ns.MANV = USER;
    RETURN v_role_name = 'Giang_vien';
END;

begin
  DBMS_FGA.ADD_POLICY(
    OBJECT_SCHEMA =>'QL_TRUONGHOC_X',
    object_name =>'DANGKY',
    policy_name =>'update_grade_is_not_teacher',
    audit_condition=>'update_grade_is_not_teacher = 1',
    statement_types =>'update');
end;
-----------

select * from QL_TRUONGHOC_X.NHANSU 


SELECT * FROM AUDIT_UNIFIED_ENABLED_POLICIES;
NOAUDIT POLICY X_NS001_AUDIT_POL BY C##ADMIN;
DROP AUDIT POLICY ADMIN_AUDIT_POL_TES222;