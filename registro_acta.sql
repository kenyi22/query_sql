Select b.cod_clas_acta,
       (Select des_tipo
          From tg_tabl_tipo
         Where cod_grup_tipo = 303
           And cod_tipo != '0' --0
           And ind_acti = 1
           And cod_tipo = b.cod_clas_acta) des_codi_clas_acta,
       b.tip_resp,
       (Select des_tipo
          From tg_tabl_tipo
         Where cod_grup_tipo = 377
           And cod_tipo != '0' --0
           And ind_acti = 1
           And cod_tipo = b.tip_resp) des_tipo_resp,
       Case b.tip_resp
         When 1 Then
          b.cod_empl_resp
         When 2 Then
          '' || b.cod_clie_resp
         When 3 Then
          Null
       End cod_resp,
       Case b.tip_resp
         When 1 Then
          (Select nombre From v_empleado Where empleado = b.cod_empl_resp)
       /*When 2 Then \*pkg_generales.gefu_des_clie( 'VE_CLIENTE',*\
       b.cod_clie_resp \*, shpg_cte.kn_indi_tipo_nomb_larg)*\*/
         When 3 Then
          b.nom_otro_resp
       End des_resp,
       b.cod_empl_resp,
       b.cod_clie_resp,
       b.nom_otro_resp,
       b.cod_empl_gene,
       (Select nombre From v_empleado Where empleado = b.cod_empl_gene)  des_empl_gene,
       b.cod_empl_auto,
       (Select nombre From v_empleado Where empleado = b.cod_empl_auto)  des_empl_auto,
       a.cod_estd,
       Case a.cod_estd
         When '9' Then
          'A'
         When '12' Then
          'I'
       End tip_acta_inte,
       a.fec_crea fec_emis,
       a.num_acta,
       a.cod_seri_acta,
       a.tip_docu_acta,
       a.tip_docu_acta || '-' || a.cod_seri_acta || '-' || a.num_acta des_acta,
       Nvl((Select Sum(b.mon_anom)
        From ac_acta_deta b
       Where b.num_acta = a.num_acta
         And b.cod_seri_acta = a.cod_seri_acta
         And b.tip_docu_acta = a.tip_docu_acta
         And ((Null Is Null And b.cod_bove <>3 ) Or b.cod_bove = Null)),0) mon_sole,
       Nvl((Select Sum(b.mon_anom)
        From ac_acta_deta b
       Where b.num_acta = a.num_acta
         And b.cod_seri_acta = a.cod_seri_acta
         And b.tip_docu_acta = a.tip_docu_acta
         And ((3 Is Null And b.cod_bove <>3 ) Or b.cod_bove = 3)),0) mon_dola,
       a.num_carg_cust,
       a.ser_carg_cust,
       a.tip_carg_cust
  From shtd_admi_acta_anom a, ac_acta b
 Where a.num_acta = b.num_acta
   And a.cod_seri_acta = b.cod_seri_acta
   And a.tip_docu_acta = b.tip_docu_acta
   And a.cod_estd = '9'
   And a.cod_seri_acta = 'A' || lpad(1, 2, 0)
   And a.tip_Docu_Acta = 'AI'
   And a.fec_rece_acta Is Not Null
   And a.ind_auto_dcto = 1
 Order By a.num_acta
