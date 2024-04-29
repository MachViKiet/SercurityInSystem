create table THONGBAO (
    id number,
    thongbao varchar2(200)
)


CREATE SEQUENCE THONGBAO_seq
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;

CREATE TABLE THONGBAO (
  id NUMBER PRIMARY KEY,
  thongbao varchar2(200)  -- Các c?t khác trong b?ng
);

-- Sau ?ó, t?o m?t trigger ?? t? ??ng gán giá tr? t? sequence vào c?t id:
CREATE OR REPLACE TRIGGER THONGBAO_trigger
BEFORE INSERT ON THONGBAO
FOR EACH ROW
BEGIN
  SELECT THONGBAO_seq.NEXTVAL
  INTO :new.id
  FROM dual;
END;
/
--truncate table THONGBAO
insert into THONGBAO(thongbao) values ('Thong bao 1');
insert into THONGBAO(thongbao) values ('Thong bao 2');
insert into THONGBAO(thongbao) values ('Thong bao 3');
insert into THONGBAO(thongbao) values ('Thong bao 4');
insert into THONGBAO(thongbao) values ('Thong bao 5');
insert into THONGBAO(thongbao) values ('Thong bao 6');

select * from THONGBAO;