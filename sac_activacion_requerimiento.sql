 Select des_sub_tipo
   --Into :tv_recp_llam_deta.des_tipo
   From TG_TAbL_TIPO
  Where cod_grup_tipo = 121 for update
      and ind_acti = 1
    And cod_tipo = :tv_recp_llam_deta.cod_tipo
; -- REQ2571 festupin 21/10/2014


  Select *
    --Into :tv_recp_llam_deta.des_requerimiento
    From TV_TAbL_SUb_TIPO
   Where cod_grup_tipo = 121
     And cod_tipo = :tv_recp_llam_deta.cod_tipo
     And nse_sub_tipo = :tv_recp_llam_deta.nse_sub_tipo
     And centro_costo = :tv_recp_llam_deta.centro_costo
     And iind_acti = 1; -- REQ2571 festupin 21/10/2014
     
     
     --activacion
     
     Select a.ind_sinm,a.cod_grup_tipo,a.cod_tipo,a.centro_costo,a.iind_acti,a.nse_sub_tipo
  /*Into :tv_recp_llam_deta.ind_sinm*/
  From tv_tabl_sub_tipo a
 Where a.centro_costo = '01.99.22' /*for update*/
    And a.cod_tipo = 13 
   and a.cod_grup_tipo = :tv_recp_llam_deta.cod_grup_tipo
