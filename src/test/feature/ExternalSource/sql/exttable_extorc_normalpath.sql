-- inter table 
-- start_ignore
drop table if exists normal_orctable1, normal_orctable2, normal_orctable3, normal_orctable4, normal_orctable5;
drop external table if exists  normal_orctable1_e, normal_orctable2_e, normal_orctable3_e, normal_orctable4_e, normal_orctable5_e, normal_orctable6_e, normal_orctable7_e, normal_orctable8_e;
-- end_ignore
-- create normal table 
create table normal_orctable1 (i int, j float) format 'orc';
create table normal_orctable2 (i int, j float)  format 'orc' encoding 'utf8';
create table normal_orctable3 (i int, j float)  format 'orc' (compresstype 'snappy') encoding 'utf8';
create table normal_orctable4 (i int, j float)  format 'orc' (compresstype 'none') encoding 'utf8';
create table normal_orctable5 (i int, j float)  format 'orc' (compresstype 'lz4') encoding 'utf8';

create table normal_orctable6 (k text, like normal_orctable1) format 'orc';
create table normal_orctable7 (i int, j float)  format 'orc' distributed by (i);


-- writable external orc table
create writable external table normal_orctable1_e (i int, j float) location ('hdfs://localhost:8020/hawq_default/exttable_extorc_test_normalpath/normal_orctable1_e') format 'orc';
create writable external table normal_orctable2_e (i int, j float) location ('hdfs://localhost:8020/hawq_default/exttable_extorc_test_normalpath/normal_orctable2_e') format 'orc' encoding 'utf8';
create writable external table normal_orctable3_e (i int, j float) location ('hdfs://localhost:8020/hawq_default/exttable_extorc_test_normalpath/normal_orctable3_e') format 'orc' () encoding 'utf8';
create writable external table normal_orctable4_e (i int, j float) location ('hdfs://localhost:8020/hawq_default/exttable_extorc_test_normalpath/normal_orctable4_e') format 'orc' (compresstype 'snappy') encoding 'utf8';
create writable external table normal_orctable5_e (i int, j float) location ('hdfs://localhost:8020/hawq_default/exttable_extorc_test_normalpath/normal_orctable5_e') format 'orc' (compresstype 'none') encoding 'utf8';
create writable external table normal_orctable6_e (i int, j float) location ('hdfs://localhost:8020/hawq_default/exttable_extorc_test_normalpath/normal_orctable6_e') format 'orc' (compresstype 'lz4') encoding 'utf8';


-- readable external orc table
create readable external table normal_orctable7_e (i int, j float) location ('hdfs://localhost:8020/hawq_default/exttable_extorc_test_normalpath/normal_orctable7_e') format 'orc';
create readable external table normal_orctable8_e (i int, j float) location ('hdfs://localhost:8020/hawq_default/exttable_extorc_test_normalpath/normal_orctable8_e') format 'orc' encoding 'utf8';


-- test insert
insert into normal_orctable1 values (1,0.1); 
insert into normal_orctable1 values (2,0.1);
insert into normal_orctable1 values (3,0.1);
select * from normal_orctable1;

insert into normal_orctable1_e values (1,0.1);
insert into normal_orctable1_e values (2,0.1);
insert into normal_orctable1_e values (3,0.1);
select * from normal_orctable1_e;

select c.relname, e.fmttype, e.fmtopts, e.command, e.rejectlimit, e.rejectlimittype, e.fmterrtbl, e.encoding, e.writable 
from pg_class c, pg_exttable e 
where c.oid=e.reloid and c.relname in ('normal_orctable1_e', 'normal_orctable2_e', 'normal_orctable3_e',  'normal_orctable4_e', 'normal_orctable5_e', 'normal_orctable6_e', 'normal_orctable7_e', 'normal_orctable8_e') 
order by c.relname;



-- test drop
