select * 
  from tvtc_regi_aten r
where cod_estd =3 -- estado: En analis
and ind_anls_cmpj = 1 -- que sea de analisis complejo es decir que para por el flujo de analisis con cheklist
and cod_aten not in ( select cod_aten  from tvtd_regi_aten_list);

