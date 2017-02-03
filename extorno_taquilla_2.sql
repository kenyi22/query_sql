SELECT TO_DATE(M.FEC_RECE_BOVE), M.FEC_CREA, COD_RUTA_ORIG, NSE_ENTG, (SELECT INITCAP(NOMBRE) FROM CSMC_USUA A, V_EMPLEADO B WHERE A.COD_USUA = M.COD_USUA_CREA AND B.EMPLEADO = A.EMPLEADO),
                       (SELECT INITCAP(NOMBRE) FROM CSMC_USUA A, V_EMPLEADO B WHERE A.COD_USUA = M.COD_USUA_BOVE AND B.EMPLEADO = A.EMPLEADO),
                       --NVL(M.CAN_TOTL_CMPB,0) CAN_CMPB, NVL(M.CAN_TOTL_CAJA,0) CAN_TOTL_CAJA, NVL(M.CAN_TOTL_BOLS,0) CAN_TOTL_BOLS, ---Código Comentado JaRojas 24/09/2012 - REQ. 1924
                       (NVL(M.CAN_TOTL_CMPB, 0) - NVL(CAN_TOTL_CMPB_CARG,0)) CAN_CMPB, (NVL(M.CAN_TOTL_CAJA,0) - NVL(CAN_TOTL_CAJA_CARG,0) ) CAN_TOTL_CAJA, (NVL(M.CAN_TOTL_BOLS,0) - NVL(CAN_TOTL_BOLS_CARG,0)) CAN_TOTL_BOLS, ---Adición de Código JaRojas 24/09/2012 - REQ. 1924
                                              M.COD_SUCU_HTB, M.COD_TURN, M.COD_TAQU, M.EST_RECE_BOVE, M.FEC_ORIG FEC_ORIG_TAQU   
                                              ,m.fec_orig,m.cod_ruta_orig, M.TIP_DEST_REME
                                              FROM TVTC_ENVA_RECE M,  BT_TAQU_SUCU B
                                              WHERE M.EST_RECE_BOVE = 2 AND
                                                            M.COD_SUCU_HTB =   1 AND
                                                             m.fec_orig=('24/12/2016')and
                                                             --Eliminación de código. CF 27/06/2015 REQ004289
                                                             --TO_DATE(M.FEC_RECE_BOVE) >= PD_FEC_RECP  AND
                                                             --TO_DATE(M.FEC_RECE_BOVE) <= SYSDATE  AND
                                                             --Fin. CF 27/06/2015 REQ004289
                                                             --Adición de código. CF 27/06/2015 REQ004289
                                                             --to_date(m.fec_rece_bove) >= ('03/01/2017')   And
                                                             --to_date(m.fec_rece_bove) <= ('04/01/2017') And
                                                             --Fin CF 27/06/2015 REQ004289
                                                             B.COD_SUCU = M.COD_SUCU_HTB AND
                                                             B.COD_TAQU = M.COD_TAQU AND
                                                             B.TIP_TAQU = 2 AND
                                                             --M.COD_RUTA_ORIG LIKE PV_COD_RUTA AND
                                                              m.nse_entg =7 and
                                                             M.TIP_DEST_REME = '3'                                                            
                                               ORDER BY M.FEC_RECE_BOVE, M.FEC_CREA;
                                               
  UPDATE TVTC_ENVA_RECE A
     SET COD_TURN_BOVE = NULL,
         FEC_RECE_BOVE = NULL,
         TIP_ANTE_BOVE = NULL,
         COD_USUA_BOVE = 'KCANCHI',
         EST_RECE_BOVE = '1',
         TIP_TAQU_TURN = NULL
   WHERE A.COD_SUCU_HTB = 1
     AND
        --A.FEC_ORIG = :RECE_RUTA_BOVE.FEC_RECP AND   
         TO_DATE(A.FEC_RECE_BOVE, 'DD/MM/RRRR') = '24/12/2016'
     AND A.COD_RUTA_ORIG = 21
     AND A.COD_TURN = 1
     AND A.COD_TAQU = 'M13'
     AND A.NSE_ENTG = 7;
     
     Select A.COD_TURN_BOVE,
         A.FEC_RECE_BOVE,
         A.TIP_ANTE_BOVE,
         A.COD_USUA_BOVE,
         A.EST_RECE_BOVE,
         A.TIP_TAQU_TURN FROM TVTC_ENVA_RECE A
 WHERE A.COD_SUCU_HTB = 1
     AND
        --A.FEC_ORIG = :RECE_RUTA_BOVE.FEC_RECP AND   
         TO_DATE(A.FEC_RECE_BOVE, 'DD/MM/RRRR') = '24/12/2016'
     AND A.COD_RUTA_ORIG = 21
     AND A.COD_TURN = 1
     AND A.COD_TAQU = 'M13'
     AND A.NSE_ENTG = 7;
