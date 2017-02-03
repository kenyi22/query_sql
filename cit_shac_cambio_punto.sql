  --CAMBIO DE PUNTO EN EL CIT Y SHAC
  Select *
    From cbtd_hoja_ruta
   where cod_ruta = 1
     and fec_prgn = '25/01/2017'
     AND cod_sucu=1
     and nse_punt_radi=10 for update
     for update; /*and cod_punt IN (103,21266)*/---111708
  AND NSE_PUNT_RADI IN(100) for update;
  
  -----------------
  select * from cbtd_hoja_ruta where num_cmpb_atm_prin in  (8884233);
select * from cbtd_hoja_ruta where cod_punt=32101 and fec_prgn>='25/01/2017';

select * from ac_pedido_deta where num_cmpb_atm_prin in  (8884233, 8850760);
select * from ac_pedido where num_pedi in (3173307,
3094491
);

select * from cbtd_hoja_ruta where num_cmpb_atm_prin in  (8884233) for update;
--------
Select num_cmpb_atm, cod_seri_atm, tip_docu_atm,cod_bove,est_item_pedi
  --into ln_num_cmpb_atm_dola, lv_cod_seri_atm_dola, lv_tip_docu_atm_dola
  from ac_pedido_deta
 Where num_cmpb_atm_prin = 8884233 /*for update*/
   --and cod_seri_atm_prin = row_ruta_deta.cod_seri_atm_prin
   --and tip_docu_atm_prin = row_ruta_deta.tip_docu_atm_prin
   and cod_bove = 3
   and est_item_pedi != 5;
   
   Select num_cmpb_atm, cod_seri_atm, tip_docu_atm
     --into ln_num_cmpb_atm_dola, lv_cod_seri_atm_dola, lv_tip_docu_atm_dola
     from ac_pedido_deta
    Where num_cmpb_atm_prin = 8884233
      --and cod_seri_atm_prin = row_ruta_deta.cod_seri_atm_prin
      --and tip_docu_atm_prin = row_ruta_deta.tip_docu_atm_prin
      and cod_bove = 3
      and est_item_pedi != 5;


---------

Select	hor_lleg_punt,ind_atnd,cod_turn_trnf,cod_ruta_trnf
		--Into		ld_hor_lleg_punt_inic
		From		cbtd_hoja_ruta
		Where   tip_docu_atm_prin = 'CS'
		--And		  cod_seri_atm_prin = :s_cabe.s_codi_seri
		And 	  num_cmpb_atm_prin = 8884233
    		And			hor_lleg_punt is not null
		And			hor_sali_punt is not null/* for update*/
		And 		ind_atnd = 1
        		And     cod_ruta_trnf is null
    
    		And 		cod_turn_trnf is null

	Select	cod_seri_atm_prin,hor_lleg_punt
		--Into		ld_hor_lleg_punt_inic
		From		cbtd_hoja_ruta
		Where   tip_docu_atm_prin = 'CS'
		And		  cod_seri_atm_prin = 'T01'
		And 	  num_cmpb_atm_prin = 8884233
		And     cod_ruta_trnf is null
		And 		cod_turn_trnf is null
		And			hor_lleg_punt is not null
		And			hor_sali_punt is not null
		And 		ind_atnd = 1;
  commit;
  ------------
  Select * From ve_punto where des_punt like '%RIPLEY%MEGAPLAZA%';--32101
  
  Select * From ac_pedido_deta where num_pedi=3139595
  Select * From ac_pedido where num_pedi=4347952;-- 8 trasnferencia
  Select * From it_soap.ac_pedido_soap where num_pedi=4347952;--
  
   Select * From tv_cmpb_serv where num_cmpb=8884233
  Select * From tv_cmpb_item_serv where num_cmpb=8884233

  
  Select * From cbtd_hoja_ruta where num_cmpb_atm_prin=107290 for update--33754
  
  Select * From tv_cmpb_serv WHERE NUM_CMPB in (8884233)  FOR UPDATE--2264
  
  Select * From it_soap.tv_cmpb_serv_soap where NUM_CMPB=8884233
  
  Select * From ac_pedido
  
  Select * From TV_CMPB_REME_TMP
  
  
  Select * From ve_punto where cod_punt=22464;
  
  shpg_ingr_reme.shfu_esta_vali_modi_reme
