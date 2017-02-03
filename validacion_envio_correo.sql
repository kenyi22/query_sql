Select * From radio.tvtc_regi_aten where cod_aten='10000004283' for update

update radio.tvtc_regi_aten set IND_ANLS_PRCD=1 where cod_aten='10000004283';

--verificacion envio a direccion de email
Select * From sa_dire_mail where dir_mail like '%@GRUPOSALCANI%';--3082
--verificar si le enviaron correos
Select * From sa_regi_envi_clie where cod_clie='4285' and fec_proc>='01/01/2017';

Select * From sa_regi_envi_clie where /*fec_proc='08/11/2016' and*/ cod_clie=4285
--consultar
Select * From gemd_send_mail where nom_arch_orig like '%ASIA GRIFOS _DIA_130117_1746%';
--SACUSRSAC111116101630738
Select * From gemc_send_mail where id='SACUSRSAC13011710321676'
--
Select * From gemc_send_mail where dir_para like '%@CINEMARK%'
--
Select * From gemd_send_mail where id='SACUSRSAC111116101630744'

Select * From ve_cliente where nom_clie like '%DIRECTV%'
