DELIMITER $$

USE `recycle`$$

DROP PROCEDURE IF EXISTS `pRekeningKoranBankBackup`$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pRekeningKoranBankBackup`(IN
				_bank_id BIGINT,
				_sdate VARCHAR(10),
				_edate VARCHAR(10)
    )
BEGIN
DECLARE saldo INT DEFAULT 0;
SELECT * FROM 
(
SELECT
		a.id,
		a.bank_nama,
		'Saldo Awal' AS ket,
		1 AS urut,
		DATE_FORMAT(c.dt_posted,'%Y-%m-%d') AS tgl,
		/*IFNULL(c.total_rupiah,0) AS saldo,
		SUM(IFNULL(e.total,0)) AS penjualan,
		 SUM(IFNULL(d.jumlah_dana,0))/IF(COUNT(e.bank_id)=0,1,COUNT(e.bank_id)) AS penarikan,
		 SUM(IFNULL(f.debit,0))/IF(COUNT(e.bank_id)=0,1,COUNT(e.bank_id)) AS debit_cash_bank,
		 SUM(IFNULL(f.credit,0)) /IF(COUNT(e.bank_id)=0,1,COUNT(e.bank_id)) AS credit_cash_bank,*/
		CASE WHEN  (IFNULL(c.total_rupiah,0) + SUM(IFNULL(e.total,0))+SUM(IFNULL(f.debit,0))/IF(COUNT(e.bank_id)=0,1,COUNT(e.bank_id)) ) - (SUM(IFNULL(d.jumlah_dana,0))/IF(COUNT(e.bank_id)=0,1,COUNT(e.bank_id))+SUM(IFNULL(f.credit,0)) /IF(COUNT(e.bank_id)=0,1,COUNT(e.bank_id)) ) > 0 THEN (IFNULL(c.total_rupiah,0) + SUM(IFNULL(e.total,0))+SUM(IFNULL(f.debit,0))/IF(COUNT(e.bank_id)=0,1,COUNT(e.bank_id)) ) - (SUM(IFNULL(d.jumlah_dana,0))/IF(COUNT(e.bank_id)=0,1,COUNT(e.bank_id))+SUM(IFNULL(f.credit,0)) /IF(COUNT(e.bank_id)=0,1,COUNT(e.bank_id)) ) ELSE 0 END AS debit,
		CASE WHEN  (IFNULL(c.total_rupiah,0) + SUM(IFNULL(e.total,0))+SUM(IFNULL(f.debit,0))/IF(COUNT(e.bank_id)=0,1,COUNT(e.bank_id))) - (SUM(IFNULL(d.jumlah_dana,0))/IF(COUNT(e.bank_id)=0,1,COUNT(e.bank_id))+SUM(IFNULL(f.credit,0)) /IF(COUNT(e.bank_id)=0,1,COUNT(e.bank_id)) ) < 0 THEN  (IFNULL(c.total_rupiah,0) + SUM(IFNULL(e.total,0))+SUM(IFNULL(f.debit,0))/IF(COUNT(e.bank_id)=0,1,COUNT(e.bank_id)) ) - (SUM(IFNULL(d.jumlah_dana,0))/IF(COUNT(e.bank_id)=0,1,COUNT(e.bank_id))+SUM(IFNULL(f.credit,0)) /IF(COUNT(e.bank_id)=0,1,COUNT(e.bank_id)) ) ELSE 0 END AS credit,
CASE WHEN (IFNULL(c.total_rupiah,0) + SUM(IFNULL(e.total,0))+SUM(IFNULL(f.debit,0))/IF(COUNT(e.bank_id)=0,1,COUNT(e.bank_id)) ) - (SUM(IFNULL(d.jumlah_dana,0))/IF(COUNT(e.bank_id)=0,1,COUNT(e.bank_id))+SUM(IFNULL(f.credit,0)) /IF(COUNT(e.bank_id)=0,1,COUNT(e.bank_id)) ) < 0 THEN ((IFNULL(c.total_rupiah,0) + SUM(IFNULL(e.total,0))+SUM(IFNULL(f.debit,0))/IF(COUNT(e.bank_id)=0,1,COUNT(e.bank_id)) ) - (SUM(IFNULL(d.jumlah_dana,0))/IF(COUNT(e.bank_id)=0,1,COUNT(e.bank_id))+SUM(IFNULL(f.credit,0)) /IF(COUNT(e.bank_id)=0,1,COUNT(e.bank_id)) ) )*-1 ELSE (IFNULL(c.total_rupiah,0) + SUM(IFNULL(e.total,0))+SUM(IFNULL(f.debit,0))/IF(COUNT(e.bank_id)=0,1,COUNT(e.bank_id)) ) - (SUM(IFNULL(d.jumlah_dana,0))/IF(COUNT(e.bank_id)=0,1,COUNT(e.bank_id))+SUM(IFNULL(f.credit,0)) /IF(COUNT(e.bank_id)=0,1,COUNT(e.bank_id)) )  END  AS total
	FROM bank_sampah a
	LEFT JOIN `v_saldo_awal_bank_min_id` b
	ON a.id = b.bank_id	
	LEFT JOIN `saldo_awal_bank` c
	ON b.id = c.id AND
		DATE_FORMAT(c.dt_posted,'%Y-%m-%d')<_sdate
	LEFT JOIN `penarikan_dana` d
	ON a.id = d.bank_id AND d.bayar=1 AND
		DATE_FORMAT(d.tanggal_transaksi,'%Y-%m-%d')<_sdate 
	LEFT JOIN `v_saldo_penjualan` e
	ON a.id = e.bank_id  AND 
		DATE_FORMAT(e.tanggal_transaksi,'%Y-%m-%d')<_sdate
		LEFT JOIN `v_saldo_cash_bank` f
	ON a.id =f.bank_id   AND 
		DATE_FORMAT(f.tanggal_transaksi,'%Y-%m-%d')<_sdate
	WHERE a.id= _bank_id
	GROUP BY a.id
UNION ALL
SELECT
		a.id,
		a.bank_nama,
		'Penarikan Dana' AS ket,
		5 AS urut,
		DATE_FORMAT(b.tanggal_transaksi,'%Y-%m-%d') AS tgl,
		0 AS debit,
		IFNULL(b.jumlah_dana,0) AS credit,
		IFNULL(b.jumlah_dana,0) AS total
	FROM bank_sampah a
	LEFT JOIN `penarikan_dana` b
	ON a.id = b.bank_id AND b.bayar=1 
	WHERE a.id = _bank_id AND 
		DATE_FORMAT(b.tanggal_transaksi,'%Y-%m-%d')>=_sdate AND
		DATE_FORMAT(b.tanggal_transaksi,'%Y-%m-%d')<=_edate
UNION ALL
SELECT
		a.id,
		a.bank_nama,
		'Penjualan' AS ket,
		2 AS urut,
		DATE_FORMAT(b.tanggal_transaksi,'%Y-%m-%d') AS tgl,
		IFNULL(b.total,0) AS debit,
		0 AS credit,
		IFNULL(b.total,0) AS total
	FROM bank_sampah a
	LEFT JOIN `v_penjualan_header` b
	ON a.id = b.bank_id  
	WHERE a.id = _bank_id AND 
		DATE_FORMAT(b.tanggal_transaksi,'%Y-%m-%d')>=_sdate AND
		DATE_FORMAT(b.tanggal_transaksi,'%Y-%m-%d')<=_edate
UNION ALL
	SELECT
		a.id,
		a.bank_nama,
		'CashBank' AS ket,
		CASE WHEN pemasukan = 1 THEN 
		3  ELSE  4 END AS urut,
		DATE_FORMAT(b.tanggal_transaksi,'%Y-%m-%d') AS tgl,
		CASE WHEN pemasukan = 1 THEN 
		IFNULL(b.jumlah_rupiah,0)  ELSE  0 END AS debit,
		CASE WHEN pemasukan = 0 THEN 
		IFNULL(b.jumlah_rupiah,0)  ELSE  0 END AS credit,
		IFNULL(b.jumlah_rupiah,0) AS total
	FROM bank_sampah a
	LEFT JOIN `cash_bank` b
	ON a.id = b.bank_id 
	WHERE a.id = _bank_id AND 
		DATE_FORMAT(b.tanggal_transaksi,'%Y-%m-%d')>=_sdate AND
		DATE_FORMAT(b.tanggal_transaksi,'%Y-%m-%d')<=_edate        
)a
ORDER BY a.tgl, urut;
	END$$

DELIMITER ;