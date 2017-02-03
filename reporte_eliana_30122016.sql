Select z.*, case when z.codRazoSociClieGroup = z.codRazoSociClieOrig then 2 else 3 end as TipProc, case when z.des_prog_pedi is null then 'UNICA VEZ' else z.des_prog_pedi end  desProgPedi  from (Select a.cod_seri_pedi As codseripedi,
       a.num_pedi As numpedi,
       --Codigo añadido. Allona REQ015476 Mejoras en pedidos TV y ATM BCP. 24/11/2015
       (select to_char(x.fec_aten_soli, 'DD/MM/YYYY')
          from ACMD_PEDI_CAMP_ADIC x
         where x.num_pedi= a.num_pedi
           and x.cod_seri_pedi = a.cod_seri_pedi
           and x.tip_docu_pedi = a.tip_docu_pedi ) fecAtenSoli,
       (select x.tip_prio_soli
          from ACMD_PEDI_CAMP_ADIC x
         where x.num_pedi= a.num_pedi
           and x.cod_seri_pedi = a.cod_seri_pedi
           and x.tip_docu_pedi = a.tip_docu_pedi ) tipPrioSoli,
       (select nvl(to_char(x.hor_aten_inic_soli, 'HH24:MI'),'')
          from ACMD_PEDI_CAMP_ADIC x
         where x.num_pedi= a.num_pedi
           and x.cod_seri_pedi = a.cod_seri_pedi
           and x.tip_docu_pedi = a.tip_docu_pedi ) horAtenInicSoli,
       (select nvl(to_char(x.hor_aten_finl_soli, 'HH24:MI'),'')
          from ACMD_PEDI_CAMP_ADIC x
         where x.num_pedi= a.num_pedi
           and x.cod_seri_pedi = a.cod_seri_pedi
           and x.tip_docu_pedi = a.tip_docu_pedi ) horAtenFinlSoli,
       a.cod_auto_pedi As codAutoPedi,
       --Fin. Allona REQ015476 Mejoras en pedidos TV y ATM BCP. 24/11/2015
       a.tip_docu_pedi as tipDocuPedi,
       a.tip_docu_pedi||'-'||
       (select x.des_tipo
          from tg_tabl_tipo x
         where x.cod_tipo= a.tip_pedi and x.cod_grup_tipo = 48  ) destipdocupedi,
       d.cod_clie_grup As codcliegrup,
       e.nom_clie As nomcliegroup,
       e.cod_razo_soci As codRazoSociClieGroup,
       a.cod_cnta_orig As codcntaorig,
     (Select e.des_cnta
          From apertura.ac_cuenta e
         Where e.cod_sucu_htb = a.cod_sucu_htb
           And e.cod_clie = a.cod_clie_orig
           And e.cod_cnta = a.cod_cnta_orig) As descntaorig,
       a.cod_clie_orig As codclieorig,
       (Select d.nom_clie
          From ventas.ve_cliente d
         Where d.cod_clie = a.cod_clie_orig) As nomclie,
        (Select d.cod_razo_soci
          From ventas.ve_cliente d
         Where d.cod_clie = a.cod_clie_orig) As codRazoSociClieOrig,
       a.cod_punt As codpunt,
       (Select x.des_punt
          From ventas.ve_punto x
         Where a.cod_punt = x.cod_punt) As despunt,
       (Select x.des_dire_punt
          From ventas.ve_punto x
         Where a.cod_punt = x.cod_punt) As desdirepunt,
       a.cod_sucu_htb As codsucuhtb,
       (Select f.des_sucu_htb
          From general.tg_sucursal_htb f
         Where f.cod_sucu_htb = a.cod_sucu_htb) As dessucuhtb,
       to_char(a.fec_proc_aper, 'DD/MM/YYYY') As fecprocaper,
       to_char(a.fec_soli_pedi, 'DD/MM/YYYY') As fecsolipedi,
       to_char(a.fec_aten_pedi, 'DD/MM/YYYY') As fecatenpedi,
       nvl(to_char(a.hor_aten_inic_pact, 'HH24:MI'),'') As horateninicpact,
       nvl(to_char(a.hor_soli_pedi, 'HH24:MI'),'') As horsolipedi,
       a.est_doc As estdoc,(decode((Select count(x.num_pedi)
                                             From ac_pedido_deta x
                                             Where x.num_pedi = a.num_pedi
                                                   And x.cod_seri_pedi = a.cod_seri_pedi
                                                   And x.tip_docu_pedi = a.tip_docu_pedi
                                                   And x.est_item_pedi <> 5) , 0 ,'ELIMINADO', (decode((Select count(num_pedi)
                                                                                                          From ac_pedido y
                                                                                                          Where y.tip_docu_pedi = a.tip_docu_pedi
                                                                                                                And y.cod_seri_pedi = a.cod_seri_pedi
                                                                                                                And  y.num_pedi = a.num_pedi
                                                                                                                And (Select count(x.num_pedi)
                                                                                                                     From ac_pedido_deta x
                                                                                                                     Where x.num_pedi = a.num_pedi
                                                                                                                           And x.cod_seri_pedi = a.cod_seri_pedi
                                                                                                                           And x.tip_docu_pedi = a.tip_docu_pedi
                                                                                                                           And nvl(x.ind_recp,0) <> 1
                                                                                                                           And x.est_item_pedi <> 5) = 0
                                                                                                                And (Select count(x.num_pedi)
                                                                                                                     From ac_pedido_deta x
                                                                                                                     Where x.num_pedi = a.num_pedi
                                                                                                                           And x.cod_seri_pedi = a.cod_seri_pedi
                                                                                                                           And x.tip_docu_pedi = a.tip_docu_pedi
                                                                                                                           And x.est_item_pedi <> 5) > 0),0, (Select des_estd
                                                                                                                                                             From general.tg_tabl_estd e
                                                                                                                                                             Where e.cod_estd = a.est_doc
                                                                                                                                                             And cod_grup_estd = 137
                                                                                                                                                             And cod_estd Not In (0)), 'RECEPCIONADO HERMES' )))) As desestdoc,a.tip_pedi As TipPedi ,a.tip_dest_pedi As tipdestpedi,
       case when to_char(nvl(a.tip_dest_pedi,decode(a.tip_pedi,1,1,3)))='1' then 'AGENCIA'
            when to_char(nvl(a.tip_dest_pedi,decode(a.tip_pedi,1,1,3)))='2' then 'CLIENTE'
            when to_char(nvl(a.tip_dest_pedi,decode(a.tip_pedi,5,3,7,3,8,3,1)))='3' then 'TRANSFERENCIA'
       end desTipPedi,
       a.tip_regi_pedi As tipregipedi,
       apertura.hwpg_tabl.hwfu_retu_unid_mone_bove(b.cod_bove, a.cod_sucu_htb) unidmone,
       initcap(apertura.hwpg_tabl.hwfu_retu_desc(19, apertura.hwpg_tabl.hwfu_retu_unid_mone_bove(b.cod_bove, a.cod_sucu_htb),1)) destipunidmone,
       a.txt_obsv as txtObsv,
       APERTURA.HWPG_PEDI.HWFU_RETU_USUA_APRO(a.tip_docu_pedi,a.num_pedi,a.cod_seri_pedi)  as usuAprob,
       APERTURA.HWPG_PEDI.HWFU_RETU_USUA_RECE (a.tip_docu_pedi,a.num_pedi,a.cod_seri_pedi)  as usuRecep,
       b.nse_item_pedi As nseitempedi,
       b.cod_bove As codbove,
       b.tip_bill As tipbill,
       APERTURA.HWPG_TABL.HWFU_RETU_DESC('47',b.tip_bill,'1') desTipBill,
       b.mon_pedi As monpedi,
       '' As numCntaCarg,
       c.tip_mone as tipMone,
       c.cod_deno as codDeno,
       nvl((select x.can_valo_nomi  from ac_deno_mone x
               where x.tip_unid_mone =  APERTURA.HWPG_TABL.HWFU_RETU_UNID_MONE_BOVE(b.cod_bove, a.cod_sucu_htb)
                 and x.tip_mone = c.tip_mone
                 and x.cod_deno = c.cod_deno),0) canValoNomi,
       --i- Modificacion en la sumatoria del campo mon_deno RP REQ-2253
       --nvl(c.mon_deno,0) as monDenoCons,
     (Select Sum(Nvl(g.mon_deno,0))
             From ac_pedido_deno g
             Where g.num_pedi=c.num_pedi
                   And g.cod_seri_pedi=c.cod_seri_pedi
                   And g.cod_deno=c.cod_deno
                   And g.tip_mone=c.tip_mone) As monDenoCons,
     --f- Modificacion en la sumatoria del campo mon_deno RP REQ-2253
       (select t.des_tipo
               from  apertura.hwtc_prog_pedi p ,
               general.tg_tabl_tipo t
           where p.num_pedi=a.num_pedi
                 and p.cod_seri_pedi=a.cod_seri_pedi
                 and p.tip_docu_pedi=a.tip_docu_pedi
                 and t.cod_tipo=p.tip_frec
                 and p.est_prog <> 4
                 and t.cod_grup_tipo='823' ) as des_prog_pedi,
           a.cod_seri_temp as   codSeriTemp,
           a.num_pedi_temp as numPediTemp,
           a.tip_docu_temp as tipDocuTemp,
          (Select h.num_cnta_carg
            From apertura.hwtd_pedi_deta h
           Where a.cod_seri_temp = h.cod_seri_pedi
             And a.num_pedi_temp = h.num_pedi
             And a.tip_docu_temp = h.tip_docu_pedi
             And rownum = 1) numCntaCargo,
           b.cod_usua_recp codUsuaRecp,
           to_char(b.fec_crea,'dd/mm/yyyy')||'  '||to_char(b.hor_recp,'hh24:mi') fecCrea,
           (Select nvl(min(y.des_punt),'')
                   From ve_clie_punt x,
                        ve_punto y
                   Where x.cod_punt_sucu_clie = y.cod_punt
                         And x.cod_clie = a.cod_clie_orig
                         And x.cod_punt = a.cod_punt) matriz
  From apertura.ac_pedido      a,
       apertura.ac_pedido_deta b,
       apertura.ac_pedido_deno c ,
       ventas.ve_punto d,
       ventas.ve_cliente e
     --i- Adición de tabla temporal para agrupación de items RP REQ-2253
      ,(Select a.num_pedi,a.mon_pedi,cod_deno,tip_mone, b.nse_item_pedi
               From ac_pedido_deta a,
                    ( Select a.num_pedi,cod_deno,tip_mone,Min(c.nse_item_pedi) As nse_item_pedi
               From ac_pedido      a,
                    ac_pedido_deta b,
                    ac_pedido_deno c
               Where a.num_pedi = b.num_pedi
                   And a.cod_seri_pedi = b.cod_seri_pedi
                                   And a.tip_docu_pedi = b.tip_docu_pedi
                                   And a.num_pedi = c.num_pedi
                                   And a.cod_seri_pedi = c.cod_seri_pedi
                                   And a.tip_docu_pedi = c.tip_docu_pedi
                                   And b.nse_item_pedi = c.nse_item_pedi
                                   And a.ind_pedi_banc = 1
                                   And (b.est_item_pedi <> 5
                                    Or ((Select Count(x.num_pedi)
                                                From ac_pedido_deta x
                                                Where x.num_pedi = a.num_pedi
                                                     And x.cod_seri_pedi = a.cod_seri_pedi
                                                     And x.tip_docu_pedi = a.tip_docu_pedi
                                                     And x.est_item_pedi <> 5) = 0)) And a.cod_clie_orig In (1)  And (a.tip_pedi = 5 Or a.tip_pedi = 1)  And a.fec_soli_pedi between to_date('23/08/2016','DD/MM/YYYY') And to_date('15/09/2016','DD/MM/YYYY') Group By a.num_pedi,cod_deno,tip_mone
              )b
               Where a.nse_item_pedi = b.nse_item_pedi
                     And a.num_pedi=b.num_pedi
       )f
       --f- Adición de tabla temporal para agrupación de items RP REQ-2253
 Where a.num_pedi = b.num_pedi
   And a.cod_seri_pedi = b.cod_seri_pedi
   And a.tip_docu_pedi = b.tip_docu_pedi
   And b.num_pedi = c.num_pedi
   And b.cod_seri_pedi = c.cod_seri_pedi
   And b.tip_docu_pedi = c.tip_docu_pedi
   And b.nse_item_pedi = c.nse_item_pedi
   And a.cod_punt = d.cod_punt
   And a.ind_pedi_banc = 1
   And (b.est_item_pedi <> 5
       Or ((Select count(x.num_pedi)
            From ac_pedido_deta x
            Where x.num_pedi = a.num_pedi
                  And x.cod_seri_pedi = a.cod_seri_pedi
                  And x.tip_docu_pedi = a.tip_docu_pedi
                  And x.est_item_pedi <> 5) = 0))
   --i- Adición de tabla temporal para agrupación de items RP REQ-2253
   And  b.mon_pedi=f.mon_pedi
   And  c.cod_deno=f.cod_deno
   And  c.nse_item_pedi=f.nse_item_pedi
   And  c.tip_mone=f.tip_mone
   And  c.num_pedi=f.num_pedi
   --f- Adición de tabla temporal para agrupación de items RP REQ-2253
   And d.cod_clie_grup = e.cod_clie  And a.cod_clie_orig In (1)  And (a.tip_pedi = 5 Or a.tip_pedi = 1)  And a.fec_soli_pedi between to_date('23/08/2016','DD/MM/YYYY') And to_date('15/09/2016','DD/MM/YYYY') union   Select a.cod_seri_pedi As codseripedi,
       a.num_pedi As numpedi,
       --Codigo añadido. Allona REQ015476 Mejoras en pedidos TV y ATM BCP. 24/11/2015
       (select to_char(x.fec_aten_soli, 'DD/MM/YYYY')
          from ACMD_PEDI_CAMP_ADIC x
         where x.num_pedi= a.num_pedi
           and x.cod_seri_pedi = a.cod_seri_pedi
           and x.tip_docu_pedi = a.tip_docu_pedi ) fecAtenSoli,
       (select x.tip_prio_soli
          from ACMD_PEDI_CAMP_ADIC x
         where x.num_pedi= a.num_pedi
           and x.cod_seri_pedi = a.cod_seri_pedi
           and x.tip_docu_pedi = a.tip_docu_pedi ) tipPrioSoli,
       (select nvl(to_char(x.hor_aten_inic_soli, 'HH24:MI'),'')
          from ACMD_PEDI_CAMP_ADIC x
         where x.num_pedi= a.num_pedi
           and x.cod_seri_pedi = a.cod_seri_pedi
           and x.tip_docu_pedi = a.tip_docu_pedi ) horAtenInicSoli,
       (select nvl(to_char(x.hor_aten_finl_soli, 'HH24:MI'),'')
          from ACMD_PEDI_CAMP_ADIC x
         where x.num_pedi= a.num_pedi
           and x.cod_seri_pedi = a.cod_seri_pedi
           and x.tip_docu_pedi = a.tip_docu_pedi ) horAtenFinlSoli,
       (Select cod_auto_pedi from ac_pedido where num_pedi = a.num_pedi) as codAutoPedi,
       --Fin. Allona REQ015476 Mejoras en pedidos TV y ATM BCP. 24/11/2015
       a.tip_docu_pedi as tipDocuPedi,
       a.tip_docu_pedi||'-'||
     (select x.des_tipo
          from tg_tabl_tipo x
         where x.cod_tipo= a.tip_pedi and x.cod_grup_tipo = 48 ) destipdocupedi,
       d.cod_clie_grup As codcliegrup,
       e.nom_clie As nomcliegroup,
       e.cod_razo_soci As codRazoSociClieGroup,
       a.cod_cnta_orig As codcntaorig,
       (Select e.des_cnta
          From apertura.ac_cuenta e
         Where e.cod_sucu_htb = a.cod_sucu_htb
           And e.cod_clie = a.cod_clie_orig
           And e.cod_cnta = a.cod_cnta_orig) As descntaorig,
       a.cod_clie_orig As codclieorig,
       (Select d.nom_clie
          From ventas.ve_cliente d
         Where d.cod_clie = a.cod_clie_orig) As nomclie,
       (Select d.cod_razo_soci
          From ventas.ve_cliente d
         Where d.cod_clie = a.cod_clie_orig) As codRazoSociClieOrig,
       a.cod_punt As codpunt,
       (Select x.des_punt
          From ventas.ve_punto x
         Where a.cod_punt = x.cod_punt) As despunt,
       (Select x.des_dire_punt
          From ventas.ve_punto x
         Where a.cod_punt = x.cod_punt) As desdirepunt,
       a.cod_sucu_htb As codsucuhtb,
       (Select f.des_sucu_htb
          From general.tg_sucursal_htb f
         Where f.cod_sucu_htb = a.cod_sucu_htb) As dessucuhtb,
       to_char(a.fec_proc_aper, 'DD/MM/YYYY') As fecprocaper,
       to_char(a.fec_soli_pedi, 'DD/MM/YYYY') As fecsolipedi,
       to_char(a.fec_aten_pedi, 'DD/MM/YYYY') As fecatenpedi,
       nvl(to_char(a.hor_aten_inic_pact, 'HH24:MI'),'') As horateninicpact,
       nvl(to_char(a.hor_soli_pedi, 'HH24:MI'),'') As horsolipedi,
       a.est_doc As estdoc,
       (Select des_estd
          From general.tg_tabl_estd e
         Where e.cod_estd = a.est_doc
           And cod_grup_estd = 137
           And cod_estd Not In (0)) As desestdoc,
       a.tip_pedi As tipPedi,
       a.tip_dest_pedi As tipdestpedi,
       case when to_char(nvl(a.tip_dest_pedi,decode(a.tip_pedi,1,1,3)))='1' then 'AGENCIA'
            when to_char(nvl(a.tip_dest_pedi,decode(a.tip_pedi,1,1,3)))='2' then 'CLIENTE'
            when to_char(nvl(a.tip_dest_pedi,decode(a.tip_pedi,5,3,7,3,8,3,1)))='3' then 'TRANSFERENCIA'
       end desTipPedi,
       a.tip_regi_pedi As tipregipedi,
       apertura.hwpg_tabl.hwfu_retu_unid_mone_bove(b.cod_bove,a.cod_sucu_htb) unidmone,
       initcap(apertura.hwpg_tabl.hwfu_retu_desc(19,apertura.hwpg_tabl.hwfu_retu_unid_mone_bove(b.cod_bove, a.cod_sucu_htb),1)) destipunidmone,
       a.txt_obsv as txtObsv,
       APERTURA.HWPG_PEDI.HWFU_RETU_USUA_APRO(a.tip_docu_pedi,a.num_pedi,a.cod_seri_pedi)  as usuAprob ,
       APERTURA.HWPG_PEDI.HWFU_RETU_USUA_RECE (a.tip_docu_pedi,a.num_pedi,a.cod_seri_pedi)  as usuRecep ,
       b.nse_item_pedi As nseitempedi,
       b.cod_bove As codbove,
       b.tip_bill As tipbill,
       APERTURA.HWPG_TABL.HWFU_RETU_DESC('47',b.tip_bill,'1') desTipBill,
       b.mon_pedi As monpedi,
       b.num_cnta_carg  As numCntaCarg ,
       c.tip_mone as tipMone,
       c.cod_deno as codDeno,
        nvl((select x.can_valo_nomi  from ac_deno_mone x
               where x.tip_unid_mone =  APERTURA.HWPG_TABL.HWFU_RETU_UNID_MONE_BOVE(b.cod_bove, a.cod_sucu_htb)
                 and x.tip_mone = c.tip_mone
                 and x.cod_deno = c.cod_deno),0) canValoNomi,
       nvl(c.mon_deno,0)as monDenoCons,
              (select t.des_tipo
               from  apertura.hwtc_prog_pedi p ,
               general.tg_tabl_tipo t
           where p.num_pedi=a.num_pedi
                 and p.cod_seri_pedi=a.cod_seri_pedi
                 and p.tip_docu_pedi=a.tip_docu_pedi
                 and t.cod_tipo=p.tip_frec
                 and p.est_prog <> 4
                 and t.cod_grup_tipo='823' ) as des_prog_pedi,
           null as   codSeriTemp,
           null as numPediTemp,
           null as tipDocuTemp,
           (Select h.num_cnta_carg
            From apertura.hwtd_pedi_deta h
           Where a.cod_seri_pedi = h.cod_seri_pedi
             And a.num_pedi = h.num_pedi
             And a.tip_docu_pedi = h.tip_docu_pedi
             And rownum = 1) as numCntaCargo,
           '' codUsuaRecp,
           '' fecCrea,
           --Inicio REQ-2045
           (Select nvl(min(y.des_punt),'')
                   From ve_clie_punt x,
                        ve_punto y
                   Where x.cod_punt_sucu_clie = y.cod_punt
                         And x.cod_clie = a.cod_clie_orig
                         And x.cod_punt = a.cod_punt) matriz
             --Fin REQ-2045
  From apertura.hwtc_pedi      a,
         apertura.hwtd_pedi_deta b,
         apertura.hwtd_pedi_deno c,
         ventas.ve_punto d,
         ventas.ve_cliente e
 Where a.num_pedi = b.num_pedi
   And a.cod_seri_pedi = b.cod_seri_pedi
   And a.tip_docu_pedi = b.tip_docu_pedi
   And a.num_pedi = c.num_pedi
   And a.cod_seri_pedi = c.cod_seri_pedi
   And a.tip_docu_pedi = c.tip_docu_pedi
   And b.nse_item_pedi = c.nse_item_pedi
   And a.cod_punt = d.cod_punt
   And d.cod_clie_grup = e.cod_clie  And a.cod_clie_orig In (1) And nvl(a.num_cate_nive_auto,1)=1  And (a.tip_pedi = 5 Or a.tip_pedi = 1)  And a.fec_soli_pedi between to_date('23/08/2016','DD/MM/YYYY') And to_date('15/09/2016','DD/MM/YYYY')) z
