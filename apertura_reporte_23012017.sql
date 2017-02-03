--lima
Select cod_sucu_htb,fec_proc_aper,sum(nvl(mon_deno,0)+nvl(mon_deno_prov,0)) monto
from ac_saldo
where
           fec_proc_aper>=to_date('20/11/2016') and
           fec_proc_aper<=to_date('19/12/2016') and 
           cod_clie=to_number(308) and
           cod_cnta in (to_number(89),to_number(99)) and
           cod_bove=to_number(1) /*and
          cod_sucu_htb=to_number(1)*/
group by cod_sucu_htb,fec_proc_aper 
order by fec_proc_aper
