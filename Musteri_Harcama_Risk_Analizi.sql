-- 1. Tabloyu Oluşturalım 
CREATE TABLE Musteri_Harcamalari (
    islem_id INT PRIMARY KEY,
    musteri_adi VARCHAR(50),
    harcama_miktari DECIMAL(10,2),
    islem_tarihi DATE,
    odeme_turu VARCHAR(20) -- Nakit, Kredi Kartı vb.
);

INSERT INTO Musteri_Harcamalari VALUES (1, 'Ahmet Yılmaz', 1500.50, '2026-04-10', 'Kredi Kartı');
INSERT INTO Musteri_Harcamalari VALUES (2, 'Ayşe Demir', 450.00, '2026-04-12', 'Nakit');
INSERT INTO Musteri_Harcamalari VALUES (3, 'Mehmet Can', 2800.00, '2026-04-15', 'Kredi Kartı');
INSERT INTO Musteri_Harcamalari VALUES (4, 'Selin Kaya', 95.00, '2026-04-18', 'Nakit');
INSERT INTO Musteri_Harcamalari VALUES (5, 'Zeynep Ak', 5200.00, '2026-04-20', 'Kredi Kartı');

-- 3. ZOR VE ETKİLEYİCİ ANALİZ SORGUSU
-- Burada müşterileri harcama miktarına göre segmentlere ayırıyoruz 
-- ve sadece "Kredi Kartı" kullanan yüksek potansiyelli müşterilere odaklanıyoruz.

SELECT 
    musteri_adi,
    harcama_miktari,
    odeme_turu,
    CASE 
        WHEN harcama_miktari >= 3000 THEN 'VIP Müşteri (Stratejik)'
        WHEN harcama_miktari BETWEEN 1000 AND 2999 THEN 'Sadık Müşteri'
        ELSE 'Yeni/Düşük Harcamalı Müşteri'
    END AS Musteri_Segmenti,
    -- Bir sonraki harcamada uygulanabilecek indirim oranını hesaplayalım
    CASE 
        WHEN harcama_miktari >= 3000 THEN '%%20 İndirim Tanımla'
        WHEN harcama_miktari BETWEEN 1000 AND 2999 THEN '%%10 İndirim Tanımla'
        ELSE 'İndirim Yok'
    END AS Kampanya_Aksiyonu
FROM Musteri_Harcamalari
WHERE odeme_turu = 'Kredi Kartı' -- Sadece kartlı işlemleri analiz ediyoruz
ORDER BY harcama_miktari DESC; -- En çok harcayan en üstte görünsün