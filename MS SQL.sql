--SORU 1: Customers isimli bir veritabanı ve verilen veri setindeki değişkenleri içerecek  FLO isimli bir tablo oluşturunuz.
--CREATE DATABASE CUSTOMERS
--SELECT * FROM FLO

-- SORU 2: Kaç farklı müşterinin alışveriş yaptığını gösterecek sorguyu yazınız.
--SELECT COUNT(DISTINCT master_id) as KISI_SAYISI FROM FLO

--SORU 3: Toplam yapılan alışveriş sayısı ve ciroyu getirecek sorguyu yazınız.
--SELECT
--  SUM(order_num_total_ever_offline + order_num_total_ever_online) AS TOPLAM_SIPARIS_SAYISI, 
--  ROUND(SUM(customer_value_total_ever_offline + customer_value_total_ever_online), 2) AS TOPLAM_CIRO
--FROM FLO

--SORU 4: Alışveriş başına ortalama ciroyu getirecek sorguyu yazınız.
--SELECT SUM(customer_value_total_ever_offline + customer_value_total_ever_online)/SUM(order_num_total_ever_offline + order_num_total_ever_online) 
--AS AVG_CIRO FROM FLO


-- SORU 5: En son alışveriş yapılan kanal (last_order_channel) üzerinden yapılan alışverişlerin toplam ciro ve alışveriş sayılarını
-- getirecek sorguyu yazınız.

--SELECT last_order_channel, ROUND(SUM(customer_value_total_ever_offline + customer_value_total_ever_online), 2) AS TOPLAM_CIRO,
--SUM(order_num_total_ever_offline + order_num_total_ever_online) AS TOPLAM_SIPARIS_SAYISI FROM FLO
--GROUP BY last_order_channel ORDER BY 2 DESC 

-- SORU 6: Store type kırılımında elde edilen toplam ciroyu getiren sorguyu yazınız. 
--SELECT store_type AS CATEGORY, ROUND(SUM(customer_value_total_ever_offline + customer_value_total_ever_online), 2) AS TOPLAM_CIRO
--FROM FLO GROUP BY store_type ORDER BY 2

-- SORU 7: Yıl kırılımında alışveriş sayılarını getirecek sorguyu yazınız.
--SELECT YEAR(last_order_date) AS YEAR, SUM(order_num_total_ever_offline + order_num_total_ever_online) AS TOPLAM_SIPARIS_SAYISI FROM FLO
--GROUP BY YEAR(last_order_date)

-- SORU 8: En son alışveriş yapılan kanal kırılımında alışveriş başına ortalama ciroyu hesaplayacak sorguyu yazınız.
--SELECT last_order_channel AS LAST_CHANNEL, SUM(customer_value_total_ever_offline + customer_value_total_ever_online)/SUM(order_num_total_ever_offline + order_num_total_ever_online) 
--FROM FLO GROUP BY last_order_channel ORDER BY 2 DESC

-- SORU 9: Son 12 ayda en çok ilgi gören Kategoriyi getiren sorgu. 
--SELECT TOP 5
--interested_in_categories_12 AS CATEGORY, COUNT(*) AS FREQUENCY FROM FLO
--WHERE YEAR(first_order_date) = (SELECT MAX(YEAR(last_order_date)) FROM FLO)
--GROUP BY interested_in_categories_12 ORDER BY 2 DESC

-- SORU 10: En çok tercih edilen store_type bilgisini getiren sorguyu yazınız. 
--SELECT TOP 3 store_type AS STORE_TYPE, COUNT(*) AS FREQUENCY FROM FLO 
--GROUP BY store_type ORDER BY 2 DESC

-- SORU 11:  En son alışveriş yapılan kanal (last_order_channel) bazında, en çok ilgi gören kategoriyi ve bu kategoriden ne kadarlık
-- alışveriş yapıldığını getiren sorguyu yazınız.

