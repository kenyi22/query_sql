Select * From it_soap.cbtd_hoja_ruta_soap r Where r.num_cmpb_atm_prin=4343956;

Select * From ve_punto p Where p.cod_punt=31800; -- GNB - ATM 406 UN. CHACARILLA

Select * From ve_punto p where p.des_punt likE '%ISLA %PETRO%'

Select r.num_cmpb_atm_prin, r.cod_seri_atm_prin, r.tip_docu_atm_prin, r.*
From cbtd_hoja_ruta r Where r.cod_sucu=1 And r.fec_prgn='09/01/2017' And r.cod_punt=31800
For Update;

Select * from ac_pedido_deta d Where d.num_cmpb_atm_prin=3548;

Select * From ac_pedido p Where p.num_pedi=3170713;--16

Select * From ac_pedido p Where p.num_pedi=3548 and p.cod_sucu_htb=16 for update;

Select * From tg_sucursal_htb
