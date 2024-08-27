 SELECT reviews_count,
    review_title,
    review_content,
    img_link,
    product_link,
    product_id,
    rating,
    rating_count
   FROM amazon_review_noduplicados
  WHERE (product_id IN ( SELECT ab.product_id
           FROM amazon_review_noduplicados ab
          GROUP BY ab.product_id
         HAVING count(*) = 1));