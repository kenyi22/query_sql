

Select *
  From cbtd_hoja_ruta
 where cod_ruta = 1
   and fec_prgn = '25/01/2017'
   AND COD_SUCU = 1
   and nse_punt_radi=10
   and cod_punt IN (24855)
   for update;
   
   Select * From it_soap.cbtd_hoja_ruta_soap   where cod_ruta = 83
   and fec_prgn = '24/01/2017'
   AND COD_SUCU = 1
   and cod_punt IN (24855)
   
   Select *
  From CBTC_FREC_PUNT
 where cod_sucu = 1
   and cod_ruta = 83
   and nse_entg = 85
   and cod_ndia = '2'
   for update;
   
   Select * From ve_punto where des_punt like '%ATM%1180%'
