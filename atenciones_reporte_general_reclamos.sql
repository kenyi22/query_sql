Select a.cod_aten, 
                 a.fec_real, 
                 a.cod_tipo, 
                 Initcap(SAPG_ATEN_RECL.safu_desc_cons(1,a.cod_tipo,Null)) des_proc,
                 a.nse_sub_tipo, 
                 Initcap(SAPG_ATEN_RECL.safu_desc_cons(2,a.cod_tipo,a.nse_sub_tipo)) des_aten,
                 a.cod_estd,
                 Upper(SAPG_ATEN_RECL.safu_desc_esta(a.cod_estd)) des_esta,
                 a.ano_corr||a.num_corr num_sac
            From tvtc_regi_aten  a
           Where --a.cod_aten = Nvl(pn_nume_aten,a.cod_aten)
             --And a.ano_corr||a.num_corr = Nvl(pv_nume_sac,a.ano_corr||a.num_corr)
             --And a.cod_sucu_htb = Nvl(pn_cod_sucu,a.cod_sucu_htb)
             --And (a.cod_tipo_clie =  Nvl(pn_tipo_clie,a.cod_tipo_clie) Or  pn_tipo_clie = 0)
             --And a.cod_punt_afec = Nvl(pn_punt,a.cod_punt_afec)

             /*And*/ Trunc(a.fec_regi) <= sysdate
             And Trunc(a.fec_regi) >= Sysdate - Nvl(360,0)
/*             And Exists (Select 1 
                           From ve_punto v 
                          Where v.cod_punt = a.cod_punt_afec
                            And v.cod_clie_grup = Nvl('%',v.cod_clie_grup)
                           And Exists (Select 1 
                                         From ve_cliente b
                                        Where b.cod_clie = v.cod_clie_grup
                                          And ((b.cod_corp = pn_cod_corp And pn_cod_corp Is Not Null) Or pn_cod_corp Is Null)
                                          And a.cod_tipo_clie = 1)
                         Union
                        Select 1 
                          From vd_punto c
                         Where c.cod_punt = a.cod_punt_afec 
                           And c.cod_clie_grup = Nvl(pn_clie,c.cod_clie_grup)
                           And Exists (Select 1  
                                         From vd_cliente d
                                        Where d.cod_clie = c.cod_clie_grup
                                          And ((d.cod_corp = pn_cod_corp And pn_cod_corp Is Not Null) Or pn_cod_corp Is Null)
                                          And a.cod_tipo_clie = 2))*/
           --And (a.cod_usua_regi = pv_cod_usua_regi Or pv_cod_usua_regi Is Null)
           --And (a.cod_usua_asig = pv_cod_usua_asig Or pv_cod_usua_asig Is Null)
             And a.cod_tipo = Nvl(10,a.cod_tipo)
             --And a.nse_sub_tipo = Nvl(pn_aten,a.nse_sub_tipo)           
           Order By a.cod_aten Desc;
