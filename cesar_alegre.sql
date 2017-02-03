
select (Case
         When m.IND_ACTI = 1 Then
          'ACTIVO'
         When m.IND_ACTI = 0 Then
          'INACTIVO'
         Else
          'REVISAR QUERY'
       End) SITUACION,
       (Case
         When m.COD_MODE_EQUI = 4 Then
          'ARMOR'
         When m.COD_MODE_EQUI IN (1, 2, 3) Then
          'TEKSA'
         Else
          'NO CLASIFICADO'
       End) FABRICANTE,
       p.des_punt "PUNTO",
       (Case
         When m.ind_abon_line = 0 Then
          'SIN ABONO'
         When m.ind_abon_line = 1 Then
          'CON ABONO'
         Else
          'REVISAR QUERY'
       End) ABONO_EN_LINEA,
       s.cod_equi CODIGO,
       T.COD_TRAN TRANSACCIONES,
       T.FEC_FINA FECHA,
       To_char(T.FEC_FINA,'DD/MM/YYYY HH24')||':00:00' FECHA_TRUNC,
       t.fec_crea_sync FECHA_SYNC,
       To_char(t.fec_crea_sync,'DD/MM/YYYY HH24')||':00:00' FECHA_SYNC_TRUNC
  from cstc_tran t
 inner join cstc_serv s
    on t.cod_serv = s.cod_serv
 inner join csmc_maqu_safe m
    on s.cod_equi = m.cod_maqu_safe
 inner join ve_punto p
    on m.cod_punt = p.cod_punt
 where M.IND_ACTI = 1
   and t.fec_inic >=
       TO_DATE('28/01/2017 00:00:00', 'DD/MM/YYYY hh24:mi:ss')
   and t.fec_inic < TO_DATE('02/02/2017 00:00:00', 'DD/MM/YYYY hh24:mi:ss')
