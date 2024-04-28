ALTER SESSION SET CONTAINER= PDBQL_TRUONGHOC;


BEGIN
 SA_SYSDBA.CREATE_POLICY(
 policy_name => 'region_policy',
 column_name => 'region_label'
);
END;
SHOW CON_NAME; 

EXEC SA_SYSDBA.ENABLE_POLICY ('region_policy'); 

select * from all_procedures where object_name like 'SA_COMPONENTS';
select * from all_procedures where object_name like 'SA_SYSDBA';
select * from all_procedures where object_name like 'SA_%';


EXECUTE SA_COMPONENTS.CREATE_LEVEL('region_policy',20,'L1','LEVEL 1');
EXECUTE SA_COMPONENTS.CREATE_LEVEL('region_policy',40,'L2','LEVEL 2');
EXECUTE SA_COMPONENTS.CREATE_LEVEL('region_policy',60,'L3','LEVEL 3'); 


EXECUTE SA_COMPONENTS.CREATE_COMPARTMENT('region_policy',100,'M','MANAGEMENT');
EXECUTE SA_COMPONENTS.CREATE_COMPARTMENT('region_policy',120,'E','EMPLOYEE'); 

EXECUTE SA_COMPONENTS.CREATE_GROUP('region_policy',20,'R20','REGION NORTH');
EXECUTE SA_COMPONENTS.CREATE_GROUP('region_policy',40,'R40','REGION SOUTH');
EXECUTE SA_COMPONENTS.CREATE_GROUP('region_policy',60,'R60','REGION EAST');
EXECUTE SA_COMPONENTS.CREATE_GROUP('region_policy',80,'R80','REGION WEST');

select * from 

BEGIN
 SA_POLICY_ADMIN.APPLY_TABLE_POLICY (
 POLICY_NAME => 'region_policy',
 SCHEMA_NAME => 'ADMIN_OLS',
 TABLE_NAME => 'OLS_KHACHHANG',
 TABLE_OPTIONS => 'NO_CONTROL'
 );
END;


BEGIN
SA_POLICY_ADMIN.REMOVE_TABLE_POLICY('REGION_POLICY','ADMIN_OLS','OLS_KHACHHANG');
SA_POLICY_ADMIN.APPLY_TABLE_POLICY (
 policy_name => 'REGION_POLICY',
 schema_name => 'ADMIN_OLS',
 table_name => 'OLS_KHACHHANG',
 table_options => 'READ_CONTROL',
predicate => NULL
);
END; 


BEGIN
 SA_USER_ADMIN.SET_USER_LABELS('region_policy','sales_manager','L3:M,E:R20,R40,R60,R80');
 SA_USER_ADMIN.SET_USER_LABELS('region_policy','sales_north','L3:E:R20,R40');
 SA_USER_ADMIN.SET_USER_LABELS('region_policy','sales_south','L3:E:R20,R40,R60,R80');
 SA_USER_ADMIN.SET_USER_LABELS('region_policy','sales_east','L3:E:R60');
 SA_USER_ADMIN.SET_USER_LABELS('region_policy','sales_west','L3:E:R80');
END;

select * from ALL_SA_LABELS;