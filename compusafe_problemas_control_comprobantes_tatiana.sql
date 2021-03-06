--problema
el cs estaba no estaba ne la tabla CSAFE.CSTD_CMPB_CUDR_REGU, esta tabla se llena al dar fase 1
al parecer no encontro la cuenta de fondo de diferencia al momento que se ejecuto fase 1
--
Select * From VE_PUNTO WHERE DES_PUNT LIKE '%BRATA%';

Select * From tv_cmpb_serv WHERE NUM_CMPB=90222562;
--ver lista de cs fisicos
Select (select sum(z.mon_valo_prod) from tvtd_mont_cmpb_bove z 
           where z.num_cmpb=t.num_cmpb 
           and z.cod_seri_cmpb=t.cod_seri_cmpb
           and z.tip_docu_cmpb=t.tip_docu_cmpb
           and z.cod_bove in (1,2)) mont_cont,
           (select sum(z.Cod_Bove) from tvtd_mont_cmpb_bove z 
           where z.num_cmpb=t.num_cmpb 
           and z.cod_seri_cmpb=t.cod_seri_cmpb
           and z.tip_docu_cmpb=t.tip_docu_cmpb
           and z.cod_bove in (1,2)) COD_BOVE,
           T.COD_PUNT_ORIG,
           t.*
  From tv_cmpb_serv t
 where t.cod_punt_orig IN (25004)
   and t.fec_emis > sysdate - 40
   and not exists (select 1
          from cstd_proc_hora_deta a
         where a.num_cmpb = t.num_cmpb
           and a.tip_docu_cmpb = t.tip_docu_cmpb
           and a.cod_seri_cmpb = t.cod_seri_cmpb)
   and not exists (select 1 from tvtd_mont_cmpb_bove a
         where a.num_cmpb = t.num_cmpb
           and a.tip_docu_cmpb = t.tip_docu_cmpb
           and a.cod_seri_cmpb = t.cod_seri_cmpb
           and a.cod_bove=2)
 order by t.fec_emis desc;
 --comprobante faltante = A01 80097797. se identifico por el monto
--aqui no beio haber salido
 Select s.cod_clie_fond,z.cod_clie_cnta--*
   From cwtc_rweb_cmpb z, shmc_usua_fond s
  Where z.num_cmpb = 90222562 --lr_cmpb.NUM_CMPB
    And z.cod_seri_cmpb = 'A01' --lr_cmpb.cod_seri_cmpb
    And z.tip_docu_cmpb = 'CS' --lr_cmpb.tip_docu_cmpb            
    And s.ind_comp_safe = 1
    And s.cod_punt = z.cod_punt_orig
    And s.cod_sucu_fond = z.cod_sucu_htb
    And rownum < 2
    --And z.cod_clie_cnta = 2113 --shpg_cte.kn_clie_fond_dife_3556;       
    And s.cod_clie_fond = z.cod_clie_cnta
--
 Select z.cod_clie_cnta,z.* From cwtc_rweb_cmpb z where z.num_cmpb=90222562;--25004  z
 Select s.cod_clie_fond,s.* From shmc_usua_fond s where 
--solucion
 Insert Into CSAFE.CSTD_CMPB_CUDR_REGU
   (COD_SUCU_HTB,
    NUM_CMPB,
    COD_SERI_CMPB,
    TIP_DOCU_CMPB,
    COD_BOVE,
    NOM_COMP_CREA,
    COD_USUA_CREA,
    FEC_CREA,
    NOM_COMP_MODI,
    COD_USUA_MODI,
    FEC_MODI)
   SELECT cod_sucu_htb,
          num_cmpb,
          cod_seri_cmpb,
          tip_docu_cmpb,
          cod_bove,
          nom_comp_crea,
          cod_usua_crea,
          fec_crea,
          nom_comp_modi,
          COD_USUA_MODI,
          fec_modi
     FROM CSWEB.CWTD_RWEB_CMPB_BOVE
    WHERE NUM_CMPB = 90222562;
 Update csweb.cwtc_rweb_cmpb
    set ind_ingr_manu = 1, tip_cmpb_safe = 2
  Where num_cmpb = 90222562
    and cod_seri_cmpb = 'A01'
    and tip_docu_cmpb = 'CS';

