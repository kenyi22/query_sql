Select cod_sucu,
       fec_prgn,
       cod_ruta,
       cod_turn,
       nse_punt_Radi,
       cod_punt,
       hor_inic_prog,
       hor_finl_prog,
       hor_lleg_punt,
       hor_sali_punt,
       hor_ctrl_punt,
       ind_reco,
       ind_envi,
       ind_mant,
       ind_anul,
       ind_atnd
  from cbtd_hoja_ruta
 WHERE FEC_PRGN = '25/12/2016'
   AND COD_PUNT = 25163
   AND COD_SUCU = 1;
  
  Select * From IT_SOAP.CBTD_HOJA_RUTA_SOAP WHERE FEC_PRGN='25/12/2016' AND COD_PUNT=25163 AND COD_SUCU=1;
  Select * From IT_SOAP.CBTD_HOJA_RUTA_SOAP WHERE FEC_PRGN='26/12/2016' AND COD_PUNT=25163 AND COD_SUCU=1;
  
  Select * From it_soap.cbtd_hoja_ruta_soap where cod_ruta=153 and fec_prgn='26/12/2016' and cod_punt=25163
