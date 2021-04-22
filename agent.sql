SELECT COALESCE(CONVERT(nvarchar(1),s.STATUS),'GENEL TOPLAM'),count(*) FROM dbo.SYMEmployees s
LEFT JOIN dbo.SurveyEmployees se ON s.Id = se.PatientId
WHERE s.LookUpListTermId = 899540 and s.STATUS IN (1,4)
AND s.CallTime > '2021-01-20 08:00:00.000'
GROUP BY CUBE ( s.STATUS)
--anketor bazli cagri sayisi
SELECT
coalesce(a.Email,'Toplam') AS anketor_e_posta,
count (*) AS cagri_sayisi
FROM [SYMvePersonelSabimAnket].[dbo].SYMEmployees      p WITH (NOLOCK) 
JOIN [SYMvePersonelSabimAnket].[dbo].[Cities]          c WITH (NOLOCK)  ON c.Id =p.CityId
JOIN [SYMvePersonelSabimAnket].[dbo].[AspNetUsers]     a WITH (NOLOCK)  ON p.[CalledById]  = a.[Id]
where p.CallTime > '2021-01-20 08:00:00.000'
AND a.Email LIKE '%pusula%'
AND p.CallTime	< '2021-01-20 20:00:00.000'
GROUP BY cube (a.Email)	
order by a.email asc
OPTION (maxdop 16)
--anketor bazli anket sayisi
SELECT
coalesce(a.Email,'Toplam') AS anketor_e_posta,
count (*) AS anket_sayisi
FROM [SYMvePersonelSabimAnket].[dbo].SYMEmployees      p WITH (NOLOCK) 
JOIN [SYMvePersonelSabimAnket].[dbo].[Cities]          c WITH (NOLOCK)  ON c.Id =p.CityId
JOIN [SYMvePersonelSabimAnket].[dbo].[AspNetUsers]     a WITH (NOLOCK)  ON p.[CalledById]  = a.[Id]
where p.CallTime > '2021-01-20 08:00:00.000'
AND a.Email LIKE '%pusula%'
AND p.CallTime	< '2021-01-20 20:00:00.000'
AND p.STATUS = 1
AND p.Reason IS NULL
GROUP BY cube (a.Email)
order by a.email asc
OPTION (maxdop 16)
--anketor bazli ham veri
SELECT
a.Email AS 'e-posta-adresi',
CASE p.status
WHEN 1 then 'basarili'
else 'basarisiz'
end as sonuc,
p.CallTime AS 'cagri-zamani'
FROM [SYMvePersonelSabimAnket].[dbo].SYMEmployees      p WITH (NOLOCK) 
JOIN [SYMvePersonelSabimAnket].[dbo].[Cities]          c WITH (NOLOCK)  ON c.Id =p.CityId
JOIN [SYMvePersonelSabimAnket].[dbo].[AspNetUsers]     a WITH (NOLOCK)  ON p.[CalledById]  = a.[Id]
where p.CallTime > '2021-01-20 08:00:00.000'
AND a.Email LIKE '%pusula%'
AND p.CallTime	< '2021-01-20 20:00:00.000'
--GROUP BY cube (a.Email)
order by p.CallTime
OPTION (maxdop 16)