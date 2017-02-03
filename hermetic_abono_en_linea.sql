Select * From csmc_maqu_safe where cod_maqu_safe=100005 for update


Select * from gemc_tabl_parm Where cod_grup_parm = 142;
Select * from tg_tabl_tipo Where cod_grup_tipo = 669;


Select * From csmd_maqu_safe_deta where cod_maqu_safe=100005;


shpg_ingr_reme .shfu_esta_vali_modi_reme

select a.num_cmpb,a.cod_seri_cmpb,a.tip_docu_cmpb /*Fecha del dia*/
                from bt_remesa a
               where a.num_cmpb = pn_nume_cmpb and
                     a.cod_seri_cmpb = pv_codi_seri_cmpb and
                     a.tip_docu_cmpb = pv_tipo_cmpb
