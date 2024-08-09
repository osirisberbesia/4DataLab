WITH duplicates AS (
    SELECT 
        review_title, review_content, product_id
    FROM 
        tabla_amazon_review
    GROUP BY 
        review_title, review_content, product_id
    HAVING 
        COUNT(*) > 1
)
SELECT 
   a.review_title, a.review_content, a.product_id
FROM 
    tabla_amazon_review a
JOIN 
    duplicates d
ON 
    a.review_content = d.review_content
ORDER BY 
    a.review_content, a.product_id;
