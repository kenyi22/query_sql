Select count(1)
--              Into ln_cant_nume_acta
              From shtd_admi_acta_anom a
             Where a.num_acta = 2883877--lv_desc_camp
               And a.cod_seri_acta = 'A'||lpad(1,2,0)
               --And a.fec_rece_acta Is Not Null--Eliminación de código. CF 20/11/2015 REQ017372
               And a.fec_rece_acta_fals Is Not Null--Adicion de código. CF 20/11/2015 REQ017372
               And a.num_carg_fals Is Not Null
               And a.tip_carg_fals Is not Null
               And a.ser_carg_fals Is Not Null
               --Adición de código. CF 14/09/2015 REQ014690 
               And ((
                    (Select Count(Distinct b.num_cart)
                      From shtc_cart_gest_fals b, shtd_cart_gest_fals c
                     Where b.num_cart = c.num_cart
                       And b.cod_seri_cart = c.cod_seri_cart
                       And b.tip_docu_cart = c.tip_docu_cart
                       And c.num_acta = a.num_acta
                       And c.cod_seri_acta =  a.cod_seri_acta
                       And c.tip_docu_acta = a.tip_docu_acta
                       And b.cod_estd = 1) > 0
                    ) Or 
                    ((Select Count(Distinct b.num_cart)
                      From shtc_cart_gest_fals b, shtd_cart_gest_fals c
                     Where b.num_cart = c.num_cart
                       And b.cod_seri_cart = c.cod_seri_cart
                       And b.tip_docu_cart = c.tip_docu_cart
                       And c.num_acta = a.num_acta
                       And c.cod_seri_acta =  a.cod_seri_acta
                       And c.tip_docu_acta = a.tip_docu_acta) = 0)
                    )
               --Fin. CF 14/09/2015 REQ014690 
               
Select *--max(num_cart) 
From shac.shtd_cart_gest_fals;--2347
Select * From ac_acta where num_acta = 2883877;
Select * From ac_acta_deta where num_acta = 2883877 and tip_docu_acta = 'AC';
Select * From tv_cmpb_serv where num_cmpb = 14094864;

