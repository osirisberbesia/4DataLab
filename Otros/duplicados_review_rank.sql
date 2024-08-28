WITH RankedData AS (
    SELECT 
   ARRAY_LENGTH(STRING_TO_ARRAY(review_id, ','), 1) AS reviews_count, 
    review_title, 
    review_content, 
    COALESCE(img_link, 'about:blank') AS img_link, 
    COALESCE(product_link, 'about:blank') AS product_link, 
    product_id, 
    rating, 
    COALESCE(rating_count, '0') AS rating_count,
        ROW_NUMBER() OVER (
            PARTITION BY review_title, review_content
            ORDER BY review_title, review_content
        ) - 1 AS dato_original
    FROM 
        tabla_amazon_review
)
SELECT 
*
FROM 
    RankedData
WHERE dato_original = 0
ORDER BY 
    review_title, 
    review_content

