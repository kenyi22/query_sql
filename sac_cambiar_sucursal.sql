Select * From ac_cmpb_deno a where a.num_cmpb=80086302;
Select * From shtd_bole_resu b where b.num_cmpb=80086302 and b.cod_bove=1;


Select *
  From ac_cmpb_deno a
 where a.num_cmpb IN (80102551, 80102584, 80103946, 80104031) FOR UPDATE;
 /*MODIFICACION DE cs*/
 Select * From TRASLADO.TV_CMPB_SERV where num_cmpb in (80102551/*, 80102584, 80103946, 80104031*/) 
 Select * From tv_cmpb_item_serv where num_cmpb in (80102551/*, 80102584, 80103946, 80104031*/) for update
/****/
