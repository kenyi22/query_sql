Select a.cod_trab, b.empleado, a.tip_trab_recu, c.nombre
/*  into lv_cod_trab,
       :control.s_empleado,
       lv_tip_trab,
       :control.s_des_empleado*/
  from usuario b, bt_trab_proc_btms a, v_empleado c
 where b.cod_usua IN ('EPAUCAR','ACHIPANA','MSAAVEDR')
   and c.empleado = b.empleado
   and c.estado_empleado = 'ACTI'
   and a.cod_trab = b.cod_trab;


Select * From usuario where cod_usua IN ('EPAUCAR','ACHIPANA') FOR UPDATE
Select * From bt_trab_proc_btms  WHERE COD_TRAB IN (26999,27484,15485) for update
