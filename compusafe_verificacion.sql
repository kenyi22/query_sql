--ver lista de cs fisicos
Select (select sum(z.mon_valo_prod) from tvtd_mont_cmpb_bove z 
           where z.num_cmpb=t.num_cmpb 
           and z.cod_seri_cmpb=t.cod_seri_cmpb
           and z.tip_docu_cmpb=t.tip_docu_cmpb
           and z.cod_bove in (1,2)) mont_cont,
           (select sum(z.Cod_Bove) from tvtd_mont_cmpb_bove z 
           where z.num_cmpb=t.num_cmpb 
           and z.cod_seri_cmpb=t.cod_seri_cmpb
           and z.tip_docu_cmpb=t.tip_docu_cmpb
           and z.cod_bove in (1,2)) COD_BOVE,
           T.COD_PUNT_ORIG,
           t.*
  From tv_cmpb_serv t
 where t.cod_punt_orig = 24562
   and t.fec_emis > sysdate - 20
   and not exists (select 1
          from cstd_proc_hora_deta a
         where a.num_cmpb = t.num_cmpb
           and a.tip_docu_cmpb = t.tip_docu_cmpb
           and a.cod_seri_cmpb = t.cod_seri_cmpb)
   and not exists (select 1 from tvtd_mont_cmpb_bove a
         where a.num_cmpb = t.num_cmpb
           and a.tip_docu_cmpb = t.tip_docu_cmpb
           and a.cod_seri_cmpb = t.cod_seri_cmpb
           and a.cod_bove=2)
 order by t.fec_emis desc;
 --comprobante faltante = A01 80097797. se identifico por el monto
  Select s.*
           --Into ln_exis_usua_fond
           From cwtc_rweb_cmpb z, shmc_usua_fond s
          Where z.num_cmpb in( 80097797,80100118)
            And z.cod_seri_cmpb = 'A01'
            And z.tip_docu_cmpb = 'CS'
            And z.cod_clie_cnta = 3556--shpg_cte.kn_clie_fond_dife_3556
            And s.ind_comp_safe = 1
            And s.cod_clie_fond = z.cod_clie_cnta
            And s.cod_punt = z.cod_punt_orig
            And s.cod_sucu_fond = z.cod_sucu_htb
            And rownum < 2;
            
 Insert Into CSAFE.CSTD_CMPB_CUDR_REGU
   (COD_SUCU_HTB,
    NUM_CMPB,
    COD_SERI_CMPB,
    TIP_DOCU_CMPB,
    COD_BOVE,
    NOM_COMP_CREA,
    COD_USUA_CREA,
    FEC_CREA,
    NOM_COMP_MODI,
    COD_USUA_MODI,
    FEC_MODI)
   SELECT cod_sucu_htb,
          num_cmpb,
          cod_seri_cmpb,
          tip_docu_cmpb,
          cod_bove,
          nom_comp_crea,
          cod_usua_crea,
          fec_crea,
          nom_comp_modi,
          COD_USUA_MODI,
          fec_modi
     FROM CSWEB.CWTD_RWEB_CMPB_BOVE
    WHERE NUM_CMPB = 80097797;
 Update csweb.cwtc_rweb_cmpb
    set ind_ingr_manu = 1, tip_cmpb_safe = 2
  Where num_cmpb = 80097797
    and cod_seri_cmpb = 'A01'
    and tip_docu_cmpb = 'CS';

 Select t.tip_orig_cmpb_virt,t.tip_cmpb_safe,t.* From csweb.cwtc_rweb_cmpb t where num_cmpb IN( 80097797,80100118) for update;
 
 select * from cstd_proc_hora_deta where num_cmpb=80097797
  Select t.* From csweb.cwtd_rweb_cmpb_bove t where num_cmpb IN( 80097797,80100118);
  Select * From tvtd_mont_cmpb_bove t where num_cmpb IN( 80097797,80100118);
 Select * From csweb.cwtc_rweb_cmpb t where num_cmpb=80097797;
Select *
          From csafe.cstd_cmpb_cudr_regu cu
          Where cu.num_cmpb IN( 80097797,80100118)
          And cu.cod_seri_cmpb = 'A01'
          And CU.TIP_DOCU_CMPB = 'CS'--cu.tip_docu_cmpb
