Kenyi,

Te envio el detalle de script que utilice para validar un caso parecido anterior para que puedas atender lo reportado.
Me parece extraño que vuelva a pasar, ya que en el caso que revisé, hice la validación si existe la integridad de grupo de checklist (query 3)  y actualice los registros.
Adicionalmente validar si otros reclamos no tienen checklist generado (deben estar en estado EN ANALISIS (en estado REGISTRADO no debe tener checklist generado)

-- tabla de proceso
select * from tg_Tabl_tipo where cod_grup_tipo = 437 and cod_tipo !='0';
-- tabla tipo de proceso
select a.cod_grup_tipo_clas, a.cod_tipo_clas, -- se guarga el grupo de cheklist al que pertenece
       a.* from tv_tabl_sub_tipo a
where cod_grup_tipo = 437  --:s_tg_Tabl_tipo_5.cod_grup_tipo 
  and cod_tipo = 8; --:s_tg_Tabl_tipo_5.cod_tipo
  
 
-- validando la integridad de grupo de checklist asociado 
-- debe tener valior cod_grup_tipo_clas y cod_tipo_clas
-- Si no tiene ambos datos no jala el checklist al momento de inciiar analisis en el reclamo
-- el error sucede porque tiene datos de tipo pero no tiene datos del grupo
select a.cod_grup_tipo_clas, a.cod_tipo_clas, -- se guarga el grupo de cheklist al que pertenece
       a.* from tv_tabl_sub_tipo a
where cod_grup_tipo = 437  --:s_tg_Tabl_tipo_5.cod_grup_tipo 
  and cod_tipo_clas is not null 
  and cod_grup_tipo_clas is null; 

-- Listado de checklist
select * from tg_Tabl_tipo
where cod_grup_tipo = 493;
-- Listado de grupos de cheklist
select * from tg_Tabl_tipo
where cod_grup_tipo = 494;

-- Asociando gruopo de checklist con sus lista de checklist
-- tabla: tvtd_list_tipo_aten
Select *
    From tvtd_list_tipo_aten v
   Where v.cod_grup_aten = 494 -- grupo de cheklist 
     And v.cod_tipo_grup_aten = 4 -- tipo de grupo
     ;

-- reconstruyendo el checklist para un reclamo en especifico, sabiendo a que grupo de checklist pertenece 
Select v.cod_secu_tipo_list,
         '10000004339',
         v.cod_tipo_list, -- asocuado al tg_tabl_tipo 493 cod_tipo = 
         0,
         Null,
         Sysdate,
         user,
         userenv('terminal'),
         Sysdate,
         user,
         userenv('terminal')
    From tvtd_list_tipo_aten v
   Where v.cod_grup_aten = 494 -- grupo de cheklist 
     And v.cod_tipo_grup_aten = 4 -- tipo de grupo
     ;      


Saludos,
Flor
