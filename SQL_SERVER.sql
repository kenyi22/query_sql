--TRANSACIIONES CON UNIDAD MONETARIA INCORRECTA
SELECT  a.[safeID] safeID,a.ind_sinc_htbp
            ,a.[RecIndex] recIndex
          ,convert (varchar(10), a.[localTime],104)+' '+convert (varchar(8), a.[localTime],108) localTime
          ,a.[userID]
            ,CONVERT(varchar(32),a.[userName],32) userName
          ,a.[eventType] 
            ,b.[value] cash_value 
            ,b.[count] cash_count
            ,LTRIM(RTRIM(b.[isoCode])) cash_isoCode
            ,LTRIM(RTRIM(b.[meiAddr])) cash_email
              ,convert(decimal(10,2),convert(decimal(10,2),c.[value])/100) safe_value
              ,c.[isoCode] safe_isoCode
              ,a.[accountNo] account_number
              ,a.fec_sync_htbp
  FROM [ARMOR].[dbo].[dbRec] a
         Left Join [ARMOR].[dbo].[cashDrop] b On (a.RecIndex = b.RecIndex and a.safeID=b.safeID and a.accountNo=b.accountNo)
         Left Join [ARMOR].[dbo].[safeDrop] c On (a.RecIndex = c.RecIndex and a.safeID=c.safeID and a.accountNo=c.accountNo)
  Where a.fec_sync_clie>=GETDATE()-1
  
  a.safeID = 100063--51--57
    And a.eventType in (7,16,25,54)
    and a.RecIndex>=13497
    and ((b.value is not null
    and b.isoCode not in ('PEN','USD')
    ) 
     OR
     (c.value is not null and c.isoCode not in ('PEN','USD'))
    )
    --And a.ind_sinc_htbp = 1
    --and b.value is not null
    --and c.value is not null
  Order by a.RecIndex asc;

  update dbRec set ind_sinc_htbp=1 where safeID=100063 and RecIndex=13497;

  select a.* from [ARMOR].[dbo].[dbRec] a where a.safeID=100063 and a.RecIndex in (
13497,
13532,
13533,
13534,
13536,
13537,
13538,
13539,
13540,
13541,
13542,
13543,
13544,
13545,
13546,
13547,
13548,
13549,
13550,
13551,
13552,
13553,
13554,
13555,
13556,
13557)

  update dbRec set ind_sinc_htbp=1 where safeID=100063 and RecIndex in (
13497,
13532,
13533,
13534,
13536,
13537,
13538,
13539,
13540,
13541,
13542,
13543,
13544,
13545,
13546,
13547,
13548,
13549,
13550,
13551,
13552,
13553,
13554,
13555,
13556,
13557)


