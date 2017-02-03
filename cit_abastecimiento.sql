--select * from tg_sucursal_htb where des_sucu_htb like '%CAJAM%'
  select cod_punt, h.* from cbtd_hoja_ruta h where 
  h.num_cmpb_atm_prin=14671222    
  and h.cod_seri_atm_prin = 'A01'
  AND h.tip_docu_atm_prin = 'CS'; --24972
  
  select * from cbtd_hoja_ruta where num_cmpb_atm_prin=14671222
-- Query General: HISTORICO DE ABASTECIMENTOS:
select pedi.fec_aten_pedi, 
pedi.tip_docu_pedi, 
pedi.cod_seri_pedi, 
pedi.num_pedi, 
deta.tip_docu_atm_prin, 
deta.cod_seri_atm_prin, 
deta.num_cmpb_atm_prin, 
pedi.tip_docu_cmpb_rest, 
pedi.cod_seri_cmpb_rest, 
pedi.num_cmpb_rest, 
deta.fec_crea,
deta.cod_usua_crea
from ac_pedido pedi, ac_pedido_deta deta 
where pedi.num_pedi = deta.num_pedi 
and pedi.cod_seri_pedi = deta.cod_seri_pedi 
and pedi.tip_docu_pedi = deta.tip_docu_pedi 
and pedi.cod_punt =  35231--13493   29952
and deta.est_item_pedi != 5 
and pedi.fec_aten_pedi >= '01/11/2015' 
order by pedi.fec_aten_pedi; 

--verifica quien no trae reamente
Select t.ind_nsin_rema,t.num_cmpb_atm,t.* From atm_detalle_hoja_ruta t Where t.num_cmpb_atm in (8876550) FOR UPDATE;--,87681598768885,
 
select * from ve_punto where cod_punt=18489;
select * from tv_cmpb_serv where num_cmpb=8876550;

Select * From ve_punto where des_punt like '%ATM%194524%'

Select * From AC_PEDIDO WHERE COD_PUNT=35231

Select * From AC_PEDIDO_DENO WHERE COD_PUNT=35231
