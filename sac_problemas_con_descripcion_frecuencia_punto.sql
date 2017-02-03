Select *
  From SATC_MATR_PUNT a
 WHERE a.cod_punt_serv in (35493, 35427)
   and to_number(a.est_soli) <= 4
   and not (to_number(a.est_soli) = 2 and a.tip_trxn = '3' and exists
         (select 1
               from cbtc_soli_frec b
              where b.cod_punt_serv_actu = a.cod_punt_serv
                and b.cod_ ndia_serv_actu = a.cod_ndia_serv
                and b.nse_secu_serv_actu = a.nse_secu_serv
                and b.cod_ruta is null) And Not Exists
         (Select 1
               From pptc_soli_frec b
              Where b.cod_punt_serv = a.cod_punt_serv
                And b.cod_ndia_serv = a.cod_ndia_serv
                And b.nse_secu_serv = a.nse_secu_serv))
 Order By hor_inic, hor_finl, ind_conf FOR UPDATE;


Select * From ve_punto where cod_punt in (35493, 35427);


SELECT *
FROM CSTC_PERF_USUA A
WHERE A.COD_MODU = 'SH'
AND A.COD_USUA_ACCE = 'KCANCHI' FOR UPDATE;
