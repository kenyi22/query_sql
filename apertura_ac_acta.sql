Select *
        From Ac_Acta Acta
       Where Acta.Num_Guia = 5151678;
       
       
       Select Acta.Tip_Docu_Acta, Acta.Cod_Seri_Acta, Acta.Num_Acta, Acta.Fec_Emis,
                 Serv.Tip_Docu_Cmpb, Serv.Cod_Seri_Cmpb, Serv.Num_Cmpb, Serv.Cod_Clie,
                 Shpg_Anom.Shfu_Clie(Serv.Cod_Clie), Acta.Cod_Clie, Shpg_Anom.Shfu_Clie(Acta.Cod_Clie),
                 Acta.Est_Docu, Acta.Num_Guia
            From Ac_Acta Acta, Tv_Cmpb_Serv Serv
           Where Acta.Num_Guia = 5151678
             And Acta.Tip_Docu_Cmpb = Serv.Tip_Docu_Cmpb(+)
             And Acta.Cod_Seri_Cmpb = Serv.Cod_Seri_Cmpb(+)
             And Acta.Num_Cmpb = Serv.Num_Cmpb(+);
             
        Select Acta.Tip_Docu_Acta, Acta.Cod_Seri_Acta, Acta.Num_Acta, Acta.Fec_Emis,
                 Serv.Tip_Docu_Cmpb, Serv.Cod_Seri_Cmpb, Serv.Num_Cmpb, Serv.Cod_Clie,
                 Shpg_Anom.Shfu_Clie(Serv.Cod_Clie), Acta.Cod_Clie, Shpg_Anom.Shfu_Clie(Acta.Cod_Clie),
                 Acta.Est_Docu, Acta.Num_Guia
         /*   From Ac_Acta Acta, Tv_Cmpb_Serv Serv
           Where Acta.Num_Guia = 5151678
             And Acta.Tip_Docu_Cmpb = Serv.Tip_Docu_Cmpb(+)
             And Acta.Cod_Seri_Cmpb = Serv.Cod_Seri_Cmpb(+)
             And Acta.Num_Cmpb = Serv.Num_Cmpb(+)
             And Serv.Cod_Sucu_Htb = 1;*/
             
            From Ac_Acta Acta, Tv_Cmpb_Serv Serv
           Where Acta.Num_Guia = 5151678
             And Acta.Tip_Docu_Cmpb = Serv.Tip_Docu_Cmpb(+)
             And Acta.Cod_Seri_Cmpb = Serv.Cod_Seri_Cmpb(+)
             And Acta.Num_Cmpb = Serv.Num_Cmpb(+);
