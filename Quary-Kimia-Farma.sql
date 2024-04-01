CREATE TABLE `kimia_farma.kf_analisa1` AS
SELECT ft.transaction_id, ft.date, ft.branch_id, kc.branch_name, kc.kota, kc.provinsi, kc.rating, ft.customer_name, pro.product_id, pro.product_name, pro.price, ft.discount_percentage,
CASE
    WHEN pro.price <= 50000 THEN 0.1
    WHEN pro.price > 50000 AND pro.price <= 100000 THEN 0.15
    WHEN pro.price > 100000 AND pro.price <= 300000 THEN 0.2
    WHEN pro.price > 300000 AND pro.price <= 500000 THEN 0.25
    WHEN pro.price > 500000 THEN 0.3
    ELSE 0
  END AS persentage_gross_laba,
  pro.price * (1 - ft.discount_percentage) AS nett_sales,
  pro.price - (pro.price * ft.discount_percentage) AS nett_profit,
  ft.rating AS rating_transaksi
FROM kimia_farma.kf_final_transaction AS ft
LEFT JOIN kimia_farma.kf_kantor_cabang AS kc
  ON ft.branch_id = kc.branch_id
LEFT JOIN kimia_farma.kf_product AS pro
  ON ft.product_id = pro.product_id;