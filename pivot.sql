SELECT * FROM (SELECT c.Id [�ehir No], c.Name [�ehir Ad�],lul2.Id [Unvan No],lul2.Name [Unvan Ad�],K.SUMM [Kay�tl� Toplam Say�], sk.PersonelCount [Aranmas� Gereken Say�],
IIF(sk.LeftCount<0,sk.PersonelCount+abs(sk.LeftCount),sk.PersonelCount-sk.LeftCount) [Arama Say�],
sk.PersonelCount - IIF(sk.LeftCount<0,sk.PersonelCount+abs(sk.LeftCount),sk.PersonelCount-sk.LeftCount) [Kalan],
IIF(sk.LeftCount<0,abs(sk.LeftCount),0) [Fazla Arama Say�s�],
K.SUMM-IIF(sk.LeftCount<0,sk.PersonelCount+abs(sk.LeftCount),sk.PersonelCount-sk.LeftCount) [Kalan Kay�tl� Toplam Say�],
IIF(sk.IsActive=0,'Bitti','Devam') [Sonu�] FROM 
(SELECT s.CityId, s.LookUpListTitleId,COUNT(*)  SUMM FROM dbo.SYMEmployees s
WHERE s.IsDeleted=0 AND LookUpListTermId=899540
GROUP BY s.CityId, s.LookUpListTitleId) K 
RIGHT JOIN dbo.SYMPersonelKurals sk WITH (NOLOCK) ON sk.CityId = K.CityId AND K.LookUpListTitleId = sk.PersonelId AND sk.LookUpListTermId=899540
JOIN dbo.Cities c ON sk.CityId = c.Id
JOIN dbo.LookUpLists lul ON sk.LookUpListTermId = lul.Id
JOIN  dbo.LookUpLists lul2 ON lul2.Id = k.LookUpListTitleId
WHERE sk.PersonelCount!=0) Y
WHERE Y.Sonu�!='Bitti' --AND Y.[Fazla Arama]>0

SELECT
c.name AS il,
lul.Name AS meslek,
sk.PersonelCount AS hedeflenen,
sk.LeftCount AS kalan
FROM dbo.SYMPersonelKurals sk
JOIN Cities c ON sk.CityId = c.Id
JOIN LookUpLists lul ON sk.PersonelId = lul.Id
WHERE sk.LookUpListTermId=899540
AND sk.IsActive=0
--AND sk.PersonelCount!=0

SELECT c.Name AS il,lul2.Name AS meslek,K.SUMM [kayitli-toplam-sayi], sk.PersonelCount [hedef-sayi],IIF(sk.LeftCount<0,sk.PersonelCount+abs(sk.LeftCount),sk.LeftCount) [basarili-anket-sayisi],IIF(sk.LeftCount<0,abs(sk.LeftCount),sk.LeftCount) [fazla-anket-sayisi],IIF(sk.IsActive=0,'Bitti','Devam') AS durum FROM 
(SELECT s.CityId, s.LookUpListTitleId,COUNT(*)  SUMM FROM dbo.SYMEmployees s
WHERE s.IsDeleted=0 AND LookUpListTermId=899540
GROUP BY s.CityId, s.LookUpListTitleId) K JOIN dbo.SYMPersonelKurals sk WITH (NOLOCK) ON sk.CityId = K.CityId AND K.LookUpListTitleId = sk.PersonelId AND sk.LookUpListTermId=899540
JOIN dbo.Cities c ON sk.CityId = c.Id
JOIN dbo.LookUpLists lul ON sk.LookUpListTermId = lul.Id
JOIN  dbo.LookUpLists lul2 ON lul2.Id = k.LookUpListTitleId
WHERE sk.PersonelCount!=0
ORDER BY sk.IsActive, K.SUMM-sk.PersonelCount

DECLARE @cols AS NVARCHAR(MAX),
    @query  AS NVARCHAR(MAX);
SET @cols = STUFF((SELECT distinct ',' + QUOTENAME(lul.Name) 
 FROM
					dbo.LookUpLists lul 
					WHERE lul.LookUpId=20 AND lul.ParentId IS NULL
            FOR XML PATH(''), TYPE
            ).value('.', 'NVARCHAR(MAX)') 
        ,1,1,'')



set @query = 'SELECT sad, ' + @cols + ' from 
            (
                SELECT y.[Toplam Aranm�� Say�] tag,y.[Unvan Ad�] ua,y.[�ehir Ad�] sad FROM (SELECT c.Id [�ehir No], c.Name [�ehir Ad�],lul2.Id [Unvan No],lul2.Name [Unvan Ad�],K.SUMM [Kay�tl� Toplam Say�], sk.PersonelCount [Toplam Aranmas� Gereken],IIF(sk.LeftCount<0,sk.PersonelCount+abs(sk.LeftCount),sk.LeftCount) [Toplam Aranm�� Say�],IIF(sk.LeftCount<0,abs(sk.LeftCount),sk.LeftCount) [Fazla Arama],IIF(sk.IsActive=0,''Bitti'',''Devam'') [Sonu�] FROM 
				(SELECT s.CityId, s.LookUpListTitleId,COUNT(*)  SUMM FROM dbo.SYMEmployees s
				WHERE s.IsDeleted=0 AND LookUpListTermId=899540
				GROUP BY s.CityId, s.LookUpListTitleId) K 
				RIGHT JOIN dbo.SYMPersonelKurals sk WITH (NOLOCK) ON sk.CityId = K.CityId AND K.LookUpListTitleId = sk.PersonelId AND sk.LookUpListTermId=899540
				JOIN dbo.Cities c ON sk.CityId = c.Id
				JOIN dbo.LookUpLists lul ON sk.LookUpListTermId = lul.Id
				JOIN  dbo.LookUpLists lul2 ON lul2.Id = k.LookUpListTitleId
				WHERE sk.PersonelCount!=0) Y
           ) x
            pivot 
            (
                 max(tag)
                for  ua in (' + @cols + ')
            ) p '
execute(@query)