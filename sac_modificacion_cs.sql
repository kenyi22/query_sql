Select *
  From TV_CMPB_SERV
 where cod_clie_cnta = 224
   and cod_cnta = 1      
   and cod_sucu_htb_cnta = to_number(16)
   and ((tip_orig = '1' and tip_dest = '3' and tip_form_tras = '2') or
       (tip_orig = '2' and tip_dest = '1' and tip_form_tras = '1') or
       (tip_orig = '2' and tip_dest = '3' and tip_form_tras = '2') or
       (tip_orig = '2' and tip_dest = '3' and tip_form_tras = '1'))
   and est_docu <> '11'
   and fec_proc_aper = '02/02/2017'
   and cod_bove = 3 for update

Select * From TV_CMPB_SERV where num_cmpb=3834;--16

Select * From tg_sucursal_htb
