Select /*+ index (b,IDX_VE_CLIENTE_05)*/
Distinct b.cod_clie,
         Trim(Replace(b.nom_clie, ',', ' ')) nom_clie,
         a.cod_clie_mens cod_clie_mens,
         (Select Replace(d.nom_clie, ',', ' ')
            From vd_cliente d
           Where d.cod_clie = a.cod_clie_mens) nom_clie_mens,
         (Case
           When b.ind_acti = 1 Then
            'ACTIVO'
           Else
            'INACTIVO'
         End) ind_acti,
         (Select Upper(Replace(v.des_ciiu, ',', ' '))
            From pomc_ciiu v
           Where v.cod_ciiu = b.cod_ciiu) des_ciiu,
         (Select Replace(w.des_corp, ',', ' ')
            From ve_corporacion w
           where w.cod_corp = b.cod_corp) des_corp,
         (Select c.des_sucu_htb
            from tg_sucursal_htb c
           where c.cod_sucu_htb = b.cod_sucu_htb) des_sucu_htb,
         (Select Replace(f.nombre, ',', ' ')
            from v_empleado f
           where f.empleado = b.empleado) nom_ejec_cuen,
         b.cod_ruc,
         a.cod_laft,
         a.cod_segm,
         (Select Distinct Replace(e.des_Segm, ',', ' ')
            From vemc_segm e
           Where e.cod_segm = a.cod_segm) des_Segm,
         b.cod_sect,
         (Select Replace(f.des_Sect, ',', ' ')
            From ve_sector f
          Where f.cod_sect = b.cod_sect) des_Sect,
         (Select des_sub_sect
            From ve_sub_sector j
           Where j.cod_sect = b.cod_sect
             And j.cod_sect_subd = 0
             And j.cod_sub_sect = b.cod_sect_subd) des_sub_sect,
         (Select k.des_tipo
            From tg_tabl_tipo k
           Where k.cod_grup_tipo = 608
             And k.cod_tipo <> 0
             And k.cod_tipo = d.cod_cali_clie) cod_cate,
         Replace(b.des_dire_cobr, ',', ' ') des_dire_cobr,
         b.fec_gene,
         b.fec_ulti_modi,
         (Select l.des_tipo
            From tg_tabl_tipo l
           Where l.cod_grup_tipo = 766
             And l.cod_tipo = c.tip_cntc) des_tipo_cntc,
         c.cod_secu_cntc cod_cntc,
         c.des_nomb_cntc || ' ' || c.des_apel_pate || ' ' ||
         c.des_apel_mate As nom_cntc,
         (Select h.des_tipo
            From tg_tabl_tipo h
           Where h.cod_grup_tipo = 35
             And h.cod_tipo = c.tip_docu_iden) tip_docu_cntc,
         Decode(c.num_docu_iden, Null, Null, Chr(39) || c.num_docu_iden) As num_docu_iden,
         c.des_hobi_cntc,
         (Select i.num_porc_part
            From vemd_clie_acci_part i
           Where i.cod_orig = c.cod_orig
             And i.cod_clie = c.cod_clie
             And i.cod_secu_cntc = c.cod_secu_cntc) num_porc_part,
         (Select h.des_tipo
            From tg_tabl_tipo h
           Where h.cod_grup_tipo = 310
             And h.cod_tipo = a.cod_nval_acci) des_exce_acci,
             --REQ037380 KCANCHI 19/08/2016 AUMENTO DE COLUMNAS FICHA PART ELECT Y LUGAR DE REGISTRO
             b.des_fich_elec,
             b.des_regi_pers,
             --Fin REQ037380
             --C-046074--REQ040689 KCANCHI 05/10/2016 R-040689 RV: Reporte Contacto por tipo contacto
             decode(c.ind_esta_cntc,1,'ACTIVO',0,'INACTIVO',NULL,null) "EST_CONT"
             --C-046074--Fin R-040689
  From ve_cliente          b,
       vemc_clie_camp_adic a,
       --C-046074--R-040689 KCANCHI 05/10/2016 R-040689 RV: Reporte Contacto por tipo contacto
       (select cc.cod_secu_cntc, cc.cod_clie, cc.tip_cntc, cc.cod_orig,g.ind_esta_cntc,
       --C-046074--Fin R-040689
               g.des_hobi_cntc,
               g.num_docu_iden,
               g.des_nomb_cntc,g.des_apel_pate,g.des_apel_mate,
               g.tip_docu_iden
          from gvmd_clie_tipo_cntc  cc,
               gvmc_mant_cntc      g
         where cc.cod_secu_cntc = g.cod_secu_cntc
           --and cc.tip_cntc = pn_tipo_cntc
       )
       c,
       vemd_razo_soci      d
Where b.cod_clie = a.cod_clie
   And c.cod_clie(+) = b.cod_clie
   And d.cod_razo_soci = b.cod_razo_soci
Order By 4, 1, 2, 3;
