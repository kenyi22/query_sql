Select * From VE_PUNTO WHERE COD_PUNT = 31780 for update

SELECT des_trnp, to_char(cod_trnp) 
                      FROM tv_transporta
                      
                      Select * From TG_SUCURSAL_HTB

                      
select *--cod_punt_orig

    from   ac_cuenta
--    where  cod_sucu_htb = 1--to_number(:global.cod_sucu_htb)  -- hasta el 20080122
    where  cod_sucu_htb = 14--to_number(:global.cod_sucu_htb)    -- dsm20080122 se modificó para utilizarlo por varias sucursales
    and    cod_clie     = 1--:ac_pedido.cod_clie_orig
    and    cod_cnta     = 1--:ac_pedido.cod_cnta_orig ;                      


6987

15448    

select cod_sucu_htb, cod_locd --12 74
  --  into   sucursal_origen, locd_origen
    from   ve_punto 
    where  cod_punt = 15448;
    
    
    
  select cod_sucu_htb, cod_locd--12 75
 --   into   sucursal_destino, locd_destino
    from   ve_punto
    where  cod_punt = 15448;
    
    Select a.cod_punt,
           a.des_punt,
           a.cod_locd,
           (Select b.des_locd
              From ve_localidad b
             where b.cod_locd = a.cod_locd)
      From ve_punto a
     where a.cod_punt in (31780, 15448);
    
PG_SERV_VALO .PR_ORDE_SERV    

 Select Cod_Locd
        --Into Ln_Cod_Locd
        From Ve_Punto
       Where Cod_Punt = 31780
12 
    
1--
3166
6987
18386

Select * From VE_PUNTO WHERE COD_PUNT IN (6987,18386);

select des_punt,des_dire_punt,cod_clie_grup,tip_punt
     from ve_punto
    where cod_punt = 18386
      and tip_punt not in ('3','11')
      and ind_usua_serv = 1;       

PG_SERV_VALO.PR_ORDE_SERV(12, 1, 34, '1',
                              6987,18386, lv_cod_seri_orde, ln_num_orde_serv, ln_ind_serv_fact,
                              ln_cod_erro, lv_des_erro);   




Select Cod_Seri_Orde, Num_Orde_Serv, Ind_Serv_Fact
      --Into Pv_Cod_Seri_Orde, Pn_Num_Orde_Serv, Pn_Ind_Serv_Fact
      From Ve_Orde_Serv
     Where Cod_Clie = 1--Ln_Cod_Clie
       And Cod_Serv = 34--Ln_Cod_Serv
       And Est_Docu = '6'
       And Cod_Punt_Usua_Serv = 31780--Ln_Cod_Punt_Usua_Serv
       And Tip_Form_Tras = 1--Lv_Tip_Form_Tras
       And ((Cod_Locd_Orig = 77--Ln_Cod_Locd_Orig 
       And
           Cod_Locd_Dest = 1008/*Ln_Cod_Locd_Dest*/) Or
           (Cod_Locd_Orig = 77/*Ln_Cod_Locd_Dest*/ And
           Cod_Locd_Dest = 1008/*Ln_Cod_Locd_Orig*/));
  
Select Cod_Seri_Orde, Num_Orde_Serv, Ind_Serv_Fact
      --Into Pv_Cod_Seri_Orde, Pn_Num_Orde_Serv, Pn_Ind_Serv_Fact
      From Ve_Orde_Serv
     Where Cod_Clie = 1--Ln_Cod_Clie
       And Cod_Serv = 34--Ln_Cod_Serv
       And Est_Docu = '6'
       And Cod_Punt_Usua_Serv = 31780--Ln_Cod_Punt_Usua_Serv
       And ((Cod_Locd_Orig = 77--Ln_Cod_Locd_Orig 
       And
           Cod_Locd_Dest = 1008/*Ln_Cod_Locd_Dest*/) Or
           (Cod_Locd_Orig = 77/*Ln_Cod_Locd_Dest*/ And
           Cod_Locd_Dest = 1008/*Ln_Cod_Locd_Orig*/));
           
Select  GEPG_VALI_GENE.gefu_cons_mens('AC',5) FROM DUAL     
                    
Select * From Ve_Orde_Serv WHERE Cod_Punt_Usua_Serv = 31780    

select des_punt,des_dire_punt,cod_clie_grup,tip_punt
     from ve_punto
    where cod_punt = 31780
      and tip_punt not in ('3','11')
      and ind_usua_serv = 1;

PG_SERV_VALO .PR_ORDE_SERV
