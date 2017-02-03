Select * From ac_pedido_deta where num_pedi=3139595
Select * From ac_pedido where num_pedi=3139595;-- 8 trasnferencia
Select * From tg_tabl_tipo where cod_grup_tipo='48'

Select * From ve_orde_serv where cod_punt_usua_serv='22985'

Select *
  From cbtd_hoja_ruta
 where cod_sucu = '1'
   and cod_ruta = '1'
   and cod_turn = '1'
   and fec_prgn = '14/11/2016' and cod_punt='19297'
   
   Select * From ve_servicio where cod_serv=109
  
  Select * From tv_cmpb_serv where /*fec_proc='04/12/2016' and*/ num_cmpb='11574719' for update
  Select * From tv_cmpb_item_serv where num_cmpb='11574719'
  --22464
  
  --CAMBIO DE PUNTO EN EL CIT Y SHAC
  Select *   From cbtd_hoja_ruta where cod_ruta=1 and fec_prgn='21/01/2017' AND COD_SUCU=12  for update;/*and cod_punt IN (103,21266)*/ AND NSE_PUNT_RADI IN (100) for update;
  
  Select * From cbtd_hoja_ruta where num_cmpb_atm_prin=107290--33754
  
  Select * From tv_cmpb_serv WHERE NUM_CMPB=107290 AND COD_SERI_CMPB='T12' FOR UPDATE
  /*

  */
  Select * From it_soap.cbtd_hoja_ruta_soap where cod_ruta=99 and fec_prgn='15/01/2017' and cod_punt=1180 25813
  
  Select * From cbtc_hoja_ruta where cod_ruta=1 and fec_prgn='04/12/2016' and cod_punt=25813;
  Select * From ve_punto where des_punt like '%ATM%1942%'
  
  select *
  from csmc_usua a
  where a.nom_usua like '%ARTEAGA%'
  
  select *
  from cstc_perf_usua a
  where a.cod_usua_acce = 'KCANCHI'
  and a.cod_modu = 'DL' for update;
  
  
select * from cbtd_hoja_ruta where cod_ruta=1 and fec_prgn='17/01/2017' and ;--8862025, 8862013, 

select * from cbtd_hoja_ruta where /*cod_ruta=139 and fec_prgn='13/10/2016' and*/ num_cmpb_atm_prin in (8873927);--, 8862013,

select * from ac_pedido_deta where num_pedi in (3172768) for update;
Select * From ac_pedido where cod_punt=21266 and fec_aten_pedi in ('15/01/2017');--3172768
select * from ac_pedido where num_pedi in (8873927) for update;
select * from cbtd_hoja_ruta where num_cmpb_atm_prin in (8873927) for update;

select * from cbtd_hoja_ruta where cod_ruta=19 and fec_prgn='17/' and nse_punt_radi in (38, 39) for update;--8862025, 8862013,

select * from cbtd_hoja_ruta where cod_ruta=43 and fec_prgn='29/11/2016' and cod_punt in (24563);--8862025, 8862013,
Select * From it_soap.cbtd_hoja_ruta_soap where cod_ruta=43 and fec_prgn='29/11/2016' and cod_punt in (24563)

shpg_rece_enva_taqu. shfu_vali_list_valo_ruta