; 
SELECT  (Select
                Case
                  When csweb.tip_cmpb_safe  = 2 Then 'FISICO'
                  Else 'VIRTUAL'
                  End result_set
                From dual) tipo_cs, csweb.* --Tipo CS
 From csweb.cwtc_rweb_cmpb csweb, tv_cmpb_serv tv
            Where csweb.cod_sucu_htb = 1
              And csweb.cod_clie = 118
              And csweb.cod_punt_orig = 24562
              And csweb.tip_cmpb_safe In (1, 2, 3)
              And tv.cod_sucu_htb(+) = csweb.cod_sucu_htb
              And tv.cod_clie(+) = csweb.cod_clie
              And tv.cod_punt_orig(+) = csweb.cod_punt_orig
              And tv.cod_seri_cmpb(+) = csweb.cod_seri_cmpb
              And tv.tip_docu_cmpb(+) = csweb.tip_docu_cmpb
              And tv.num_cmpb(+) = csweb.num_cmpb
              And ((csweb.est_cmpb_virt = 1 And csweb.fec_crea >= &pd_fec_ini And csweb.fec_crea <= &pd_fec_fin) 
                    Or (csweb.est_cmpb_virt <> 1 And tv.fec_proc_aper >= &pd_fec_ini And tv.fec_proc_aper <= &pd_fec_fin ))
            AND TV.NUM_CMPB=80097797 
             Order By tv.fec_crea Asc
              
              
              ;
Select * From csmc_maqu_safe where cod_punt=24562;
--0. verificar servicio
Select * From cstc_serv t where t.cod_equi=4004 order by t.fec_fina desc;
--1. verificar hora de corte
Select * from csmd_maqu_safe_deta t Where t.cod_maqu_safe In (42701036);
--cortes
Select * from cstc_proc_hora_cort t Where t.cod_maqu_safe= 200037 Order By t.fec_fina_proc Desc;--recojo 16/12/2016 15:31:32 21/12/2016 11:54 :: 20/12/2016 0:30:00    21/12/2016 0:30:00
Select * from cstc_proc_hora_cort t Where t.cod_maqu_safe= 100037 Order By t.fec_fina_proc Desc;--20/12/2016 11:38:34     21/12/2016 0:30:00
Select * from cstc_proc_hora_cort t Where t.cod_maqu_safe= 4003 Order By t.fec_fina_proc Desc;--20/12/2016 15:23:46   21/12/2016 2:00:00
Select * from cstc_proc_hora_cort t Where t.cod_maqu_safe= 7 Order By t.fec_fina_proc Desc;--20/12/2016 16:34:29   21/12/2016 0:30:00

--2. transacciones pendientes de generar cs (ind_proc=0)
Select *
  From cstc_tran t
Where t.cod_equi = 200037
   And t.fec_fina >=
       to_date('11/01/2017 11:30:00 ', 'dd/mm/yyyy hh24:mi:ss')--30/12/2016 13:04:15
   And t.fec_fina < to_date('12/01/2017 00:30:00', 'dd/mm/yyyy hh24:mi:ss')
   And t.ind_proc = 0
   And t.mon_cont > 0;
   
Select *
  From cstc_tran t
Where t.cod_equi = 100037
   And t.fec_fina >=
       to_date('20/12/2016 11:38:34', 'dd/mm/yyyy hh24:mi:ss')
   And t.ind_proc = 0
   And t.mon_cont > 0
   And t.fec_fina < to_date('21/12/2016 00:30:00', 'dd/mm/yyyy hh24:mi:ss');
Select *
  From cstc_tran t
Where t.cod_equi = 3
   And t.fec_fina >=
       to_date('20/12/2016 15:23:46', 'dd/mm/yyyy hh24:mi:ss')
   And t.ind_proc = 0
   And t.mon_cont > 0
   And t.fec_fina < to_date('21/12/2016 02:00:00', 'dd/mm/yyyy hh24:mi:ss');
Select *
  From cstc_tran t
Where t.cod_equi = 7
  And t.fec_fina >=
       to_date('20/12/2016 16:34:29', 'dd/mm/yyyy hh24:mi:ss')
   And t.ind_proc = 0
   And t.mon_cont > 0
   And t.fec_fina < to_date('21/12/2016 00:30:00', 'dd/mm/yyyy hh24:mi:ss');
--4. obtener datos de la query anterior 
100037 20/12/2016 22:50:47 21/12/2016 00:30:00 47069
3      20/12/2016 21:19:47 21/12/2016 00:30:00 47085
7      20/12/2016 21:35:43 21/12/2016 00:30:00 47090
--5. ejecutar webservice URL: http://srvoas3.hermes.com.pe:8903/GestionarComprobanteVirtual/GestionarComprobanteProtTypePort
tipoProceso

0: corte
1: recojo

<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ges="http://hermes.com.pe/schema/csafe/GestionarComprobanteVirtual">
   <soapenv:Header/>
   <soapenv:Body>
      <ges:generarCmpbCsafeRequestType>
         <ges:codigoCompusafe>100037</ges:codigoCompusafe>
         <ges:fechaInicial>20/12/2016 22:50:47</ges:fechaInicial>
         <ges:fechaFinal>21/12/2016 00:30:00</ges:fechaFinal>
         <ges:tipoProceso>0</ges:tipoProceso>
         <ges:codigoServicio>47069</ges:codigoServicio>
      </ges:generarCmpbCsafeRequestType>
   </soapenv:Body>
</soapenv:Envelope>

