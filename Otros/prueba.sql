select img_count, count( img_count) as conteo from amazon_unificado
GROUP BY img_count
ORDER BY count(img_count) DESC



