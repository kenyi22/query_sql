Select * From JO_COTR_RECO WHERE NUM_COTR='A0530000013057';

Select empleado 
--      Into lv_codi_empl
		  From csmc_usua
		 Where cod_usua = 'BALLCA';--21344
     
     Select * From CAB_DET_M;
     
     Select * From tg_sucursal_htb
     
     
     select d.tip_mone, de.can_valo_nomi Deno,d.tip_prod,d.tip_unid_mone,d.tip_mone 
              from 
              ac_deno_mone d, tg_denominacion de
              where /*d.tip_prod = :S_CABE.S_TIP_PROD
              and d.tip_unid_mone = :S_CABE.S_COD_UNID
              --and d.tip_mone    = :S_CABE.S_TIPO_BILL
					    and*/ d.ind_acti = 1 
					    and de.cod_deno = d.cod_deno 
					    and de.des_deno is not null
					    order by d.tip_mone,de.can_valo_nomi;
              
Select Distinct D.Cod_Cnta
                     From Bt_Cdre_Cabi C,
                          Bt_Cdre_Cabi_Deta N,
                          Bt_Remesa R,
                          Tv_Cmpb_Serv D,
                          Tvtd_Mont_Cmpb_Bove E
                     Where C.Num_Cdre = :s_cab_det_m.s_num_cdre -- valor registro
                     And C.Tip_Docu_Cdre = N.Tip_Docu_Cdre
                     And C.Cod_Seri_Cdre = N.Cod_Seri_Cdre
                     And C.Num_Cdre = N.Num_Cdre
                     And N.Cod_Reme = R.Cod_Reme
                     And D.Num_Cmpb = R.Num_Cmpb
                     And D.Cod_Seri_Cmpb = R.Cod_Seri_Cmpb
                     And D.Tip_Docu_Cmpb = R.Tip_Docu_Cmpb
                     And D.Tip_Orig = '1'
                     And D.Tip_Dest = '3'
                     And R.Fec_Turn_Sala = :s_cab_det_m.S_Fec_Proc_Aper  --<REQ2241>:S_Cabe.S_Fec_Cont_M
                     And R.Cod_Sucu_Htb_Cabi = :Global.Sucursal
                     And R.Cod_Sala = :s_cab_det_m.s_Cod_Sala --valor registro 
                     And R.Est_Reme In ('6', '7')
                     And D.Cod_Clie_Cnta = :s_cab_det_m.s_cod_clie_cnta --valor registro
                     And E.Num_Cmpb = R.Num_Cmpb
                     And E.Cod_Seri_Cmpb = R.Cod_Seri_Cmpb
                     And E.Tip_Docu_Cmpb = R.Tip_Docu_Cmpb
                     And E.Cod_Sucu_Htb = D.Cod_Sucu_Htb_Cnta
                     And C.Cod_Bove = E.Cod_Bove
                     And Nvl (E.Ind_Pcrr, 0) = '1'
                     And E.Cod_Bove = :S_Cabe.S_Cod_Bove_M
              
