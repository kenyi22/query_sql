select a.tip_docu_pedi,a.cod_seri_pedi,a.num_pedi,nse_item_pedi, a.tip_pedi,
                      fec_soli_pedi,hor_soli_pedi,fec_aten_pedi,hor_aten_inic_pact,
                      hor_aten_finl_pact,a.cod_punt,a.cod_clie_dest,mon_pedi, b.tip_bill, a.ind_pedi_banc, c.tip_unid_mone, b.ind_recp,
                      a.cod_trnp,b.cod_bove --Adicion de codigo JU 23/11/2016 Req043869
               from   ac_boveda c, ac_pedido a,ac_pedido_deta b
               where  a.cod_sucu_htb  = to_number(1)
               and    a.fec_proc_aper = '31/01/2017'
               and    a.cod_clie_orig = 2556 
               and    a.cod_cnta_orig = 1
               and    a.num_pedi      = b.num_pedi 
               and    a.cod_seri_pedi = b.cod_seri_pedi 
               and    a.tip_docu_pedi = b.tip_docu_pedi
               and    b.est_item_pedi = '1'
               and    c.cod_sucu_htb  = a.cod_sucu_htb
               and    c.cod_bove      = b.cod_bove
               and    nvl(mon_pedi,0) > 0
               and    b.num_cmpb is null
               and    a.tip_pedi      = 1
               and    b.cod_bove      = :control.s_cod_bove 
               --Adicion de codigo JU 01/12/2016 Req043869
               and   (( :control.chk_smar=1 and  a.cod_trnp = 5) or
                      (nvl(:control.chk_smar,0)<>1 )) 
                --Fin JU 01/12/2016 Req043869                      
               order  by a.tip_docu_pedi, a.cod_seri_pedi, a.num_pedi, nse_item_pedi;
               
               Select * From ac_pedido_deta where num_pedi=3181790 for update
