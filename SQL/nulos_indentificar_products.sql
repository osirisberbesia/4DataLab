SELECT
    COUNT(*) AS total_count,
    SUM(CASE WHEN "product_id" IS NULL THEN 1 ELSE 0 END) AS product_id_nulls,
    SUM(CASE WHEN "product_name" IS NULL THEN 1 ELSE 0 END) AS product_name_nulls,
    SUM(CASE WHEN "category" IS NULL THEN 1 ELSE 0 END) AS category_nulls,
    SUM(CASE WHEN "discounted_price" IS NULL THEN 1 ELSE 0 END) AS discounted_null,
    SUM(CASE WHEN "actual_price" IS NULL THEN 1 ELSE 0 END) AS actual_price_null,
    SUM(CASE WHEN "discount_percentage" IS NULL THEN 1 ELSE 0 END) AS discount_null,
    SUM(CASE WHEN "about_product" IS NULL THEN 1 ELSE 0 END) AS about_null

FROM 
    tabla_amazon_product;

--    "total_count": "1469",
--    "product_id_nulls": "0",
--    "product_name_nulls": "0",
--    "category_nulls": "0",
--    "discounted_null": "0",
--   "actual_price_null": "0",
--    "discount_null": "0",
--    "about_null": "4"




