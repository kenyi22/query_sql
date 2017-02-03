Select /*ve.empleado,
                        ve.nombre,
                        ve.estado_empleado,
                        ve.puesto,
                        ve.des_puesto,
                        ve.centro_costo,
                        6 cod_role_empl*/ *
                   From v_empleado ve, gemd_proc_ctrl_pues b, pptc_func_trip c
                  where ve.estado_empleado = 'ACTI'--pppg_cons_gene.esta_empl
                    and b.cod_sucu_htb = 1--pn_codi_sucu
                    and ve.centro_costo = b.cod_cent_cost
                    and ve.puesto = b.cod_pues
                    and b.ind_acti = 1--pppg_cons_gene.INDI_VALO_ACTI
                    and b.cod_ctrl_pues =1-- pppg_cons_gene.codi_ctrl_pues_trip
                    and ve.centro_costo ='01.99.22'-- pppg_cons_gene.CODI_CECO_OPER_BLIN
                    and ve.empleado = c.cod_empl
                    and c.cod_func = 17--pppg_cons_gene.kv_codi_oper_logi
                    and c.ind_vige = 1

select *
from cstc_perf_usua a
where a.cod_usua_acce = 'KCANCHI'
and a.cod_modu ='CB' for update;

select *
from csmc_usua a
where a.cod_usua = 'KCANCHI'for update;
