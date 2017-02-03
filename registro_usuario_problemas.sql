SELECT BT_TRAB_PROC_BTMS.TIP_TRAB_RECU
               --INTO   :global.tipo_usuario
               FROM   BT_TRAB_PROC_BTMS, PE_PERSONAL, USUARIO
                      WHERE (USUARIO.COD_USUA = 'ACHIPANA') AND
                            (BT_TRAB_PROC_BTMS.COD_TRAB = PE_PERSONAL.COD_TRAB)  AND
                            BT_TRAB_PROC_BTMS.IND_ACTI = 1 AND
                            (USUARIO.COD_TRAB = PE_PERSONAL.COD_TRAB);

Select * From USUARIO WHERE COD_USUA in  ('ACHIPANA');

Select * From PE_PERSONAL WHERE COD_TRAB IN (27484);

Select * From BT_TRAB_PROC_BTMS WHERE COD_TRAB = 27484;

AChipana y msaavedr

Select * From PE_PERSONAL where APE_PTNO LIKE '%CANCHI%'


                            
