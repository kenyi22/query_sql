Select cryptit.decrypt(pas_web,cryptit.key) From general.camc_usua where usu_web='MCARPIO'


Select * From shac.shtd_admi_acta_anom where num_acta=3413017

Select * From ve_punto where cod_punt=24814

Select 1, cod_punt_sucu_clie /*into nPtoClie , nPtoSuc*/
         from ve_clie_punt
         where cod_punt = 31836--:poms_orde_serv.cod_punt_usua_serv and 
  	           and cod_clie = 4026--:pomc_orde_serv.cod_clie ;
               
               Select * From ve_clie_punt where cod_clie = 4026 for update
               
               select * from tg_sucursal_htb
               Select * From apertura.hwmc_conf_parm_clie p where p.cod_clie in (2500,300);
               select * from apertura.hwmc_conf_pers_clie p where p.cod_razo_soci in (2219) and cod_sucu_htb in (1,15) for update;
               select * from apertura.HWMC_LOG_CONF_PARM p where p.cod_razo_soci in (2219)  and cod_sucu_htb in (15) for update;
               apertura.sys_c00112759
               
               select cod_razo_soci from ve_cliente where cod_clie in (2500,300);
               select T.COD_SUCU_HTB,T.* from GENERAL.CAMC_USUA T where usu_web in( 'GATAMARI') FOR UPDATE;
               SELECT T.COD_RAZO_SOCI,T.* FROM csmc_usua_web T where usu_web IN( 'GATAMARI','PCASO');
               select M.COD_SUCU_HTB,M.* from csmd_modu_clie M where usu_web IN( 'GATAMARI') FOR UPDATE;----aqui faltaba
               
               select p.cod_sucu_htb from ve_punto p where cod_punt =27651


VGUPIOC
RANGULOL.


Select * From canales.clmd_punt_rcau_acti where cod_equi_punt='0452'

select * from gvmd_telf_cntc
where instr(num_telf,',') >0

Insert Into tvtd_regi_aten_list
  (cod_secu_tipo_list,
   cod_aten,
   cod_list,
   ind_list_finl,
   fec_finl_list,
   fec_regi,
   cod_usua_regi,
   nom_comp_regi,
   fec_modi,
   cod_usua_modi,
   nom_comp_modi)
  Select v.cod_secu_tipo_list,
         '10000005452',  
         v.cod_tipo_list,
         0,
         Null,
         Sysdate,
         user,
         userenv('terminal'),
         Sysdate,
         user,
         userenv('terminal')
    From tvtd_list_tipo_aten v
   Where v.cod_grup_list = 493
     And v.cod_grup_aten = 494
     And v.cod_tipo_grup_aten = 4;
