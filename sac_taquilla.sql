--ELIMINA
SELECT * FROM tvtd_bols_rece t WHERE t.num_cmpb = 410899 AND t.cod_seri_cmpb = 'A15' FOR UPDATE;
SELECT * FROM tvtd_cmpb_rece t WHERE t.num_cmpb = 410899 AND t.cod_seri_cmpb = 'A15' FOR UPDATE;
--DISMINUYE
Select t.Can_Totl_Bols, t.Can_Totl_Cmpb, t.*
  From Tvtc_Enva_Rece t
Where Exists (Select 1
          From Tvtd_Cmpb_Rece a
         Where t.Cod_Sucu_Htb = a.Cod_Sucu_Htb
           And t.Fec_Orig = a.Fec_Orig
           And t.Cod_Ruta_Orig = a.Cod_Ruta_Orig
           And t.Cod_Turn = a.Cod_Turn
           And t.Nse_Entg = a.Nse_Entg
           And a.Num_Cmpb In (410899
)
           And a.Cod_Seri_Cmpb = 'A15')
   For Update;

--ELIMINA
Select T.* from  SHTC_CDRE_HIST T Where NUM_CMPB=410899 FOR UPDATE;
Select T.* from  SHTC_CDRE_HIST T Where NUM_CMPB in (13764389,14046246,14046248) and t.cod_sucu_htb=15
--DISMINUYE
Select T.CAN_BOLS_CDRE,T.CAN_CAJA_CDRE,T.* from  SHTC_CDRE_BOVE T Where COD_SUCU_HTB=15 AND NUM_CDRE_BOVE =1673 And TIP_TAQU_CDRE=1 for update ;
