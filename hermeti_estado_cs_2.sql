SELECT a.est_cweb,a.num_cmpb,a.cod_usua_crea,p.des_punt
FROM csweb.cwtc_rweb_cmpb A inner join ventas.ve_punto p on A.COD_PUNT_ORIG=p.cod_punt 
where a.num_cmpb=(
                  SELECT b.num_cmpb 
                  FROM csweb.cwtd_rweb_cmpb_bove B 
                  where b.mon_valo=67002.35 
                  and b.num_cmpb=a.num_cmpb)
      AND A.COD_CLIE IN (138);
