Select * From ve_cliente where nom_clie IN ('NEOSALUD S.A.C.','FARMINDUSTRIA S.A.');
Select * From ve_cliente where cod_clie in(4297,4315);
Select p.cod_clie_grup,p.cod_sucu_htb,p.* From ve_punto p where cod_clie_grup in(4297,4315);
select t.cod_clie_grup,t.cod_sucu_htb,t.* from ve_punto t where cod_punt in (35660,
35662,
35742,
35662,
35737,
35664,
35663,
35660,
35737,
35659,
35661,
35659
);
select * from ve_corporacion where cod_corp in (210,148,37,219);

Select cryptit.decrypt(t.pas_web,cryptit.key) From general.camc_usua t where t.usu_web='CRODRCHI';
--
Select (Select c.cod_corp
          From ve_punto p, ve_cliente c
         Where p.cod_punt = t.cod_punt
           And c.cod_clie = p.cod_clie_grup) corp,
       t.*
  From csmc_usua_web t
Where t.fec_modi > to_date('20/01/2017', 'dd/mm/yyyy')
   And t.cod_corp <> (Select c.cod_corp
                        From ve_punto p, ve_cliente c
                       Where p.cod_punt = t.cod_punt
                         And c.cod_clie = p.cod_clie_grup)
  and t.cod_razo_soci=1;
---

Select (Select c.cod_corp
          From csmc_usua_web u, ve_punto p, ve_cliente c
         Where u.usu_web = t.usu_web
           And p.cod_punt = u.cod_punt
           And c.cod_clie = p.cod_clie_grup) corp,
       t.*
  From csmd_modu_clie t
Where t.fec_modi > to_date('20/01/2017', 'dd/mm/yyyy')
   And t.cod_corp <> (Select c.cod_corp
                        From csmc_usua_web u, ve_punto p, ve_cliente c
                       Where u.usu_web = t.usu_web
                         And p.cod_punt = u.cod_punt
                         And c.cod_clie = p.cod_clie_grup)
and t.cod_razo_soci=1;
--update
Update csmc_usua_web t
   Set t.cod_corp =
       (Select c.cod_corp
          From ve_punto p, ve_cliente c
         Where p.cod_punt = t.cod_punt
           And c.cod_clie = p.cod_clie_grup)
Where t.fec_modi > to_date('20/01/2017', 'dd/mm/yyyy')
   And t.cod_corp <> (Select c.cod_corp
                        From ve_punto p, ve_cliente c
                       Where p.cod_punt = t.cod_punt
                         And c.cod_clie = p.cod_clie_grup)
  and t.cod_razo_soci=1
  --and t.cod_corp<>148
  ;
  
Update csmd_modu_clie t
   Set t.cod_corp =
       (Select c.cod_corp
          From csmc_usua_web u, ve_punto p, ve_cliente c
         Where u.usu_web = t.usu_web
           And p.cod_punt = u.cod_punt
           And c.cod_clie = p.cod_clie_grup)
Where t.fec_modi > to_date('20/01/2017', 'dd/mm/yyyy')
   And t.cod_corp <> (Select c.cod_corp
                        From csmc_usua_web u, ve_punto p, ve_cliente c
                       Where u.usu_web = t.usu_web
                         And p.cod_punt = u.cod_punt
                         And c.cod_clie = p.cod_clie_grup)
   and t.cod_razo_soci=1
 --and t.cod_corp<>148
 ;


