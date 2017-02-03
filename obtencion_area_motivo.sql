Select Initcap(des_moti_rrcl), mot_rrcl||'',a.cod_area 
                     From tg_tabl_area_deta  a
                    Where a.cod_sucu_htb = 1-- pn_sucu
                      And cod_modu = 'RA'
                      And a.cod_area =  17; --3


   Select Initcap(des_area) des_area, cod_area||''  
                      From tg_tabl_area    
                     Where cod_sucu_htb = 1-- pn_sucu ||
                       And cod_modu = 'RA' 
                       And ((Trim(Upper(Des_Area))  = 'CLIENTE' And 2 = 0) Or 
                            (Trim(Upper(Des_Area)) <> 'CLIENTE' And 2 = 1) Or (2 = 2))
                     Order by des_area ;--1
