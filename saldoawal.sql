SELECT
		a.id,
		a.bank_nama,
		'Saldo Awal' AS ket,
		1 AS urut,
		DATE_FORMAT(c.dt_posted,'%Y-%m-%d') AS tgl,
		IFNULL(c.total_rupiah,0) AS saldo,
		IFNULL(SUM(IFNULL(e.total,0))/COUNT(DISTINCT f.tanggal_transaksi),0) AS penjualan,
		 IFNULL(SUM(IFNULL(d.jumlah_dana,0))/COUNT(DISTINCT e.tanggal_transaksi)/COUNT(DISTINCT f.tanggal_transaksi),0)  AS penarikan,
		 IFNULL(SUM(IFNULL(f.debit,0))/COUNT(DISTINCT e.tanggal_transaksi),0) AS debit_cash_bank,
		 IFNULL(SUM(IFNULL(f.credit,0))/COUNT(DISTINCT e.tanggal_transaksi),0) AS credit_cash_bank,
		CASE WHEN  (IFNULL(c.total_rupiah,0) + IFNULL(SUM(IFNULL(e.total,0))/COUNT(DISTINCT f.tanggal_transaksi),0)+IFNULL(SUM(IFNULL(f.debit,0))/COUNT(DISTINCT e.tanggal_transaksi),0) ) - (IFNULL(SUM(IFNULL(d.jumlah_dana,0))/COUNT(DISTINCT e.tanggal_transaksi)/COUNT(DISTINCT f.tanggal_transaksi),0)+IFNULL(SUM(IFNULL(f.credit,0))/COUNT(DISTINCT e.tanggal_transaksi),0) ) > 0 THEN (IFNULL(c.total_rupiah,0) + IFNULL(SUM(IFNULL(e.total,0))/COUNT(DISTINCT f.tanggal_transaksi),0)+IFNULL(SUM(IFNULL(f.debit,0))/COUNT(DISTINCT e.tanggal_transaksi),0) ) - (IFNULL(SUM(IFNULL(d.jumlah_dana,0))/COUNT(DISTINCT e.tanggal_transaksi)/COUNT(DISTINCT f.tanggal_transaksi),0)+IFNULL(SUM(IFNULL(f.credit,0))/COUNT(DISTINCT e.tanggal_transaksi),0) ) ELSE 0 END AS debit,
		CASE WHEN  (IFNULL(c.total_rupiah,0) + IFNULL(SUM(IFNULL(e.total,0))/COUNT(DISTINCT f.tanggal_transaksi),0)+IFNULL(SUM(IFNULL(f.debit,0))/COUNT(DISTINCT e.tanggal_transaksi),0)) - (IFNULL(SUM(IFNULL(d.jumlah_dana,0))/COUNT(DISTINCT e.tanggal_transaksi)/COUNT(DISTINCT f.tanggal_transaksi),0)+IFNULL(SUM(IFNULL(f.credit,0))/COUNT(DISTINCT e.tanggal_transaksi),0)  ) < 0 THEN  (IFNULL(c.total_rupiah,0) + IFNULL(SUM(IFNULL(e.total,0))/COUNT(DISTINCT f.tanggal_transaksi),0)+IFNULL(SUM(IFNULL(f.debit,0))/COUNT(DISTINCT e.tanggal_transaksi),0) ) - (IFNULL(SUM(IFNULL(d.jumlah_dana,0))/COUNT(DISTINCT e.tanggal_transaksi)/COUNT(DISTINCT f.tanggal_transaksi),0)+IFNULL(SUM(IFNULL(f.credit,0))/COUNT(DISTINCT e.tanggal_transaksi),0) ) ELSE 0 END AS credit,
		
CASE WHEN (IFNULL(c.total_rupiah,0) + IFNULL(SUM(IFNULL(e.total,0))/COUNT(DISTINCT f.tanggal_transaksi),0)+IFNULL(SUM(IFNULL(f.debit,0))/COUNT(DISTINCT e.tanggal_transaksi),0) ) - (IFNULL(SUM(IFNULL(d.jumlah_dana,0))/COUNT(DISTINCT e.tanggal_transaksi)/COUNT(DISTINCT f.tanggal_transaksi),0)+IFNULL(SUM(IFNULL(f.credit,0))/COUNT(DISTINCT e.tanggal_transaksi),0) ) < 0 THEN ((IFNULL(c.total_rupiah,0) + IFNULL(SUM(IFNULL(e.total,0))/COUNT(DISTINCT f.tanggal_transaksi),0)+IFNULL(SUM(IFNULL(f.debit,0))/COUNT(DISTINCT e.tanggal_transaksi),0) ) - (IFNULL(SUM(IFNULL(d.jumlah_dana,0))/COUNT(DISTINCT e.tanggal_transaksi)/COUNT(DISTINCT f.tanggal_transaksi),0)+IFNULL(SUM(IFNULL(f.credit,0))/COUNT(DISTINCT e.tanggal_transaksi),0) ) )*-1 ELSE (IFNULL(c.total_rupiah,0) + IFNULL(SUM(IFNULL(e.total,0))/COUNT(DISTINCT f.tanggal_transaksi),0)+IFNULL(SUM(IFNULL(f.debit,0))/COUNT(DISTINCT e.tanggal_transaksi),0) ) - (IFNULL(SUM(IFNULL(d.jumlah_dana,0))/COUNT(DISTINCT e.tanggal_transaksi)/COUNT(DISTINCT f.tanggal_transaksi),0)+IFNULL(SUM(IFNULL(f.credit,0))/COUNT(DISTINCT e.tanggal_transaksi),0) )  END  AS total

	FROM bank_sampah a
	LEFT JOIN `v_saldo_awal_bank_min_id` b
	ON a.id = b.bank_id	
	LEFT JOIN `saldo_awal_bank` c
	ON b.id = c.id AND
		DATE_FORMAT(c.dt_posted,'%Y-%m-%d')<"2022-03-08"
	LEFT JOIN `penarikan_dana` d
	ON a.id = d.bank_id AND d.bayar=1 AND
		DATE_FORMAT(d.tanggal_transaksi,'%Y-%m-%d')<"2022-03-08"  
	LEFT JOIN `v_saldo_penjualan` e
	ON a.id = e.bank_id  AND 
		DATE_FORMAT(e.tanggal_transaksi,'%Y-%m-%d')<"2022-03-08" 
	LEFT JOIN `v_saldo_cash_bank` f
	ON a.id =f.bank_id   AND 
		DATE_FORMAT(f.tanggal_transaksi,'%Y-%m-%d')<"2022-03-08" 
	WHERE a.id= 1
	GROUP BY a.id