--listados de CS
 Select tab.cod_bove, (Select
                Case
                  When tab.fec_env = (Select min(fec.fec_crea) fecha
                                            From csweb.cwtc_rweb_cmpb fec, csafe.cstd_cmpb_cudr_regu cu
                                            Where fec.num_cmpb = cu.num_cmpb
                                            And fec.cod_seri_cmpb = cu.cod_seri_cmpb
                                            And fec.tip_docu_cmpb = cu.tip_docu_cmpb
                                            And cu.ind_conf_cicl =1
                                            And fec.ind_acti = 1
                                            And fec.tip_cmpb_safe = 2
                                            And fec.tip_orig_cmpb_virt = 3
                                            And fec.cod_punt_orig = &pn_cod_pto
                                            And cu.cod_bove = &pn_cod_bov ) Then
                    Case
                      When tab.tipo_cs = 'FISICO' And tab.ind_acti = 1 And
                            (Select cu.ind_conf_cicl
                                            From csafe.cstd_cmpb_cudr_regu cu
                                            Where tab.num_cs = cu.num_cmpb
                                            And tab.tipo_num_cs = cu.cod_seri_cmpb
                                            And tab.tip_docu_cmpb = cu.tip_docu_cmpb
                                            And cu.ind_conf_cicl =1
                                            And tab.ind_acti = 1
                                            And cu.cod_bove = &pn_cod_bov) = 1
                             And tab.est = 'RECOGIDA'Then 1
                      Else 0
                     End
                   Else 0
                  End result_set
                From dual) ind_cu,
          tab.tipo_cs,
          tab.tipo_csv,
          tab.fec_gene,
          tab.fec_env,
          tab.tipo_num_cs,
          tab.num_cs,
          tab.est,
          tab.hw,
          tab.mont_virt,
          tab.mont_fisi,
          tab.tip_dscu,
          tab.mont_dscu,
          tab.mont_regu,
          tab.ref_regu,
          tab.fec_regu,
          tab.reg_col,
          tab.ind_conf_cicl,
          tab.ind_cudr,
          tab.tip_docu_cmpb,
          tab.fec_cicl,
          tab.tip_docu_cmpb_conf,
          tab.cod_seri_cmpb_conf,
          tab.num_cmpb_conf,
          tab.ind_acti
            From(
              Select
                (Select
                Case
                  When csweb.tip_cmpb_safe  = 2 Then 'FISICO'
                  Else 'VIRTUAL'
                  End result_set
                From dual) tipo_cs, --Tipo CS
              (Select tip.des_tipo_cort From tg_tabl_tipo tip
              Where cod_grup_tipo=907
              And tip.cod_tipo = csweb.tip_cmpb_safe) tipo_csv, --Tipo CSV
              tv.fec_proc_aper fec_gene, --Fecha de Generaci�n --fecha de apertura boveda OA 23/07/2014
              csweb.fec_crea fec_env,--Fecha de Env�o
              csweb.cod_seri_cmpb tipo_num_cs, -- Serie de CS
              csweb.num_cmpb num_cs, --N�mero CS
              (Select
              Case
                When csweb.tip_cmpb_safe  != 2 Then
                  Case
                    When 1 != 1 Then
                          Case
                            When (Select te.cod_estd From general.tg_tabl_estd te
                             Where te.cod_estd = To_char(csweb.est_cmpb_virt)
                                And te.cod_grup_estd = 201) = 4 Then 'PAGADO'
                          Else
                              (Select te.des_estd From general.tg_tabl_estd te
                                     Where te.cod_estd=(Select te.cod_estd From general.tg_tabl_estd te
                                      Where te.cod_estd = To_char(csweb.est_cmpb_virt)
                                      And te.cod_grup_estd = 201)
                                      And te.cod_grup_estd = 201)
                          End
                   Else
                      Case
                        When (Select te.cod_estd From general.tg_tabl_estd te
                              Where te.cod_estd = To_char(csweb.est_cmpb_virt)
                                    And te.cod_grup_estd = 201 )=4 Then
                              Case
                                When (Select Distinct ac.est_item_pedi From csweb.cwtd_rweb_cmpb_bove bove, apertura.ac_pedido_deta ac
                                             Where bove.tip_docu_cmpb = csweb.tip_docu_cmpb
                                                   And bove.cod_seri_cmpb = csweb.cod_seri_cmpb
                                                   And bove.num_cmpb = csweb.num_cmpb
                                                   And bove.tip_docu_cmpb_sali = ac.tip_docu_cmpb
                                                   And bove.cod_seri_cmpb_sali = ac.cod_seri_cmpb
                                                   And bove.num_cmpb_sali = ac.num_cmpb
                                                   And bove.cod_bove = &pn_cod_bov)=6 Then 'PAGADO'
                               Else 'SALIDA'
                               End
                      Else
                             (Select te.des_estd From general.tg_tabl_estd te
                                     Where te.cod_estd=(Select te.cod_estd From general.tg_tabl_estd te
                                      Where te.cod_estd = To_char(csweb.est_cmpb_virt)
                                      And te.cod_grup_estd = 201)
                                      And te.cod_grup_estd = 201)
                       End
                   End
              Else
                (Select des_estd From general.tg_tabl_estd Where cod_grup_estd=13
                And cod_estd = (Select reme.est_reme From btms.bt_remesa reme
                                      Where reme.num_cmpb = csweb.num_cmpb
                                        And reme.cod_seri_cmpb = csweb.cod_seri_cmpb
                                        And reme.tip_docu_cmpb = csweb.tip_docu_cmpb))
              End result_set
              From dual) est,--Estado
              (Select
              Case
              When
                (Select 1 From dual Where Exists (Select * From apertura.ac_cntas_clie ac_cli
                                                Where ac_cli.tip_docu_cmpb = csweb.tip_docu_cmpb
                                                And ac_cli.num_cmpb = csweb.num_cmpb
                                                And ac_cli.cod_seri_cmpb = csweb.cod_seri_cmpb
                                                And ac_cli.ind_gen_arch = 1
                                                And ac_cli.fec_gen_arch Is Not Null))=1 Then 1
              Else 0
               End result_set
               From dual) hw,--HW
              (Select
              Case
                When
                  csweb.ind_acti = 1 Then
                  Case
                    When csweb.tip_cmpb_safe  != 2 Then
                      (Select bove.mon_valo From csweb.cwtd_rweb_cmpb_bove bove, csafe.cstd_cmpb_cudr_regu cu
                        Where bove.cod_seri_cmpb = csweb.cod_seri_cmpb
                          And bove.tip_docu_cmpb = csweb.tip_docu_cmpb
                          And bove.num_cmpb = csweb.num_cmpb
                          And bove.num_cmpb = cu.num_cmpb
                          And bove.cod_seri_cmpb = cu.cod_seri_cmpb
                          And bove.tip_docu_cmpb = cu.tip_docu_cmpb
                          And bove.cod_bove = cu.cod_bove
                          And bove.cod_bove = &pn_cod_bov)
                  Else Null
                  End
                Else Null
              End result_set
              From dual) mont_virt,--Monto Virtual
              (Select
              Case
                When
                  csweb.ind_acti = 1 Then
                  Case
                    When csweb.tip_cmpb_safe != 2 Then Null
                  Else
                        Case
                                When (Select des_estd From general.tg_tabl_estd Where cod_grup_estd=13
                                        And cod_estd = (Select reme.est_reme From btms.bt_remesa reme
                                          Where reme.num_cmpb = csweb.num_cmpb
                                            And reme.cod_seri_cmpb = csweb.cod_seri_cmpb
                                            And reme.tip_docu_cmpb = csweb.tip_docu_cmpb)) = 'RECOGIDA' Then
                                            shpg_cons_comp_serv.shfu_cont_bove(1,
                                                                               csweb.tip_docu_cmpb,
                                                                               csweb.cod_seri_cmpb,
                                                                               csweb.num_cmpb,
                                                                               1,
                                                                               &pn_cod_bov)
                               Else
                                   (Select bove.mon_valo From csweb.cwtd_rweb_cmpb_bove bove, csafe.cstd_cmpb_cudr_regu cu
                                            Where bove.cod_seri_cmpb = csweb.cod_seri_cmpb
                                              And bove.tip_docu_cmpb = csweb.tip_docu_cmpb
                                              And bove.num_cmpb = csweb.num_cmpb
                                              And bove.num_cmpb = cu.num_cmpb
                                              And bove.cod_seri_cmpb = cu.cod_seri_cmpb
                                              And bove.tip_docu_cmpb = cu.tip_docu_cmpb
                                              And bove.cod_bove = cu.cod_bove
                                              And bove.cod_bove = &pn_cod_bov)
                             End
                  End
                Else 0
              End result_set
              From dual) mont_fisi,--Monto F�sico
              (Select
                Case
                  When csweb.tip_cmpb_safe  = 2 Then
                    Case
                      When (Select cu.mon_dscu_cmpb From csafe.cstd_cmpb_cudr_regu cu
                               Where cu.num_cmpb = csweb.num_cmpb
                               And cu.cod_seri_cmpb = csweb.cod_seri_cmpb
                               And cu.tip_docu_cmpb = csweb.tip_docu_cmpb
                               And cu.cod_bove = &pn_cod_bov) > 0 Then 'SOBRANTE'
                      Else
                        Case
                          When (Select cu.mon_dscu_cmpb From csafe.cstd_cmpb_cudr_regu cu
                               Where cu.num_cmpb = csweb.num_cmpb
                               And cu.cod_seri_cmpb = csweb.cod_seri_cmpb
                               And cu.tip_docu_cmpb = csweb.tip_docu_cmpb
                               And cu.cod_bove = &pn_cod_bov) < 0 Then 'FALTANTE'
                        Else 'SIN DSCDRE'
                        End
                      End
                  Else ''
                End result_set
               From dual) tip_dscu,--Tipo Descuadre
             (Select
               Case
                 When csweb.tip_cmpb_safe  = 2 Then
                   Case
                     When (Select cu.ind_cudr
                          From csafe.cstd_cmpb_cudr_regu cu
                          Where cu.num_cmpb = csweb.num_cmpb
                          And cu.cod_seri_cmpb = csweb.cod_seri_cmpb
                          And cu.tip_docu_cmpb = csweb.tip_docu_cmpb
                          And cu.cod_bove = &pn_cod_bov) != 3 Then
                       Case
                         When (Select cu.mon_dscu_cmpb From csafe.cstd_cmpb_cudr_regu cu
                               Where cu.num_cmpb = csweb.num_cmpb
                               And cu.cod_seri_cmpb = csweb.cod_seri_cmpb
                               And cu.tip_docu_cmpb = csweb.tip_docu_cmpb
                               And cu.cod_bove = &pn_cod_bov) != 0 Then

                            (Select cu.mon_dscu_cmpb From csafe.cstd_cmpb_cudr_regu cu
                               Where cu.num_cmpb = csweb.num_cmpb
                               And cu.cod_seri_cmpb = csweb.cod_seri_cmpb
                               And cu.tip_docu_cmpb = csweb.tip_docu_cmpb
                               And cu.cod_bove = &pn_cod_bov)
                         Else 0
                       End
                     Else Null
                     End
                 Else Null
               End result_set
               From dual) mont_dscu,--Monto Descuadre
             (Select
                Case
                    When csweb.tip_cmpb_safe  = 2 Then

                     (Select mon_dscu_cmpb From csafe.cstd_cmpb_cudr_regu cu2
                             Where cu2.num_cmpb = csweb.num_cmpb
                               And cu2.cod_seri_cmpb = csweb.cod_seri_cmpb
                               And cu2.tip_docu_cmpb = csweb.tip_docu_cmpb
                               And cu2.cod_bove = &pn_cod_bov)
                     Else Null
                     End result_set
                  From dual) mont_regu, --Monto Regularizado
             (Select
                Case
                    When csweb.tip_cmpb_safe  = 2 Then
                      (Select ref_regu_cmpb From csafe.cstd_cmpb_cudr_regu cu3
                     Where cu3.num_cmpb = csweb.num_cmpb
                       And cu3.cod_seri_cmpb = csweb.cod_seri_cmpb
                       And cu3.tip_docu_cmpb = csweb.tip_docu_cmpb
                       And cu3.cod_bove = &pn_cod_bov)
                     Else Null
                     End result_set
                  From dual) ref_regu, --Referencia Regularizaci�n
             (Select
                Case
                    When csweb.tip_cmpb_safe  = 2 Then
                      (Select fec_refe_regu From csafe.cstd_cmpb_cudr_regu cu3
                     Where cu3.num_cmpb = csweb.num_cmpb
                       And cu3.cod_seri_cmpb = csweb.cod_seri_cmpb
                       And cu3.tip_docu_cmpb = csweb.tip_docu_cmpb
                       And cu3.cod_bove = &pn_cod_bov)
                     Else Null
                     End result_set
                  From dual) fec_regu, --Fecha de Regularizaci�n
             (Select
             Case
                   When csweb.tip_cmpb_safe=2 And
                  ((Select cu.ind_conf_cicl From csafe.cstd_cmpb_cudr_regu cu
                           Where cu.num_cmpb = csweb.num_cmpb
                           And cu.cod_seri_cmpb = csweb.cod_seri_cmpb
                           And cu.tip_docu_cmpb = csweb.tip_docu_cmpb
                           And cu.cod_bove = &pn_cod_bov) <= 1 Or
                     (Select cu.ind_conf_cicl From csafe.cstd_cmpb_cudr_regu cu
                           Where cu.num_cmpb = csweb.num_cmpb
                           And cu.cod_seri_cmpb = csweb.cod_seri_cmpb
                           And cu.tip_docu_cmpb = csweb.tip_docu_cmpb
                           And cu.cod_bove = &pn_cod_bov) Is Null) And
                           csweb.ind_acti != 0 Then 'AMARILLO'
                 When csweb.tip_cmpb_safe=2 And
                   (Select cu.ind_conf_cicl From cstd_cmpb_cudr_regu cu
                           Where cu.num_cmpb = csweb.num_cmpb
                           And cu.cod_seri_cmpb = csweb.cod_seri_cmpb
                           And cu.tip_docu_cmpb = csweb.tip_docu_cmpb
                           And csweb.ind_acti != 0
                           And cu.cod_bove = &pn_cod_bov) = 2 Then 'NARANJA'
                 When csweb.tip_cmpb_safe In (1,3) And
                      csweb.est_cmpb_virt != 4 Then 'ROJO'
                 When csweb.tip_cmpb_safe=2 And
                      csweb.ind_acti = 0 Then 'PLOMO'
                 Else 'BLANCO'
               End result_set
               From dual) reg_col, --Color
               (Select cu.ind_conf_cicl From cstd_cmpb_cudr_regu cu
               Where cu.num_cmpb = csweb.num_cmpb
               And cu.cod_seri_cmpb = csweb.cod_seri_cmpb
               And cu.tip_docu_cmpb = csweb.tip_docu_cmpb
               And cu.cod_bove = &pn_cod_bov) ind_conf_cicl,
               (Select cu.ind_cudr From cstd_cmpb_cudr_regu cu
               Where cu.num_cmpb = csweb.num_cmpb
               And cu.cod_seri_cmpb = csweb.cod_seri_cmpb
               And cu.tip_docu_cmpb = csweb.tip_docu_cmpb
               And cu.cod_bove = &pn_cod_bov) ind_cudr,
               csweb.tip_docu_cmpb,
               (Select cu.fec_cicl From csafe.cstd_cmpb_cudr_regu cu
                       Where cu.cod_seri_cmpb = csweb.cod_seri_cmpb
                       And cu.num_cmpb = csweb.num_cmpb
                       And cu.tip_docu_cmpb = csweb.tip_docu_cmpb
                       And ind_conf_cicl =1
                       And cu.cod_bove = &pn_cod_bov) fec_cicl, --fecha de ciclo
               (Select cu.tip_docu_cmpb_conf From csafe.cstd_cmpb_cudr_regu cu
                       Where cu.cod_seri_cmpb = csweb.cod_seri_cmpb
                       And cu.num_cmpb = csweb.num_cmpb
                       And cu.tip_docu_cmpb = csweb.tip_docu_cmpb
                       And cu.cod_bove = &pn_cod_bov) tip_docu_cmpb_conf,--tipo de documento
               (Select cu.cod_seri_cmpb_conf From csafe.cstd_cmpb_cudr_regu cu
                       Where cu.cod_seri_cmpb = csweb.cod_seri_cmpb
                       And cu.num_cmpb = csweb.num_cmpb
                       And cu.tip_docu_cmpb = csweb.tip_docu_cmpb
                       And cu.cod_bove = &pn_cod_bov) cod_seri_cmpb_conf,--codigo de serie
               (Select cu.num_cmpb_conf From csafe.cstd_cmpb_cudr_regu cu
                       Where cu.cod_seri_cmpb = csweb.cod_seri_cmpb
                       And cu.num_cmpb = csweb.num_cmpb
                       And cu.tip_docu_cmpb = csweb.tip_docu_cmpb
                       And cu.cod_bove = &pn_cod_bov) num_cmpb_conf, --numero de comprobante
               csweb.ind_acti ind_acti,
               (Select cu.cod_bove From csafe.cstd_cmpb_cudr_regu cu
                       Where cu.cod_seri_cmpb = csweb.cod_seri_cmpb
                       And cu.num_cmpb = csweb.num_cmpb
                       And cu.tip_docu_cmpb = csweb.tip_docu_cmpb
                       And cu.cod_bove = &pn_cod_bov) cod_bove
            From csweb.cwtc_rweb_cmpb csweb, tv_cmpb_serv tv
            Where csweb.cod_sucu_htb = 1
              And csweb.cod_clie = &pn_cod_clie
              And csweb.cod_punt_orig = &pn_cod_pto
              And csweb.tip_cmpb_safe In (1, 2, 3)
              --comprobantes virtuales pendientes OA 23/07/2014 REQ:2284
              And tv.cod_sucu_htb(+) = csweb.cod_sucu_htb
              And tv.cod_clie(+) = csweb.cod_clie
              And tv.cod_punt_orig(+) = csweb.cod_punt_orig
              And tv.cod_seri_cmpb(+) = csweb.cod_seri_cmpb
              And tv.tip_docu_cmpb(+) = csweb.tip_docu_cmpb
              And tv.num_cmpb(+) = csweb.num_cmpb
              --fin OA 23/07/2014 REQ:2284
              --Consulta s�lo para el rango de fechas contables ingresado PC 19/08/2014 REQ:2542 
              And ((csweb.est_cmpb_virt = 1 And csweb.fec_crea >= &pd_fec_ini And csweb.fec_crea <= &pd_fec_fin) 
                    Or (csweb.est_cmpb_virt <> 1 And tv.fec_proc_aper >= &pd_fec_ini And tv.fec_proc_aper <= &pd_fec_fin ))
                    and tv.num_cmpb=90222562
              Order By tv.fec_crea Asc
              --fin PC 19/08/2014 REQ:2542
              )tab Where ((tab.tipo_cs='VIRTUAL' And tab.ind_acti = 1 ) Or
                         (tab.tipo_cs = 'FISICO'
                         And Not Exists(Select 1 from tv_cmpb_serv serv
                             Where serv.num_cmpb = tab.num_cs
                             And serv.cod_seri_cmpb = tab.tipo_num_cs
                             And serv.tip_docu_cmpb = tab.tip_docu_cmpb
                             And serv.est_docu = 11)))
              And tab.cod_bove = &pn_cod_bov;
