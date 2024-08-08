SELECT
    COUNT(*) AS total_count,
    SUM(CASE WHEN "user_id" IS NULL THEN 1 ELSE 0 END) AS user_id_null_count,
    SUM(CASE WHEN "user_name" IS NULL THEN 1 ELSE 0 END) AS user_name_null_count,
    SUM(CASE WHEN "review_id" IS NULL THEN 1 ELSE 0 END) AS review_id_null_count,
    SUM(CASE WHEN "review_title" IS NULL THEN 1 ELSE 0 END) AS review_title_null_count,
    SUM(CASE WHEN "review_content" IS NULL THEN 1 ELSE 0 END) AS review_content_null_count,
    SUM(CASE WHEN "img_link" IS NULL THEN 1 ELSE 0 END) AS img_link_null_count,
    SUM(CASE WHEN "product_link" IS NULL THEN 1 ELSE 0 END) AS product_link_null_count,
    SUM(CASE WHEN "product_id" IS NULL THEN 1 ELSE 0 END) AS product_id_null_count,
    SUM(CASE WHEN "rating" IS NULL THEN 1 ELSE 0 END) AS rating_null_count,
    SUM(CASE WHEN "rating_count" IS NULL THEN 1 ELSE 0 END) AS rating_count_null_count
FROM 
    tabla_amazon_review;

--    "total_count": "1465",
--    "user_id_null_count": "0",
--    "user_name_null_count": "0",
--    "review_id_null_count": "0",
--    "review_title_null_count": "0",
--    "review_content_null_count": "0",
--    "img_link_null_count": "466",
--    "product_link_null_count": "466",
--    "product_id_null_count": "0",
--    "rating_null_count": "0",
--    "rating_count_null_count": "2"