--SELECT DISTINCT last_order_channel AS LAST_CHANNEL,
--(SELECT TOP 1 interested_in_categories_12 FROM FLO WHERE last_order_channel=F.last_order_channel 
-- GROUP by interested_in_categories_12 ORDER by SUM(order_num_total_ever_online+order_num_total_ever_offline) DESC) as CATEGORY,
--(SELECT TOP 1 SUM(order_num_total_ever_online+order_num_total_ever_offline) FROM FLO  WHERE last_order_channel = F.last_order_channel 
--GROUP BY interested_in_categories_12 ORDER BY 1 DESC) AS SIPARIS_SAYISI
--FROM FLO AS F ORDER BY 3 DESC

-- SORU 12: En çok alışveriş yapan kişinin ID’ sini getiren sorguyu yazınız. 
--SELECT TOP 1 master_id AS ID
--FROM FLO GROUP BY master_id ORDER BY SUM(customer_value_total_ever_offline + customer_value_total_ever_online) DESC


-- ***FROM SUBTABLE AS S ***
-- SORU 13: En çok alışveriş yapan kişinin alışveriş başına ortalama cirosunu ve alışveriş yapma gün ortalamasını (alışveriş sıklığını)
-- getiren sorguyu yazınız.

--select * , ROUND((F.TOPLAM_CIRO / F.TOPLAM_SIPARIS_SAYISI),2) AS AVG_ORDER FROM
--(SELECT TOP 3 master_id AS ID, SUM(customer_value_total_ever_offline + customer_value_total_ever_online) AS TOPLAM_CIRO,
--SUM(order_num_total_ever_offline + order_num_total_ever_online) AS TOPLAM_SIPARIS_SAYISI
--FROM FLO GROUP BY master_id ORDER BY 2 DESC) AS F

-- SORU 14: En çok alışveriş yapan (ciro bazında) ilk 100 kişinin alışveriş yapma gün ortalamasını (alışveriş sıklığını) getiren sorguyu
-- yazınız.

--SELECT F.master_id, F.TOPLAM_CIRO, F.TOPLAM_SIPARIS_SAYISI, DATEDIFF(DAY, first_order_date, last_order_date) as DAYS, 
-- F.TOPLAM_CIRO / DATEDIFF(DAY, first_order_date, last_order_date) AS AVG_PRICE 
--FROM
--(SELECT TOP 100 master_id, first_order_date, last_order_date, 
--SUM(customer_value_total_ever_offline + customer_value_total_ever_online) AS TOPLAM_CIRO,
--SUM(order_num_total_ever_offline + order_num_total_ever_online) AS TOPLAM_SIPARIS_SAYISI from FLO
--GROUP by master_id,first_order_date, last_order_date
--ORDER by 4 desc) as F

--SORU 15: En son alışveriş yapılan kanal (last_order_channel) kırılımında en çok alışveriş yapan müşteriyi getiren sorguyu yazınız.
--SELECT DISTINCT last_order_channel AS EN_SON_ALISVERIS_KANALI, 

--(SELECT TOP 1 master_id FROM FLO WHERE last_order_channel =  F.last_order_channel
-- GROUP BY master_id ORDER BY SUM(order_num_total_ever_offline + order_num_total_ever_online) DESC) AS EN_COK_ALISVERIS_YAPAN_MUSTERI, 
 
--(SELECT TOP 1 SUM(order_num_total_ever_offline + order_num_total_ever_online)
-- FROM FLO WHERE last_order_channel =  F.last_order_channel
--GROUP BY master_id ORDER BY SUM(order_num_total_ever_offline + order_num_total_ever_online) DESC) AS TOPLAM_ALISVERIS 
-- FROM FLO AS F ORDER BY 3 DESC


--SELECT DISTINCT last_order_channel, master_id ,SUM(order_num_total_ever_offline + order_num_total_ever_online)
--from FLO GROUP BY last_order_channel, master_id 
--ORDER BY SUM(order_num_total_ever_offline + order_num_total_ever_online) DESC

-- SORU 16: En son alışveriş yapan kişinin ID’ sini getiren sorguyu yazınız. 
--SELECT master_id, last_order_date FROM FLO 
--WHERE last_order_date  = (SELECT MAX(last_order_date) FROM FLO)












