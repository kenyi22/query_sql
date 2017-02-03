Select Ind_Usua_Serv, Ind_Acti_Docu, des_punt
  From ve_punto
 where cod_punt in (17492, 18534, 24645, 24680, 23306, 27053, 24068)
   for update

Select * From ve_punto where des_punt like '%CAV%VILLA%';

Select Des_Punt, Cod_Punt, Cod_Clie_Grup, Nom_Clie, Cod_Punt Cod_Punt2
  From Ve_Punto, Ve_Cliente, Tg_Sucursal_Htb g
 Where Ve_Punto.Cod_Sucu_Htb = g.Cod_Sucu_Htb
   And (g.cod_sucu_htb = 1 Or
       g.cod_sucu_refe_smar = 1)
   And Ve_Punto.Cod_Clie_Grup = Ve_Cliente.Cod_Clie
      /*Se adiciona condicion RR 03/01/2017 REQ043869*/
   And (Ind_Usua_Serv = '1' And :tv_recp_llam.S_Ind_cias = 1 Or
       Ind_Acti_Docu = 1 And :tv_recp_llam.S_Ind_cias = 2)
/*And (Ind_Usua_Serv = '1' And Ind_Acti_Docu = 1)
Fin. REQ043869*/
 Order By 1

-----
Select * From cstc_perf_usua WHERE cod_modu='AC' AND COD_USUA_ACCE='KCANCHI'

Select tip_docu_atm_prin,cod_seri_atm_prin,num_cmpb_atm_prin From cbtd_hoja_ruta WHERE num_cmpb_atm_prin=161411 AND COD_SUCU=8 FOR UPDATE

select   *--count(*)--c.hor_sali Modificado por EM REQ020820 05/01/2016*/   
  --into    ln_exis_anul--ld_hor_sali Modificado por EM REQ020820 05/01/2016*/  
  from    ac_pedido_deta a--, cbtd_hoja_ruta b, cbtc_hoja_ruta c
  where   a.cod_seri_cmpb = 'B08'--:control.s_cod_seri_cmpb
  and   	a.num_cmpb = 245863--:control.s_num_cmpb
	and   	b.tip_docu_atm_prin = a.tip_docu_atm_prin 
	and   	b.cod_seri_atm_prin = a.cod_seri_atm_prin
	and   	b.num_cmpb_atm_prin = a.num_cmpb_atm_prin
	and   	b.cod_sucu = c.cod_sucu
	and   	b.fec_prgn = c.fec_prgn
	and   	b.cod_ruta = c.cod_ruta
	and   	b.cod_turn = c.cod_turn
	/*Código agregado por EM REQ023045 03/02/2016*/	
	AND     b.cod_ruta_trnf Is Null
  And     b.cod_turn_trnf Is Null
  /*Fin de código REQ023045 03/02/2016*/
  /*Código agregado por EM REQ020820 05/01/2016*/	
	And			(nvl(b.ind_anul,0) = 0
  Or      (nvl(b.ind_anul,0) = 1 
  And 		a.cod_ruta_dest			 Is  Null 
	And 		a.cod_turn_radio		 Is  Null 
	And 		a.hor_entg_asig_reme Is  Null ))
	/*Fin de código por EM REQ020820 05/01/2016*/
	and			rownum = 1;
  
  --
  
  
