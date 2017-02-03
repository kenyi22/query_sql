Select Distinct a1.cod_sucu_htb,a1.cod_seri_cmpb,a1.tip_docu_cmpb, a1.num_cmpb, --  7445
                 gepg_gene_0001.gefu_vali_clie(a1.cod_clie) Cliente,
                (Select des_estd From tg_tabl_estd Where cod_grup_estd = 2 And cod_estd = a1.est_docu)ESTADO_DOCU,
                a1.fec_proc,
                (select p.des_punt From ve_punto p Where p.cod_punt = a1.cod_punt_orig)ORIGEN,
                (select p.des_punt From ve_punto p Where p.cod_punt = a1.cod_punt_dest) DESTINO,
                Decode(f1.tip_unid_mone,'1','D','2','S','O')MONEDA,
                Decode(shac.shpg_cons_comp_serv.shfu_cont_bove(a1.tip_prod,a1.tip_docu_cmpb,a1.cod_seri_cmpb,a1.num_cmpb,e1.cod_sucu_htb,e1.cod_bove)
                ,0,e1.mon_valo_prod,shac.shpg_cons_comp_serv.shfu_cont_bove(a1.tip_prod,a1.tip_docu_cmpb,a1.cod_seri_cmpb,a1.num_cmpb,e1.cod_sucu_htb,e1.cod_bove) )
                Contiene,
                d1.cod_serv ,
                (select s.des_serv From ve_servicio s Where s.cod_serv = d1.cod_serv)Servicio,
                d1.ind_serv_fact,
                decode(d1.ind_serv_fact,1,'FACTURABLE','0','NO FACTURABLE')INDI_FACTURABLE,
                a1.fec_crea,
                a1.cod_usua_modi,
                a1.fec_modi
            From tv_cmpb_serv a1,
                 tv_cmpb_item_serv d1,
                 ve_punto b1,
                 tvtd_mont_cmpb_bove e1,
                 ac_boveda f1
           Where a1.tip_docu_cmpb in ('CE', 'CP', 'CS')
             And a1.fec_proc >= to_date('01/10/2016','dd/mm/rrrr')
             And a1.fec_proc <= to_date('30/12/2016','dd/mm/rrrr')
             And Nvl(d1.ind_serv_fact,0) = 0
--             And (Nvl(a1.est_docu,'0') = '0' Or (Nvl(a1.est_docu,'0')Not in ('10','11') And d1.ind_serv_fact = 0))
             And Nvl(a1.est_docu,'0')Not in ('10','11')
             And a1.tip_orig In (1, 2, 3, 4)
             And a1.tip_dest In (1, 2, 3, 6)
             And a1.num_cmpb = d1.num_cmpb
             And a1.cod_seri_cmpb = d1.cod_seri_cmpb
             And a1.tip_docu_cmpb = d1.tip_docu_cmpb
             And e1.num_cmpb = a1.num_cmpb
             And e1.cod_seri_cmpb = a1.cod_seri_cmpb
             And e1.tip_docu_cmpb = a1.tip_docu_cmpb
             And e1.cod_sucu_htb = a1.cod_sucu_htb
             And b1.cod_punt = Decode(a1.tip_form_tras, 1, a1.cod_punt_dest, a1.cod_punt_orig)
             And e1.cod_sucu_htb = f1.cod_sucu_htb
             --And a1.cod_clie=224
             And e1.cod_bove = f1.cod_bove
             And b1.cod_clie_grup not in (
             Select vc.cod_clie From ve_cliente vc
             Where vc.cod_corp = 181)
             And Not exists (
             Select 'x' From tv_cmpb_item_serv vv
           Where vv.num_cmpb = a1.num_cmpb
             And vv.tip_docu_cmpb = a1.tip_docu_cmpb
             And vv.cod_seri_cmpb = a1.cod_seri_cmpb
             And vv.tip_serv = '3'
             And vv.cod_serv = 22)
             And ((Nvl(a1.est_docu,'0')= '0' ) Or ( Not Exists (
             Select 1 From tv_cmpb_item_serv b Where
             a1.num_cmpb = b.num_cmpb
             And a1.cod_seri_cmpb = b.cod_seri_cmpb
             And a1.tip_docu_cmpb = b.tip_docu_cmpb
             And b.ind_serv_fact=1 ))
              )
          Minus
          Select  Distinct a2.cod_sucu_htb,a2.cod_seri_cmpb,a2.tip_docu_cmpb, a2.num_cmpb,
                 gepg_gene_0001.gefu_vali_clie(a2.cod_clie) Cliente,
                (Select des_estd From tg_tabl_estd Where cod_grup_estd = 2 And cod_estd = a2.est_docu)ESTADO_DOCU,
                a2.fec_proc,
                (select p.des_punt From ve_punto p Where p.cod_punt = a2.cod_punt_orig)ORIGEN,
                (select p.des_punt From ve_punto p Where p.cod_punt = a2.cod_punt_dest) DESTINO,
                Decode(f2.tip_unid_mone,'1','D','2','S','O')MONEDA,
                Decode(shac.shpg_cons_comp_serv.shfu_cont_bove(a2.tip_prod,a2.tip_docu_cmpb,a2.cod_seri_cmpb,a2.num_cmpb,e2.cod_sucu_htb,e2.cod_bove)
                ,0,e2.mon_valo_prod,shac.shpg_cons_comp_serv.shfu_cont_bove(a2.tip_prod,a2.tip_docu_cmpb,a2.cod_seri_cmpb,a2.num_cmpb,e2.cod_sucu_htb,e2.cod_bove) )
                Contiene,
                d2.cod_serv ,
                (select s.des_serv From ve_servicio s Where s.cod_serv = d2.cod_serv)Servicio,
                d2.ind_serv_fact,
                decode(d2.ind_serv_fact,1,'FACTURABLE','0','NO FACTURABLE')INDI_FACTURABLE,
                a2.fec_crea,
                a2.cod_usua_modi,
                a2.fec_modi
            From tv_cmpb_serv a2,
                 tv_cmpb_item_serv d2,
                 ve_punto b2,
                 tvtd_mont_cmpb_bove e2,
                 ac_boveda f2
           Where a2.tip_docu_cmpb In ('CE', 'CP', 'CS')
             And a2.fec_proc >= to_date('01/10/2016','dd/mm/rrrr')
             And a2.fec_proc <= to_date('30/12/2016','dd/mm/rrrr')
             And a2.tip_orig = '2'
             And a2.tip_dest = '3'
             And a2.num_cmpb = d2.num_cmpb
             And a2.cod_seri_cmpb = d2.cod_seri_cmpb
             And a2.tip_docu_cmpb = d2.tip_docu_cmpb
             And e2.num_cmpb = a2.num_cmpb
             And e2.cod_seri_cmpb = a2.cod_seri_cmpb
             And e2.tip_docu_cmpb = a2.tip_docu_cmpb
             And e2.cod_sucu_htb = a2.cod_sucu_htb
             And b2.cod_sucu_htb = a2.cod_sucu_htb
             And b2.cod_punt = Decode(a2.tip_form_tras, 1, a2.cod_punt_dest, a2.cod_punt_orig)
             And e2.cod_sucu_htb = f2.cod_sucu_htb
             And e2.cod_bove = f2.cod_bove
             And cod_seri_cmpb_refe Like 'I%'
             And tip_form_tras = '1'
