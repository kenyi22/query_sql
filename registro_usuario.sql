Select *
  From VD_CLIENTE_CNTC
 where cod_clie = 2312
   and des_dire_elct_cntc is Not Null
   and Instr(des_dire_elct_cntc, '@') != 0/* for update */
   and (cod_secu_cntc is null or
       (cod_secu_cntc is not null and nvl(ind_retr_manf, 0) = 1)) 


Select * From general.cstc_perf_usua where cod_usua_acce='KCANCHI' and cod_modu='SH' FOR UPDATE;

Select * From general.Cstc_Acce_Modu_Perf where COD_OPCI = 'SHF2031';
Select * From general.Cstc_Acce_Modu_Perf where COD_PERF = 'ASIS' AND COD_MODU = 'SH';
Select * From general.csmc_usua where cod_usua='KCANCHI' FOR UPDATE;

Select z.num_guia,z.* from ac_acta z where z.num_guia IN (6148 );
Select z.num_guia,z.* from ac_acta z where z.num_guia IN (6148 );
select * from tg_ctrl_nume where /*COD_SERI='A08' AND*/TIP_DOCU='GE'

select * from tg_sucursal_htb where cod_sucu_htb=10;

Select s.num_guia,s.* From AC_ACTA s WHERE s.NUM_ACTA=162787;

Select f.* From it_soap.ac_ f where f.num_acta_pk=162787;


s shpg_admi_anom .shfu_vali_codi_orig



Select * From tg_tabl_tipo where cod_grup_tipo =780

