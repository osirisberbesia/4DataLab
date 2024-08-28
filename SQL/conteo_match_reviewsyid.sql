SELECT 

	ARRAY_LENGTH(STRING_TO_ARRAY(tabla_amazon_review.review_id, ','), 1) AS reviews_count,
     tabla_amazon_review.review_title,
    tabla_amazon_review.review_content,
    tabla_amazon_review.img_link,
    tabla_amazon_review.product_link,
    tabla_amazon_review.product_id,
    tabla_amazon_review.rating,
    tabla_amazon_review.rating_count
FROM tabla_amazon_review
	
WHERE ARRAY_LENGTH(STRING_TO_ARRAY(tabla_amazon_review.user_id, ','), 1) <> 
      ARRAY_LENGTH(STRING_TO_ARRAY(tabla_amazon_review.review_id, ','), 1);