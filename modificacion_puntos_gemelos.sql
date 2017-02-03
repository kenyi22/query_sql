update sa_dire_mail
set cod_clie=4343--punto gemelo
where cod_sucu_htb = 1
    and cod_clie = 4104--punto normal
   and cod_sist = 'SA'
   and cod_modu = 'SAF4016B'
      and nvl(ind_acti, 0) = 1;
------------------------
Select * From SA_CLIE_PLAN where cod_clie=950 for update;

select t.* from radio.SA_PLAN_SELE_PUNT t
where t.cod_clie = 4305 for update;
----------------------
BEGIN
  FOR item IN (Select * From SA_CLIE_PLAN where cod_clie = 4104) LOOP
    insert into SA_CLIE_PLAN
    values
      (4343, item.cod_plan, item.ind_acti, item.nse_plan);
  END LOOP;
END;
-------------
BEGIN
  FOR item IN (select t.*
                 from radio.SA_PLAN_SELE_PUNT t
                where t.cod_clie = 4104) LOOP
    insert into SA_PLAN_SELE_PUNT
    values
      (4343,
       item.cod_sucu_htb,
       item.cod_plan,
       item.cod_punt,
       item.nse_plan);
  END LOOP;
END;
