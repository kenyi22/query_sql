alter user kcanchi identified by hermes20 account unlock;
alter user harana identified by hermes20 account unlock;

Select * From general.cstc_perf_usua where cod_usua_acce in ('HARANA') /*and cod_modu = 'SH' */ for update;

----lo principal----
Select *
  From dltc_ubic_anaq a
 where a.cod_bove = 3
   and a.cod_anaq = 7
   and a.num_colm_anaq = 2
   and a.num_fila_anaq = 3 
   and a.num_colm_secc = 1
   and a.num_fila_secc = 1;
-----------   
Select * From DLMC_ANAQ where cod_bove = 3 and cod_anaq = 7;

Select num_colm_anaq||num_fila_anaq||num_colm_secc||num_fila_secc s_item,
                            '('||num_colm_anaq||','||num_fila_anaq||') ('||num_colm_secc||','||num_fila_secc||')' s_item01,
                            num_cmpb, num_caja from dltc_ubic_anaq
                            Where cod_sucu = 1 and
                                  cod_bove = 3 and 
                                  cod_anaq = 7
                                  order by 1;
                                  
                                  Select * From pe_reloj where empleado='26999' and fec_regi>='01/11/2016' ORDER BY FEC_REGI DESC
ISANCHE

EESCALAYz

Select * From csmc_usua WHERE COD_USUA IN ('KCANCHI') FOR UPDATE;
Select * From general.cstc_perf_usua where cod_usua_acce in ('KCANCHI') and cod_modu = 'SH' FOR UPDATE
Select * From USUARIO WHERE COD_USUA='HARANA' FOR UPDATE; --PARA CAMBIAR EN APERTURA
Select * From it_soap.usua_soap

Select * from csmd_modu_clie t Where t.usu_web In ('HARANA') FOR UPDATE

Select * From tv_envase for update

Select * From pe_reloj where empleado='26999' and fec_regi between '07/11/2016' and '11/11/2016' order by fec_regi

Select * From gemc_send_mail where COD_USUA_GENE='EPAZ' and txt_subj like '%10000004963%';

Select * From TG_SUCURSAL_HTB


SAPG_ATEN_RECL. sapr_cons_aten_bloq

Select * From csmd_modu_clie where usu_web in ('EPAZ') FOR UPDATE;


Select * From general.camc_usua where usu_web='EPAZ' for update
---
Select * From dba_role_privs where grantee in ('AVASSALL');

Select * From general.cstc_perf_usua a where a.cod_modu = 'CB' and a.cod_usua_acce = 'KCANCHI' for update;
Select * From tg_calendario_sucu where cod_sucu_htb=19 and fec_cale>='01/11/2016' for update;

insert into cbmc_ruta (COD_SUCU, COD_RUTA, DES_RUTA, TIP_RUTA, NOM_COMP_MODI, COD_USUA_MODI, FEC_MODI, COD_RUTA_PLAN, MON_MAXI, COD_RUTA_PLAN_SABA, COD_RUTA_PLAN_DOMI, COD_RUTA_PLAN_FERI, IND_MONE, IND_RUTA_LARGA, TIP_RUTA_ALFA, SUB_TIPO_RUTA_ALFA, IND_TURN_MANA, IND_TURN_TARD, IND_RUTA_FICT, NOM_COMP_CREA, COD_USUA_CREA, FEC_CREA)
values (19, 0, 'RUTA DUMMY', '0', Userenv('Terminal'), User, Sysdate, null, null, null, null, null, null, null, Null, Null, Null, Null, 1, Userenv('Terminal'), User, Sysdate);

--

insert into cbtc_prog_ruta
    (cod_sucu,fec_prgn,cod_ruta,cod_turn,tip_ruta,hor_ingr,cod_ruta_plan,cod_sect,ind_crre_radi,
     hor_tent_sali,nom_comp_modi,cod_usua_modi,fec_modi,ind_mone,ind_ruta_larga,ind_ruta_llena,
     ind_crre_web,tip_ruta_alfa,sub_tipo_ruta_alfa)
    values
    (19, '17/12/2016', 0, 1, 0, sysdate, null, 0, 0,
     null, userenv('terminal'), user, sysdate, null, null, null, null, null, null);


Select * From BLINDADO.CBMD_RUTA WHERE COD_SUCU=19;
Select * From CBMC_RUTA WHERE COD_SUCU=19 FOR UPDATE;
Select * From CBTC_PROG_RUTA WHERE COD_SUCU=18 and fec_prgn = '17/12/2016' FOR UPDATE;
Select * From Cbmc_Sect where cod_sucu = 19 and cod_sect = 0 for update

Select * From ALL_CONSTRAINTS A WHERE A.CONSTRAINT_NAME='SYS_C00111075';
Select * From ALL_CONSTRAINTS A WHERE A.r_CONSTRAINT_NAME='SYS_C00107132';

select * from CBTC_PROG_RUTA where cod_sucu = 19;


Select * From v_empleado where empleado='9507' for update;
Select * From general.cstc_perf_usua where cod_usua_acce in ('JOLGUIN') and cod_modu = 'SH';
Select * From it_soap.cstc_perf_usua_soap where cod_usua_acce in ('JOLGUIN')

Select * From v_empleado where nombre like '%HILARIO%';--9507
--ACTIVAR USUARIOS

SELECT * FROM general.cSmc_usua_web where USU_WEB IN ('JZEVALLS','HARANA','JANGULO') FOR UPDATE ;

SELECT * FROM general.cAmc_usua where USU_WEB  IN ('JZEVALLS','HARANA','JANGULO') FOR UPDATE;


SELECT COD_CORP,COD_RAZO_SOCI,COD_CLIE,COD_PUNT,U.* FROM general.cSmc_usua_web U where USU_WEB LIKE ('UTRXACO') --for update

 update csmc_usua_web
       set cod_punt = null, cod_corp =4577
     where usu_web = 'UTRXACO';
  
    update csmd_modu_clie
       set cod_corp = 4577
     where usu_web = 'UTRXACO';
