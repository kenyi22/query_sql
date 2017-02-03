
--create index canales.pf_cltd_crre_caja_01 on canales.CLTD_CRRE_CAJA (cod_punt_equi, fec_crre, cod_usua);
Select c.Cod_Punt, c.Cod_Punt_Equi, c.Fec_Crre, c.Cod_Usua, 
       c.Tip_Rcau, d.des_rcau, Decode(c.cod_grup_tarj,0,Null,c.cod_grup_tarj ), d.des_grup,
       c.Mon_Tot1, c.Mon_Tot2, c.Mon_falt, Round(c.Mon_Tot1 - (abs(c.Mon_Tot2)+abs(c.Mon_falt)),2) mon_dife1,
       c.mon_dife
  from (Select a.Cod_Punt, a.Cod_Punt_Equi, a.Fec_Crre, a.Cod_Usua, 
               a.Tip_Rcau, b.cod_grup_tarj, round(a.Mon_Tot1,2) Mon_Tot1, b.Mon_Tot2,
               Abs(Decode(a.tip_rcau,1,(Select Nvl(Sum(mon_deta_cier),0)
                                          From Cltd_Crre_Caja
                                         Where Fec_Crre = a.Fec_Crre 
                                           And Cod_Punt_Equi = a.Cod_Punt_Equi
                                           And Cod_Usua = a.Cod_Usua
                                           And Cod_Punt <> 0
                                           And mon_deta_cier <> 0 
                                           And cod_tipo_arch = 1 
                                           And cod_unid_mone = 2
                                           And Upper(Des_Deta_Reca) = 'MONTO FALTANTE'),0)) Mon_falt,
                                           b.Mon_falt2,
               Round(a.Mon_Tot1 -  abs(b.Mon_Tot2),2) mon_dife
          From (Select a.Cod_Punt, a.Cod_Punt_Equi, a.Fec_Crre, a.Cod_Usua,
                       b.Tip_Rcau, nvl(b.cod_grup_tarj,0) cod_grup_tarj,
                       Sum(Abs(decode(b.Cod_Unid_Mone,2,b.Mon_Deta_Cier,1,b.Mon_Deta_Cier*a.tip_camb))) Mon_Tot1
                  From Cltc_Crre_Caja a, Cltd_Crre_Caja_Deta b
                 Where a.Cod_Punt = b.Cod_Punt
                   And a.Cod_Punt_Equi = b.Cod_Punt_Equi 
                   And a.Fec_Crre = b.Fec_Crre
                   And a.Cod_Usua = b.Cod_Usua
                   And b.Fec_Crre = &pd_fech_crre
                   And b.Tip_Regi = 1
                 Group By a.Cod_Punt, a.Cod_Punt_Equi, a.Fec_Crre,  a.Cod_Usua,
                          b.Tip_Rcau, nvl(b.cod_grup_tarj,0)) a,
               (Select a.Cod_Punt, a.Cod_Punt_Equi, a.Fec_Crre, a.Cod_Usua,
                       b.Tip_Rcau, nvl(b.cod_grup_tarj,0) cod_grup_tarj,
                       Sum(Abs(decode(b.Cod_Unid_Mone,2,b.Mon_Deta_Cier,1,b.Mon_Deta_Cier*a.tip_camb))) Mon_Tot2,
                       Abs(Decode(b.tip_rcau,1,(Select Nvl(Sum(mon_deta_cier),0)
                                                  From Cltd_Crre_Caja
                                                 Where Fec_Crre = a.Fec_Crre
                                                   And Cod_Punt_Equi = a.Cod_Punt_Equi
                                                   And Cod_Usua = a.Cod_Usua
                                                   And Cod_Punt <> 0
                                                   And mon_deta_cier <> 0 
                                                   And cod_tipo_arch = 1
                                                   And cod_unid_mone = 2
                                                   And Upper(Des_Deta_Reca) = 'MONTO FALTANTE'),0)) Mon_falt2
                  From Cltc_Crre_Caja a, Cltd_Crre_Caja_Deta b--, clmd_conf_clie_rcau p
                 Where a.Cod_Punt = b.Cod_Punt
                   And a.Cod_Punt_Equi = b.Cod_Punt_Equi
                   And a.Fec_Crre = b.Fec_Crre 
                   And a.Cod_Usua = b.Cod_Usua
                   And b.Fec_Crre = &pd_fech_crre                   
                   And b.Tip_Regi = 2
                   /*And p.cod_clie = &pn_codi_clie
                   And p.cod_subb_tipo_conf = 1
                   And p.nro_subb_tipo_conf = 8*/
                 Group By a.Cod_Punt, a.Cod_Punt_Equi, a.Fec_Crre, a.Cod_Usua,
                          b.Tip_Rcau, nvl(b.cod_grup_tarj,0)) b
         Where a.Cod_Punt = b.Cod_Punt
           And a.Cod_Punt_Equi = b.Cod_Punt_Equi 
           And a.Fec_Crre = b.Fec_Crre
           And a.Cod_Usua = b.Cod_Usua
           And a.Tip_Rcau = b.Tip_Rcau 
           And a.cod_grup_tarj = b.cod_grup_tarj
           And (Select Count(1)
                 From clmd_punt_rcau_acti e, ve_punto f
                Where e.cod_punt = f.cod_punt
                  And e.cod_equi_punt = a.Cod_Punt_Equi
                  --And e.cod_punt = a.cod_punt
                  And f.cod_clie_grup = &pn_codi_clie
                  And e.fec_inic_oper Is Not Null
                  And e.fec_inic_oper <= &pd_fech_crre
                  And Nvl(e.fec_finl_oper, Trunc(Sysdate)) >= &pd_fech_crre) > 0
           ) c, 
         ( Select a.cod_tipo_rcau, Nvl(b.cod_tipo_conf, 0) cod_tipo_conf, a.des_rcau, b.des_grup 
                 From (Select a.Nro_Subb_Tipo_Conf cod_tipo_rcau, 0 cod_tipo_conf, a.Des_Conf des_rcau
                         From Canales.Clmc_Maes_Conf_Rcau a, Clmd_Conf_Clie_Rcau b
                        Where a.Cod_Subb_Tipo_Conf = b.Cod_Subb_Tipo_Conf
                          And a.Nro_Subb_Tipo_Conf = b.Nro_Subb_Tipo_Conf
                          And b.Cod_Clie = &pn_codi_clie
                          And a.Cod_Subb_Tipo_Conf = 2
                          And a.Ind_Acti = 1) a,
                      (Select 2 cod_tipo_rcau, a.cod_tipo_conf, a.Des_Conf des_grup
                         From Canales.Clmc_Maes_Conf_Rcau a, Clmd_Conf_Clie_Rcau b
                        Where a.Cod_Subb_Tipo_Conf = b.Cod_Subb_Tipo_Conf
                          And a.Nro_Subb_Tipo_Conf = b.Nro_Subb_Tipo_Conf
                          And b.Cod_Clie = &pn_codi_clie
                          And a.Cod_Subb_Tipo_Conf = 3
                          And a.Ind_Acti = 1) b
                Where a.cod_tipo_rcau = b.cod_tipo_rcau(+) ) d
        Where c.tip_rcau = d.cod_tipo_rcau
          And c.cod_grup_tarj = d.cod_tipo_conf 
          And c.mon_dife <> 0 
       Order By c.Cod_Punt_Equi, c.Cod_Punt, c.Fec_Crre, c.Cod_Usua,  
                c.Tip_Rcau, c.cod_grup_tarj;
