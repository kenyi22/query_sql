--extorno
--elimina los registros
SELECT * FROM tvtd_bols_rece t WHERE t.num_cmpb = 80110114  AND t.cod_seri_cmpb = 'A51' FOR UPDATE; --6
SELECT * FROM tvtd_cmpb_rece t WHERE t.num_cmpb = 80110114  AND t.cod_seri_cmpb = 'A51' FOR UPDATE; --1


--disminuye en 1 el numero de bolsas o cajas
Select t.num_cdre_bove,t.can_totl_cmpb,  t.can_totl_bols, t.can_totl_caja, t.* 
From Tvtc_Enva_Rece t 
Where Exists (Select 1 
From Tvtd_Cmpb_Rece a 
Where t.Cod_Sucu_Htb = a.Cod_Sucu_Htb 
And t.Fec_Orig = a.Fec_Orig 
And t.Cod_Ruta_Orig = a.Cod_Ruta_Orig 
And t.Cod_Turn = a.Cod_Turn 
And t.Nse_Entg = a.Nse_Entg 
And a.Num_Cmpb In (80110114) 
And a.Cod_Seri_Cmpb = 'A51')  for update;

--dismunuye el nro de bolsas y cajas dependiendo.
select t.can_bols_cdre, t.can_caja_cdre,t.* from shtc_cdre_bove t where t.num_cdre_bove=1589 and t.cod_sucu_htb=1 for update; -- DISMINUIR LA CANTIDAD DE BOLSAS del cuadre al que pertenecio el cs (QUE DIGAMOS SE ELIMINO 2 BOLSAS DEL CS ENTONCES SE DEBE DISMINUIR EN LA CAN_BOLS_CDRE a la cantidad -2)
--elimina registro
select * from shtc_cdre_hist t where t.num_cmpb in (80110114) and cod_seri_cmpb='A51' for update; --- ELIMINAR DE ESTA TABLA  el cs 
