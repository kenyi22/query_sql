insert into cbtc_soli_frec
  (cod_punt_serv_actu,
   cod_ndia_serv_actu,
   cod_sucu,
   nse_secu_serv_actu, --<MMORALES> <25/09/2015> <REQ-01>
   hor_inic,
   hor_finl,
   nom_comp_modi,
   cod_usua_modi,
   fec_modi,
   -- fmel 13.01.10 
   cod_tipo_reme,
   num_cant_enva
   --
   )
values
  (:satc_matr_punt1.cod_punt_serv,
   :satc_matr_punt1.cod_ndia_serv,
   :control.s_cod_sucu_htb,
   ln_nse_secu, --<MMORALES> <25/09/2015> <REQ-01>
   :satc_matr_punt1.hor_inic, --to_date('01/01/1900 '||to_char(:satc_matr_punt1.hor_inic,'hh24:mi'),'dd/mm/yyyy hh24:mi'),
   :satc_matr_punt1.hor_finl, --to_date('01/01/1900 '||to_char(:satc_matr_punt1.hor_finl,'hh24:mi'),'dd/mm/yyyy hh24:mi'),
   userenv('terminal'),
   user,
   sysdate,
   -- fmel 13.01.10 
   :satc_matr_punt1.cod_tipo_reme,
   :satc_matr_punt1.num_cant_enva
   --
   );

Select * From cbtc_soli_frec;
Select * From pptc_soli_frec;

Insert Into pptc_soli_frec
  (cod_sucu_htb,
   cod_punt_serv,
   cod_ndia_serv,
   hor_inic_prog,
   hor_finl_prog,
   nse_secu_serv_actu,
   hor_inic,
   hor_finl,
   ind_conf,
   cod_tran)
Values
  (:control.s_cod_sucu_htb,
   :satc_matr_punt1.cod_punt_serv,
   :satc_matr_punt1.cod_ndia_serv,
   :satc_matr_punt1.hor_inic,
   :satc_matr_punt1.hor_finl,
   ln_nse_secu,
   :satc_matr_punt1.hor_inic,
   :satc_matr_punt1.hor_finl,
   :satc_matr_punt1.ind_conf,
   :satc_matr_punt1.tip_trxn);
   

USER: LRODRIG
PASS:AKUKA#745 (minuscula)
ROL_HERMES
ROL_RADIO

USER: MIQUISPE
PASS:DSAZ$962
ROL_HERMES
ROL_RADIO
ROL_BETA
ROL_DOCU


USER: SPEREZF	
PASS:HERME$66
ROL_HERMES
ROL_RADIO
