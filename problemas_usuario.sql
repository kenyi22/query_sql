      Select *
        --into :ss_nom_clie
        from ve_cliente
       Where nom_clie like '%CBC%';4306

select distinct b.nom_clie , b.cod_clie
from   ve_cliente b, ve_punto a
where  a.cod_sucu_htb  = to_number(1) 
and    a.cod_clie_grup = b.cod_clie
--and    b.ind_acti      = 1
group by b.cod_clie, b.nom_clie
order by 1
--
select distinct b.nom_clie,b.cod_clie,d.cod_punt/*,a.cod_punt_usua_Serv*/
 from ve_cliente b,ve_orde_Serv a ,  ve_punto d
  where a.est_docu='6'
  and b.cod_clie=4306
    and b.cod_clie=d.cod_clie_grup
/*    and a.cod_punt_usua_Serv=35294*/
  --and d.cod_punt=a.cod_punt_usua_Serv
order by b.nom_clie

Select * From ve_punto where cod_clie_grup=4306;--4306
Select * From ve_orde_Serv where cod_punt_usua_Serv in (35294);
--
select distinct b.nom_clie,b.cod_clie
 from ve_cliente b,ve_orde_Serv a ,  ve_punto d
  where 
   a.est_docu='6'
  and d.cod_punt=a.cod_punt_usua_Serv
  and b.cod_clie=d.cod_clie_grup
order by b.nom_clie
