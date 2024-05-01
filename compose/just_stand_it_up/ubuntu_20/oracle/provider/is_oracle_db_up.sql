whenever sqlerror exit 1;
connect system/testpassword@//catalog:1521
select 1 from dual;
exit 0;
