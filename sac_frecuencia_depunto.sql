Select a.est_soli,a.*
  From SATC_MATR_PUNT a
 where a.cod_punt_serv =24814 --31078--16039 --:control.s_cod_punt
   and not (to_number(a.est_soli) = 2 and a.tip_trxn = '3' and exists
         (select 1
               from cbtc_soli_frec b
              where b.cod_punt_serv_actu = a.cod_punt_serv
                and b.cod_ndia_serv_actu = a.cod_ndia_serv
                and b.nse_secu_serv_actu = a.nse_secu_serv
                and b.cod_ruta is null))
   and to_number(a.est_soli) <= 4 for update


Select * From tg_tabl_estd t where t.des_estd like '%EST%SOLI%';
Select * From tg_tabl_estd t where t.Cod_Grup_Estd in (107,57,64,94);

select *--des_estd
--    into :satc_matr_punt.s_des_estd
    from tg_tabl_estd
    where cod_grup_estd = 111
    --SATC_MATR_PUNT


SHPG_ANOM. SHPR_CARG_ACTA
