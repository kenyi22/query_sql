Select * From 


SAPG_ATEN_RECL .sapr_cons_aten_bloq


Select A.COD_CANL_RPTA, A.FEC_CRRE,A.Fec_Fina_Aten, A.FEC_FINL_RPTA, A.*
From tvtc_regi_aten A WHERE COD_ATEN = 10000005597;

EMAIL = 3


SAPG_ATEN_RECL .safu_tipo_cons(7,Null,Null);


  Select *--des_tipo, cod_tipo     
                     From tg_tabl_tipo     
                    Where cod_grup_tipo =  511  
                      And cod_tipo != '0'    
                      And des_tipo Is Not Null     
                    Order By to_number(7)  ;
                    
                    
                    update tvtc_regi_aten A
                       set A.COD_CANL_RPTA = '3',
                           A.FEC_FINL_RPTA = '12/12/2016',
                           A.FEC_CRRE      = '13/12/2016',
                           A.FEC_FINA_ATEN = '13/12/2016'
                     WHERE A.COD_ATEN = 10000005597;
