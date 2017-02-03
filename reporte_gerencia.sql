Select a.fec_proc "Fecha de Servicio",
       a.num_cmpb_prin "Num_Compro_Princ",
       a.num_cmpb "Num_Comprobante",
       a.cod_ruta_dest "Ruta",
       a.cod_punt_dest "Secuencia",
       a.cod_punt_orig "Codigo del Punto de Origen",
       (Select des_punt From ve_punto where cod_punt=a.cod_punt_orig ) "Des_Punt_Origen",
       a.cod_punt_dest "Codigo del Punto de Destino",
       (Select des_punt From ve_punto where cod_punt=a.cod_punt_dest ) "Des_Punt_Destino",
       a.cod_clie "Codigo del Cliente",
       (Select nom_clie From ve_cliente where cod_clie=a.cod_clie) "Descr_Cliente",
       a.fec_orig "Fecha de llegada -B",
       a.hor_inic_serv_envi "Hora de llegada -B",
       a.fec_dest "Fecha de Salida -B",
       a.hor_finl_serv_envi "Hora de Salida -B",
       a.hor_inic_serv_reco "Hora de llegada -A",
       a.hor_finl_serv_reco "Hora de Salida -A",
       a.tip_form_tras,
       --a.ind_trasl ""Sin Traslado"",
       --a.ind_pernoc ""Con Custodia"",
       (Select des_sucu_htb From tg_sucursal_htb where cod_sucu_htb=a.cod_sucu_htb) "Sucursal",
       a.cod_seri_cmpb "Serie C/S",
       (select des_estd
  from tg_estd_docu
 where tip_docu = 'CS'
   and est_docu = a.est_docu)"Estado de C/S",
       case
       when a.tip_unid_mone=1 then 'Dolares'
       when a.tip_unid_mone=2 then 'Soles'
         else 'Otros'
           end "Unidad Monetaria",
       a.can_totl_enva "Cantidad de Envases",
       a.mon_efec "Monto"
       --Select a.*
       --a.*
  From TV_CMPB_SERV a
  where a.fec_proc between '01/10/2016' and '31/12/2016'
/* where TIP_DOCU_CMPB = :CONTROL.S_TIP_DOCU_CMPB
   and COD_SERI_CMPB = :CONTROL.S_COD_SERI_CMPB
   AND NUM_CMPB = :CONTROL.S_NUM_CMPB
   AND COD_SUCU_HTB_CNTA = TO_NUMBER(:GLOBAL.COD_SUCU_HTB)*/
