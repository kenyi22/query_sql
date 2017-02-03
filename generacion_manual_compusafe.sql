--generacion manual de cs compusafe

select * from ve_punto where des_punt like '%ALEGRIA%COMPU%';
select * from csmc_maqu_safe where cod_punt=25492;--100037,4010--TEPSA por COD_MAQ_SAFE
select * from cstc_serv where fec_inic >= '27/12/2016' and cod_equi = 100037; -- cabecera
select * from cstd_serv_deta where cod_serv = 47366; --serv detalle por canister 10003727122016113420
select * from cstc_tran where /*cod_tran_csaf='10003727122016113420' and */cod_serv=47366  and mon_cont>0 and ind_proc=0 order by fec_fina desc; --cabecera de transacciones: ind_proc: 1(incluido cmpb). cod_tarj=que usuario deposito
select * from csmc_tarj_pers where cod_tarj = 409487; -- tabla de tarjeta x persona
select * from csmc_pers where cod_pers = 41908; -- tabla de personas
select * from cstd_tran_deta_cons where cod_tran=1016913 ; --detalle de transacciones (x denominacion). tip_depo (1=contiene; 2=dice contener)




--descuadre de un corte de las 8:30
select c.cod_tipo_valo, (select x.tip_unid_htb from csmc_tipo_valo x where x.cod_tipo_valo = c.cod_tipo_valo),
sum(b.mon_tota) from cstc_tran a,
              cstd_tran_deta_cons b,
              csmc_deno c
where a.cod_serv=47366 and a.fec_fina >= to_date('311220161213','ddmmyyyyhh24mi') and a.fec_fina < to_date('311220162309','ddmmyyyyhh24mi')
and a.cod_tran = b.cod_tran
and b.tip_depo = 1 --solo los contiene 
and c.cod_deno = b.cod_deno
group by c.cod_tipo_valo;


select * from cstc_proc_sync where cod_maqu_safe = 100037 --log de sincronizaciones
select * from cstc_proc_hora_cort where cod_maqu_safe = 100037; --log de cmpb
select * from cstd_proc_hora_deta --detalle log cmpb


select * from cstc_serv where fec_inic >= '01/04/2015' and cod_equi = 100037; -- cabecera
select * from cstd_serv_deta where cod_serv = 44297; --serv detalle por canister
select a.* from cstc_tran a where a.cod_serv=44297 and a.fec_fina >= to_date('141120160030','ddmmyyyyhh24mi') and a.fec_fina < to_date('151120160030','ddmmyyyyhh24mi'); --cabecera de transacciones: ind_proc: 1(incluido cmpb). cod_tarj=que usuario deposito
select * from csmc_tarj_pers where cod_tarj = 140; -- tabla de tarjeta x persona
select * from csmc_pers where cod_pers = 244; -- tabla de personas
select *
  from cstd_tran_deta_cons
 where cod_tran in
       (select a.cod_tran
          from cstc_tran a
         where a.cod_serv = 44297
           and a.fec_fina >= to_date('141120160030', 'ddmmyyyyhh24mi')
           and a.fec_fina < to_date('151120160030', 'ddmmyyyyhh24mi')); --detalle de transacciones (x denominacion). tip_depo (1=contiene; 2=dice contener)

--descuadre de un corte de las 8:30
select c.cod_tipo_valo, (select x.tip_unid_htb from csmc_tipo_valo x where x.cod_tipo_valo = c.cod_tipo_valo), a.*
--sum(b.mon_tota)
 from cstc_tran a,
              cstd_tran_deta_cons b,
              csmc_deno c
where a.cod_serv=44297 and a.fec_fina >= to_date('141120160030','ddmmyyyyhh24mi') and a.fec_fina < to_date('151120160030','ddmmyyyyhh24mi')
and a.cod_tran = b.cod_tran
and b.tip_depo = 1 --solo los contiene 
and c.cod_deno = b.cod_deno
--group by c.cod_tipo_valo;



--descuadre de un corte de las 8:30
select c.cod_tipo_valo, (select x.tip_unid_htb from csmc_tipo_valo x where x.cod_tipo_valo = c.cod_tipo_valo),--, a.*
sum(b.mon_tota)
 from cstc_tran a,
              cstd_tran_deta_cons b,
              csmc_deno c
where a.cod_serv=44297 and a.fec_fina >= to_date('141120161715','ddmmyyyyhh24mi') and a.fec_fina < to_date('151120160030','ddmmyyyyhh24mi')
and a.cod_tran = b.cod_tran
and b.tip_depo = 1 --solo los contiene 
and c.cod_deno = b.cod_deno
--and c.tip_unid_htb='2'
group by c.cod_tipo_valo;

Select a.* From  csmc_deno a where a.cod_equi_csaf='100037'

Select * From tg_tabl_tipo where cod_grup_tipo=19

select * from cstc_proc_sync where cod_maqu_safe = '4056' --log de sincronizaciones
select * from cstc_proc_hora_cort; --log de cmpb
select * from cstd_proc_hora_deta --detalle log cmpb


--link de web service
http://srvoas3.hermes.com.pe:8903/GestionarComprobanteVirtual/GestionarComprobanteProtTypePort?WSDL



--request
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ges="http://hermes.com.pe/schema/csafe/GestionarComprobanteVirtual">
   <soapenv:Header/>
   <soapenv:Body>
      <ges:generarCmpbCsafeRequestType>
         <ges:codigoCompusafe>100037</ges:codigoCompusafe>
         <ges:fechaInicial>27/09/2016 17:57:00</ges:fechaInicial>
         <ges:fechaFinal>28/09/2016 00:30:00</ges:fechaFinal>
         <ges:tipoProceso>0</ges:tipoProceso>
         <ges:codigoServicio>43195</ges:codigoServicio>
      </ges:generarCmpbCsafeRequestType>
   </soapenv:Body>
</soapenv:Envelope>

--result

<S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/">
   <S:Body>
      <generarCmpbCsafeResponseType xmlns:ns2="http://hermes.com.pe/schema/common/types/faults" xmlns="http://hermes.com.pe/schema/csafe/GestionarComprobanteVirtual">
         <codigoCompusafe>100037</codigoCompusafe>
         <cmpbCompusafe>
            <tipDocuCmpb>CS</tipDocuCmpb>
            <codSeriCmpb>A01</codSeriCmpb>
            <numCmpb>90229871</numCmpb>
         </cmpbCompusafe>
         <indResu>0</indResu>
         <desResu>Proceso Exitoso</desResu>
      </generarCmpbCsafeResponseType>
   </S:Body>
</S:Envelope>


Select * From csmd_modu_clie where usu_web='HARANA' and cod_modu='HW' for update


Select * From cstc_proc_hora_cort where cod_serv=44297 order by fec_crea
