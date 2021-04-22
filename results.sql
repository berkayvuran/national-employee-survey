SELECT
ss.Id AS anket_id,
anu.[Name] + ' ' + anu.[Surname] as anketor,
anu.[Email] as anketor_e_posta_adresi,
s.CallTime AS anket_gunu,
case s.Gender
when 1 then 'kadin' 
when 0 then 'erkek'
when 2 then 'erkek'
ELSE 'fikrim_yok' end as cinsiyet,
s.Age AS yas,
case 
when s.Age < 18  then '0_17'
when 18 <= s.Age and  s.Age < 25  then '18_24'
when 25 <= s.Age and  s.Age < 35  then '25_34'
when 35 <= s.Age and  s.Age < 45  then '35_44'
when 45 <= s.Age and  s.Age < 55  then '45_54'
when 55 <= s.Age and  s.Age < 65  then '55_64'
when s.Age >= 65  then '65+'
ELSE 'hata'
end as yas_grubu,
c.Name AS sehir,
lul12.Name AS unvan,
s.Workplace AS kurum,
case
lul.Name
when 'Kesinlikle Katýlmýyorum' then '0'
when 'Katýlmýyorum' then '25'
when 'Ne Katýlýyorum Ne Katýlmýyorum' then '50'
when 'Katýlýyorum' then '75'
when 'Kesinlikle Katýlýyorum' then '100'
ELSE 'fikrim_yok'
END as gerekli_imkanlar,
case
lul2.Name
when 'Kesinlikle Katýlmýyorum' then '0'
when 'Katýlmýyorum' then '25'
when 'Ne Katýlýyorum Ne Katýlmýyorum' then '50'
when 'Katýlýyorum' then '75'
when 'Kesinlikle Katýlýyorum' then '100'
ELSE 'fikrim_yok'
END AS calisma_ortami,
case
lul3.Name
when 'Kesinlikle Katýlmýyorum' then '0'
when 'Katýlmýyorum' then '25'
when 'Ne Katýlýyorum Ne Katýlmýyorum' then '50'
when 'Katýlýyorum' then '75'
when 'Kesinlikle Katýlýyorum' then '100'
ELSE 'fikrim_yok'
END AS guven,
case
lul4.Name
when 'Kesinlikle Katýlmýyorum' then '0'
when 'Katýlmýyorum' then '25'
when 'Ne Katýlýyorum Ne Katýlmýyorum' then '50'
when 'Katýlýyorum' then '75'
when 'Kesinlikle Katýlýyorum' then '100'
ELSE 'fikrim_yok'
END AS deger,
case
lul5.Name
when 'Kesinlikle Katýlmýyorum' then '0'
when 'Katýlmýyorum' then '25'
when 'Ne Katýlýyorum Ne Katýlmýyorum' then '50'
when 'Katýlýyorum' then '75'
when 'Kesinlikle Katýlýyorum' then '100'
ELSE 'fikrim_yok'
END AS liyakat,
case
lul6.Name
when 'Kesinlikle Katýlmýyorum' then '0'
when 'Katýlmýyorum' then '25'
when 'Ne Katýlýyorum Ne Katýlmýyorum' then '50'
when 'Katýlýyorum' then '75'
when 'Kesinlikle Katýlýyorum' then '100'
ELSE 'fikrim_yok'
END AS hak_cikar,
case
lul7.Name
when 'Kesinlikle Katýlmýyorum' then '0'
when 'Katýlmýyorum' then '25'
when 'Ne Katýlýyorum Ne Katýlmýyorum' then '50'
when 'Katýlýyorum' then '75'
when 'Kesinlikle Katýlýyorum' then '100'
ELSE 'fikrim_yok'
END AS adil_ucret,
case
lul8.Name
when 'Kesinlikle Katýlmýyorum' then '0'
when 'Katýlmýyorum' then '25'
when 'Ne Katýlýyorum Ne Katýlmýyorum' then '50'
when 'Katýlýyorum' then '75'
when 'Kesinlikle Katýlýyorum' then '100'
ELSE 'fikrim_yok'
END AS is_yuku,
case
lul9.Name
when 'Kesinlikle Katýlmýyorum' then '0'
when 'Katýlmýyorum' then '25'
when 'Ne Katýlýyorum Ne Katýlmýyorum' then '50'
when 'Katýlýyorum' then '75'
when 'Kesinlikle Katýlýyorum' then '100'
ELSE 'fikrim_yok'
END AS hasta_davranisi,
case
lul10.Name
when 'Kesinlikle Katýlmýyorum' then '0'
when 'Katýlmýyorum' then '25'
when 'Ne Katýlýyorum Ne Katýlmýyorum' then '50'
when 'Katýlýyorum' then '75'
when 'Kesinlikle Katýlýyorum' then '100'
ELSE 'fikrim_yok'
END AS iletisim,
case
lul11.Name
when 'Kesinlikle Katýlmýyorum' then '0'
when 'Katýlmýyorum' then '25'
when 'Ne Katýlýyorum Ne Katýlmýyorum' then '50'
when 'Katýlýyorum' then '75'
when 'Kesinlikle Katýlýyorum' then '100'
ELSE 'fikrim_yok'
END AS genel_memnuniyet,
ISNULL(ss.Description, 'aciklama_yok') AS aciklama
FROM dbo.SurveyEmployees ss
JOIN dbo.SYMEmployees s ON ss.PatientId = s.Id
JOIN [SYMvePersonelSabimAnket].[dbo].LookUpLists lul WITH (NOLOCK) ON lul.Id = ss.NecessaryOpportunityId
JOIN [SYMvePersonelSabimAnket].[dbo].LookUpLists lul2 WITH (NOLOCK) ON lul2.Id = ss.WorkingEnvironmentId
JOIN [SYMvePersonelSabimAnket].[dbo].LookUpLists lul3 WITH (NOLOCK) ON lul3.Id = ss.FeelSafeId
JOIN [SYMvePersonelSabimAnket].[dbo].LookUpLists lul4 WITH (NOLOCK) ON lul4.Id = ss.BeAppreciatedId
JOIN [SYMvePersonelSabimAnket].[dbo].LookUpLists lul5 WITH (NOLOCK) ON lul5.Id = ss.QualificationId	
JOIN [SYMvePersonelSabimAnket].[dbo].LookUpLists lul6 WITH (NOLOCK) ON lul6.Id = ss.VindicationId
JOIN [SYMvePersonelSabimAnket].[dbo].LookUpLists lul7 WITH (NOLOCK) ON lul7.Id = ss.FairWagesId
JOIN [SYMvePersonelSabimAnket].[dbo].LookUpLists lul8 WITH (NOLOCK) ON lul8.Id = ss.SuitabilityId
JOIN [SYMvePersonelSabimAnket].[dbo].LookUpLists lul9 WITH (NOLOCK) ON lul9.Id = ss.BehaviorofPatientId
JOIN [SYMvePersonelSabimAnket].[dbo].LookUpLists lul10 WITH (NOLOCK) ON lul10.Id = ss.communicationProblemId
JOIN [SYMvePersonelSabimAnket].[dbo].LookUpLists lul11 WITH (NOLOCK) ON lul11.Id = ss.SatisfactionId
JOIN [SYMvePersonelSabimAnket].[dbo].LookUpLists lul12 WITH (NOLOCK) ON lul12.Id = s.LookUpListTitleId
JOIN [SYMvePersonelSabimAnket].[dbo].AspNetUsers anu WITH (NOLOCK) ON anu.Id = s.CalledById
JOIN dbo.Cities c ON s.CityId = c.Id
WHERE s.LookUpListTermId=899540