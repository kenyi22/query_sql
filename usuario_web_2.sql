Select cc.des_corp,n.cod_corp, n.cod_razo_soci,U.usu_web,m.cod_modu,m.cod_perf,u.pri_nomb,u.seg_nomb,u.pri_apel,u.seg_apel,
       u.car_emp, M.IND_ACTI, M.FEC_MODI,U.FEC_CONE, U.IND_ACTI, U.FEC_MODI, N.IND_ACTI,N.FEC_MODI,
       n.cod_punt/*,U.PAS_WEB*/,U.MAIL,p.des_punt
From general.csmc_usua_web n
     LEFT OUTER JOIN general.csmd_modu_clie m ON n.usu_web = m.usu_web
     INNER  JOIN general.camc_usua u  ON u.usu_web = n.usu_web
     INNER JOIN ventas.ve_corporacion cc ON n.cod_corp = cc.cod_corp
     LEFT OUTER JOIN ventas.ve_punto p ON n.cod_punt=p.cod_punt
WHERE   m.cod_modu='HW' and m.cod_perf='HCON';
