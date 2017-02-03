Kenyi:
Envío los pasos como se generó el CV virtual:


--1. verificar hora de corte
Select * from csmd_maqu_safe_deta t Where t.cod_maqu_safe In (100037);
--cortes
Select * from cstc_proc_hora_cort t Where t.cod_maqu_safe= 48 Order By t.fec_fina_proc Desc;--recojo 16/12/2016 15:31:32 21/12/2016 11:54 :: 20/12/2016 0:30:00    21/12/2016 0:30:00
Select * from cstc_proc_hora_cort t Where t.cod_maqu_safe= 100037 Order By t.fec_fina_proc Desc;--20/12/2016 11:38:34     21/12/2016 0:30:00
Select * from cstc_proc_hora_cort t Where t.cod_maqu_safe= 3 Order By t.fec_fina_proc Desc;--20/12/2016 15:23:46   21/12/2016 2:00:00
Select * from cstc_proc_hora_cort t Where t.cod_maqu_safe= 7 Order By t.fec_fina_proc Desc;--20/12/2016 16:34:29   21/12/2016 0:30:00

--2. transacciones pendientes de generar cs (ind_proc=0)
Select *
  From cstc_tran t
Where t.cod_equi = 100037
   And t.fec_fina >=
       to_date('28/12/2016 00:30:00', 'dd/mm/yyyy hh24:mi:ss')
   And t.fec_fina < to_date('29/12/2016 00:30:00', 'dd/mm/yyyy hh24:mi:ss')
   And t.ind_proc = 0
   And t.mon_cont > 0
   order by t.fec_fina desc;

--4. obtener datos de la query anterior 
28/12/2016 00:30:00	29/12/2016 00:30:00	0	47366

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
