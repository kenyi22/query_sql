Select *
  From cbtc_frec_punt
 where cod_sucu = 1
   and cod_punt in
       (35493, 35427)
   and cod_punt != :global.punto_hermes

Select * From VE_PUNTO WHERE DES_PUNT LIKE '%HERMES - SMART%';

Select a.est_soli,a.*
  From SATC_MATR_PUNT a
 where a.cod_punt_serv in (35493, 35427) --31078--16039 --:control.s_cod_punt
   and not (to_number(a.est_soli) = 2 and a.tip_trxn = '3' and exists
         (select 1
               from cbtc_soli_frec b
              where b.cod_punt_serv_actu = a.cod_punt_serv
                and b.cod_ndia_serv_actu = a.cod_ndia_serv
                and b.nse_secu_serv_actu = a.nse_secu_serv
                and b.cod_ruta is null))
   and to_number(a.est_soli) <= 4


atm/cit/1617
