   select asd.*,
        (select des_estd
                from tg_tabl_estd
               where cod_grup_estd = 2
                 and cod_estd = qwe.est_docu) EST_7_COMPR,
                 (select DES_TRNP
                from TV_TRANSPORTA
               where COD_TRNP = qwe.cod_trnp_reco) "4_TRANSPORTADORA",
               (select des_tipo
                from TG_TABL_TIPO
               where cod_grup_tipo = 30
                 and cod_tipo = qwe.tip_orig) "5_TIP_ORIGEN/DESTINO",
                 (select des_tipo
                from tg_tabl_tipo
               where cod_grup_tipo = 555
                 and cod_tipo = qwe.tip_orig) TIP_2_PROD, 
                           
                shpg_cons_comp_serv.SHFU_CONT_BOVE((select COD_TIPO
                from tg_tabl_tipo
               where cod_grup_tipo = 555
                 and cod_tipo = qwe.tip_orig),qwe.tip_docu_cmpb,qwe.cod_seri_cmpb,qwe.num_cmpb,1,1) "1_CONT_SOLES",
         
                shpg_cons_comp_serv.SHFU_CONT_BOVE((select COD_TIPO
                from tg_tabl_tipo
               where cod_grup_tipo = 555
                 and cod_tipo = qwe.tip_orig),qwe.tip_docu_cmpb,qwe.cod_seri_cmpb,qwe.num_cmpb,1,3) "1_CONT_DOLARES",
                 (SELECT
       NUM_CINT
        FROM BT_REMESA
       WHERE       TIP_DOCU_CMPB = qwe.tip_docu_cmpb
       AND       COD_SERI_CMPB = qwe.cod_seri_cmpb
       AND       NUM_CMPB = qwe.num_cmpb
       AND       ROWNUM = 1) "9_NUM_CINT",
       
       (select 
              (select des_moti
                from tg_motivo t
               where cod_grup_moti = 19
                and                    cod_moti <> 0
                AND                    cod_moti =
                     (select b.mot_svno_fact
                        from bt_remesa b
                       where num_cmpb = qwe.num_cmpb
                         and cod_seri_cmpb = qwe.cod_seri_cmpb
                         and tip_docu_cmpb = qwe.tip_docu_cmpb))
        from tv_cmpb_serv
       where num_cmpb = qwe.num_cmpb
        and             cod_seri_cmpb = qwe.cod_seri_cmpb
         and             tip_docu_cmpb = qwe.tip_docu_cmpb)"6_MOT_NO_APLICABLE",
         
       (select can_totl_enva from tv_cmpb_serv where num_cmpb = qwe.num_cmpb
        and             cod_seri_cmpb = qwe.cod_seri_cmpb
         and             tip_docu_cmpb = qwe.tip_docu_cmpb)"3_envases" 
   from tv_cmpb_serv qwe,(SELECT to_char(Fecha, 'dd/mm/yyyy') fecha,
       Sucursal,
       Ruta,
       Des_Cod_Punt,
       des_razo_soci,--LRIOS
       tipo_servicio,
       hora,
       tip_docu_cmpb,
       cod_seri_cmpb,
       num_cmpb,
       Soles,
       Dolares,
       cod_punt,
       nse_punt_radi
  FROM (
         --envios
         Select Fecha,
                 Sucursal,
                 Ruta,
                 Des_Cod_Punt,
                 Des_Razo_Soci,
                 to_char(Tip_Servicio) tipo_servicio,
                 to_char(Hora_Llegada, 'hh24:mi:ss') hora,
                 tip_docu_cmpb,
                 cod_seri_cmpb,
                 num_cmpb,
                 Soles,
                 Dolares,
                 cod_punt,
                 nse_punt_radi
           From (Select t.Fec_Dest Fecha,
                         (Select Des_Sucu_Htb
                            From Tg_Sucursal_Htb
                           Where Cod_Sucu_Htb = t.Cod_Sucu_Htb) Sucursal,
                         t.Cod_Ruta_Dest Ruta,
                         (Select a.Des_Punt
                            From Ve_Punto a
                           Where a.Cod_Punt = t.Cod_Punt_Dest) Des_Cod_Punt,
                         (Select a.Des_razo_soci
                            From Vemc_razo_soci a
                           Where a.cod_razo_soci =
                                 (select cod_razo_soci
                                    from ve_cliente
                                   where cod_clie =
                                         (select cod_clie_grup
                                            from ve_punto
                                           where cod_punt = t.cod_punt_dest))
                             and rownum = 1) Des_Razo_Soci,--LRIOS
                         Decode((Select 1
                                  From Ve_Punto a
                                 Where a.Tip_Punt = 11
                                   And a.Cod_Punt = t.Cod_Punt_Dest),
                                1,
                                'ABASTECIMIENTO',
                                'ENVIO') Tip_Servicio,
                         (Select b.Hor_Lleg_Punt
                            From Cbtd_Hoja_Ruta b
                           Where (b.ind_reco != 1 and b.ind_mant != 1) --jz_07072014
                             And Nvl(b.Tip_Novd_Punt, 7) = 7
                             And Nvl(b.Ind_Cmpb_Visi, 0) = 0
                             And b.Ind_Anul != 1
                             and (b.hor_lleg_punt is not null and
                                 (nvl(b.Cod_Ruta_Trnf, 1) > 0 or
                                 nvl(b.Cod_turn_Trnf, 1) > 0))
                             And b.Fec_Prgn = t.Fec_Dest
                             And b.Cod_Punt = t.Cod_Punt_Dest
                             And b.Cod_Ruta = t.Cod_Ruta_Dest
                             and rownum = 1) Hora_Llegada,

                         Sum(Nvl((Select sum(a.Mon_Valo_Prod)
                                   From Tvtd_Mont_Cmpb_Bove a
                                  Where a.Num_Cmpb = t.Num_Cmpb
                                    And a.Cod_Seri_Cmpb = t.Cod_Seri_Cmpb
                                    And a.Tip_Docu_Cmpb = t.Tip_Docu_Cmpb
                                    And a.Cod_Sucu_Htb = t.Cod_Sucu_Htb
                                    And a.Cod_Bove in
                                        (select distinct bb.cod_bove
                                           from ac_boveda bb
                                          where bb.tip_unid_mone = 2
                                            and bb.cod_sucu_htb = t.cod_sucu_htb)),
                                 0)) Soles,
                         Sum(Nvl((Select sum(a.Mon_Valo_Prod)
                                   From Tvtd_Mont_Cmpb_Bove a
                                  Where a.Num_Cmpb = t.Num_Cmpb
                                    And a.Cod_Seri_Cmpb = t.Cod_Seri_Cmpb
                                    And a.Tip_Docu_Cmpb = t.Tip_Docu_Cmpb
                                    And a.Cod_Sucu_Htb = t.Cod_Sucu_Htb
                                    And a.Cod_Bove in
                                        (select distinct bb.cod_bove
                                           from ac_boveda bb
                                          where bb.tip_unid_mone = 1
                                            and bb.cod_sucu_htb = t.cod_sucu_htb)),
                                 0)) Dolares,
                         t.tip_docu_cmpb,
                         t.cod_seri_cmpb,
                         t.num_cmpb,
                         t.Cod_Punt_Dest cod_punt,
                         t.nse_punt_dest nse_punt_radi
                    From Tv_Cmpb_Serv t
                   Where T.TIP_DOCU_CMPB = 'CS'
                     AND t.Tip_Form_Tras = 1
                     AND T.TIP_DEST = 1
                   Group By t.Fec_Proc,
                            t.Cod_Ruta_Dest,
                            t.Cod_Punt_Dest,
                            t.Cod_Sucu_Htb,
                            t.Fec_Dest,
                            t.tip_docu_cmpb,
                            t.cod_seri_cmpb,
                            t.num_cmpb,
                            t.cod_clie,
                            t.cod_punt_dest,
                            t.nse_punt_dest) m
          Where (m.Dolares > 0 Or m.Soles > 0)
         UNION
         ---RECOJOS
         Select Fecha,
                Sucursal,
                Ruta,
                Des_Cod_Punt,
                Des_Razo_Soci,
                to_char(Tipo),
                to_char(Hora_Llegada, 'hh24:mi:ss'),
                tip_docu_cmpb,
                cod_seri_cmpb,
                num_cmpb,
                Soles,
                Dolares,
                cod_punt,
                nse_punt_radi
           From (Select t.Fec_Orig Fecha,
                        (Select Des_Sucu_Htb
                           From Tg_Sucursal_Htb
                          Where Cod_Sucu_Htb = t.Cod_Sucu_Htb) Sucursal,
                        t.cod_ruta_orig Ruta,
                        (Select a.Des_Punt
                           From Ve_Punto a
                          Where a.Cod_Punt = t.Cod_Punt_Orig) Des_Cod_Punt,
                        (Select a.Des_razo_soci
                           From Vemc_razo_soci a
                          Where a.cod_razo_soci =
                                (select cod_razo_soci
                                   from ve_cliente
                                  where cod_clie =
                                        (select cod_clie_grup
                                           from ve_punto
                                          where cod_punt = t.cod_punt_orig))
                            and rownum = 1) Des_Razo_Soci,--LRIOS
                        'RECOJO' Tipo,
                        (Select b.Hor_Lleg_Punt
                           From Cbtd_Hoja_Ruta b
                          Where (b.ind_envi != 1 and b.ind_mant != 1) --jz_07072014
                            And Nvl(b.Tip_Novd_Punt, 7) = 7
                            And Nvl(b.Ind_Cmpb_Visi, 0) = 0
                            And b.Ind_Anul != 1
                            and (b.hor_lleg_punt is not null and
                                (nvl(b.Cod_Ruta_Trnf, 1) > 0 or
                                nvl(b.Cod_turn_Trnf, 1) > 0))
                            And b.Fec_Prgn = t.Fec_Orig
                            And b.Cod_Punt = t.Cod_Punt_Orig
                            and b.cod_ruta = t.cod_ruta_orig
                            and rownum = 1) Hora_Llegada,
                        t.tip_docu_cmpb,
                        t.cod_seri_cmpb,
                        t.num_cmpb,
                        Sum(Nvl((Select sum(a.Mon_Valo_Prod)
                                  From Tvtd_Mont_Cmpb_Bove a
                                 Where a.Num_Cmpb = t.Num_Cmpb
                                   And a.Cod_Seri_Cmpb = t.Cod_Seri_Cmpb
                                   And a.Tip_Docu_Cmpb = t.Tip_Docu_Cmpb
                                   And a.Cod_Sucu_Htb = t.Cod_Sucu_Htb
                                   And a.Cod_Bove in
                                       (select distinct bb.cod_bove
                                          from ac_boveda bb
                                         where bb.tip_unid_mone = 2
                                           and bb.cod_sucu_htb = t.cod_sucu_htb)),
                                0)) Soles,
                        Sum(Nvl((Select sum(a.Mon_Valo_Prod)
                                  From Tvtd_Mont_Cmpb_Bove a
                                 Where a.Num_Cmpb = t.Num_Cmpb
                                   And a.Cod_Seri_Cmpb = t.Cod_Seri_Cmpb
                                   And a.Tip_Docu_Cmpb = t.Tip_Docu_Cmpb
                                   And a.Cod_Sucu_Htb = t.Cod_Sucu_Htb
                                   And a.Cod_Bove in
                                       (select distinct bb.cod_bove
                                          from ac_boveda bb
                                         where bb.tip_unid_mone = 1
                                           and bb.cod_sucu_htb = t.cod_sucu_htb)),
                                0)) Dolares,
                        t.Cod_Punt_Orig cod_punt,
                        t.nse_Punt_Orig nse_punt_radi
                   From Tv_Cmpb_Serv t
                  Where t.Tip_Form_Tras = 2
                    AND T.TIP_DOCU_CMPB = 'CS'
                    AND T.TIP_ORIG = 1
                    AND NOT EXISTS
                  (SELECT 1
                           FROM VE_PUNTO
                          WHERE TIP_PUNT = 11
                            AND COD_PUNT = T.Cod_Punt_Orig)
                  Group By t.Cod_Punt_Orig,
                           t.cod_ruta_orig,
                           t.Cod_Sucu_Htb,
                           t.Fec_Orig,
                           t.tip_docu_cmpb,
                           t.cod_seri_cmpb,
                           t.num_cmpb,
                           t.cod_clie,
                           t.Cod_Punt_Orig,
                           t.nse_Punt_Orig) m
          Where (m.Dolares > 0 Or m.Soles > 0)
         UNION

         ---MANTENIMIENTOS
         Select t.Fec_Prgn Fecha,
                (Select Des_Sucu_Htb
                   From Tg_Sucursal_Htb
                  Where Cod_Sucu_Htb = t.Cod_Sucu) Sucursal,
                t.Cod_Ruta Ruta,
                (Select a.Des_Punt
                   From Ve_Punto a
                  Where a.Cod_Punt = t.Cod_Punt) Des_Cod_Punt,
                (Select a.Des_razo_soci
                   From Vemc_razo_soci a
                  Where a.cod_razo_soci =
                        (select cod_razo_soci
                           from ve_cliente
                          where cod_clie =
                                (select cod_clie_grup
                                   from ve_punto
                                  where cod_punt = t.cod_punt))
                    and rownum = 1) Des_Razo_Soci,--LRIOS
                'MANTENIMIENTO' tipo,
                to_char(t.Hor_Lleg_Punt, 'hh24:mi:ss'),
                t.tip_docu_atm_prin,
                t.cod_seri_atm_prin,
                t.num_cmpb_atm_prin,
                0 soles,
                0 DOLARES,
                cod_punt,
                nse_punt_radi
           From Cbtd_Hoja_Ruta t
          Where /*T.FEC_PRGN >= '&FEC_INIC'
                                       AND */
          t.Cod_Ruta_Trnf Is Null
       And t.Cod_Turn_Trnf Is Null
       And t.Ind_Mant = 1
       And t.Cod_Ruta != 0
       And t.Ind_Anul != 1
       And Nvl(T.Tip_Novd_Punt, 7) = 7
         ---REMANENTES
         UNION
         select m.Fecha,
                m.Sucursal,
                m.Ruta,
                m.punto,
                m.des_razo_soci,
                m.tipo,
                m.hora,
                m.tip_docu_cmpb,
                m.cod_seri_cmpb,
                m.num_cmpb,
                sum(m.SOLES) soles,
                sum(m.DOLARES) DOLARES,
               cod_punt,
                nse_punt_radi
           from (Select
                  a.Fec_Prgn Fecha,
                  (Select Des_Sucu_Htb
                     From Tg_Sucursal_Htb
                    Where Cod_Sucu_Htb = a.Cod_Sucu) Sucursal,
                  a.Cod_Ruta Ruta,
                  (Select Des_Punt From Ve_Punto Where Cod_Punt = a.Cod_Punt) Punto,
                  (Select a.Des_razo_soci
                     From Vemc_razo_soci a
                    Where a.cod_razo_soci =
                          (select cod_razo_soci
                             from ve_cliente
                            where cod_clie =
                                  (select cod_clie_grup
                                     from ve_punto
                                    where cod_punt = a.cod_punt))
                      and rownum = 1) Des_Razo_Soci,--LRIOS
                  --Decode(b.Cod_Bove, 3, 'DOLARES', 'SOLES') Moneda,
                  'REMANENTE' tipo,
                  to_char(a.Hor_Lleg_Punt, 'hh24:mi:ss') hora,
                  b.tip_docu_cmpb,
                  b.cod_seri_cmpb,
                  b.num_cmpb,
                  --DECODE(B.COD_BOVE, 1, b.Mon_Valo_Prod) SOLES,
                  DECODE(B.COD_BOVE, 1, b.Mon_Valo_Prod,0) +
                  DECODE(B.COD_BOVE, 2, b.Mon_Valo_Prod,0) SOLES,----FBM 26/10/2016
                  DECODE(B.COD_BOVE, 3, b.Mon_Valo_Prod,0) DOLARES,
                  a.cod_punt cod_punt,
                  a.nse_punt_radi nse_punt_radi
                   From Cbtd_Hoja_Ruta a,
                        (Select m.Num_Cmpb,
                                m.Cod_Bove,
                                m.Mon_Valo_Prod,
                                m.Cod_Seri_Cmpb,
                                m.Tip_Docu_Cmpb
                           From Tvtd_Mont_Cmpb_Bove m
                          Where /*m.Cod_Seri_Cmpb = 'T01'--FBM 26/10/2016
                            and*/ m.fec_proc_aper >= to_date('15/12/2012','dd/mm/yyyy')) b
                  Where a.Num_Cmpb_Atm_Prin = b.Num_Cmpb
                    and a.cod_seri_atm_prin = b.cod_seri_cmpb
                    and a.tip_docu_atm_prin = b.tip_docu_cmpb
                    --And a.Cod_Seri_Atm_Prin = 'T01' --FBM 26/10/2016 --b.cod_seri_cmpb
                    And a.Tip_Docu_Atm_Prin = 'CS' --b.Tip_Docu_Cmpb
                       --And a.ind_atnd = '1'
                    And a.Ind_Anul != 1
                    And a.Cod_Ruta_Trnf Is Null
                    and a.ind_envi = 1
                    And Nvl(a.Ind_Cmpb_Visi, 0) = 0
                    And Nvl(a.Tip_Novd_Punt, 7) = 7
                 -- and a.Fec_Prgn >= '&FEC_INIC'
                 ) m
          group by m.Fecha,
                   m.Sucursal,
                   m.Ruta,
                   m.punto,
                   m.des_razo_soci,
                   m.tipo,
                   m.hora,
                   m.tip_docu_cmpb,
                   m.cod_seri_cmpb,
                   m.num_cmpb,
                   m.cod_punt,
                   m.nse_punt_radi
         union
         SELECT
         pm.fec_aten fecha --
        ,(Select Des_Sucu_Htb From Tg_Sucursal_Htb Where Cod_Sucu_Htb = pm.cod_sucu_htb) Sucursal--
        ,pm.cod_ruta ruta --
        ,(Select a.Des_Punt From Ve_Punto a Where a.Cod_Punt = pm.cod_cjro) punto--
        ,(Select a.Des_razo_soci From Vemc_razo_soci a Where a.cod_razo_soci = (select cod_razo_soci from ve_cliente
                                                                                    where cod_clie = (select cod_clie_grup from ve_punto
                                                                                                       where cod_punt = pm.cod_cjro))
                                                                                      and rownum = 1) Des_Razo_Soci
        ,(SELECT des_tipo
            FROM tg_tabl_tipo a
           WHERE cod_grup_tipo = 746
             and cod_tipo = re.sub_tipo_serv_atm) tipo--
        ,to_char(dh.hor_lleg,'hh24:mi:ss') hora
        ,nvl(re.tip_docu_cmpb, dh.tip_docu_atm) tip_docu_atm_prin
        ,nvl(re.cod_seri_cmpb, dh.cod_seri_atm) cod_seri_atm_prin
        ,nvl(re.num_cmpb,      dh.num_cmpb_atm) num_cmpb_atm_prin
        ,(SELECT SUM(ad.mon_deno) mon_deno
                FROM ac_cmpb_deno ad
               WHERE ad.num_cmpb = re.num_cmpb
                 AND ad.tip_unid_mone ='2'
               GROUP BY ad.tip_unid_mone) Soles
        ,(SELECT SUM(ad.mon_deno) mon_deno
                FROM ac_cmpb_deno ad
               WHERE ad.num_cmpb = re.num_cmpb
                 AND ad.tip_unid_mone ='1'
               GROUP BY ad.tip_unid_mone) DOLARES,
        pu.cod_punt cod_punt,
        0  nse_punt_radi                       
      FROM atm_pedido_mant pm,
           atm_detalle_hoja_ruta dh,
           shtd_cmpb_serv_refe re ,
           ve_punto pu
       WHERE pm.num_cmpb_atm_prin = dh.num_cmpb_atm
        AND pm.cod_seri_atm_prin = dh.cod_seri_atm
        AND pm.tip_docu_atm_prin = dh.tip_docu_atm
        AND dh.cod_etapa = '04'
        AND EXISTS(
          SELECT 1
          FROM atm_detalle_hoja_ruta a, atm_falla_ruta b
          WHERE b.cod_ruta      = a.cod_ruta
            AND b.num_hoja_ruta = a.num_hoja_ruta
            AND b.cod_sucu_htb  = a.cod_sucu_htb
            AND b.cod_serv      = a.cod_serv
            AND b.cod_turn      = a.cod_turn
            AND b.cod_cjro      = a.cod_cjro
            AND b.cod_clie      = a.cod_clie
            AND b.nse_punto     = a.nse_punto
            AND b.num_prio      = a.num_prio
            AND a.cod_etapa     = '04'
            AND (b.cod_fall      = 7 OR ( b.cod_fall in (22,25) and nvl(a.ind_rema_cust,0) = 0 ))
            AND a.num_cmpb_mant = pm.num_cmpb_mant
            AND a.cod_sucu_htb  = pm.cod_sucu_htb
            AND a.tip_mant      = pm.tip_mant
        )
        AND dh.cod_cjro       = pu.cod_punt
        AND dh.num_cmpb_atm   = re.num_cmpb_orig(+)
        AND dh.cod_seri_atm   = re.cod_seri_cmpb_orig(+)
        AND dh.tip_docu_atm   = re.tip_docu_cmpb_orig(+)
        AND (re.tip_orig_cmpb = '1' OR re.tip_orig_cmpb IS NULL)
         ) da
 where da.fecha >= to_date('01/09/2016','dd/mm/yyyy')
   and da.fecha <= to_date('30/09/2016','dd/mm/yyyy')) asd
   where qwe.num_cmpb=asd.num_cmpb and qwe.tip_docu_cmpb=asd.tip_docu_cmpb and qwe.cod_seri_cmpb=asd.cod_seri_cmpb
