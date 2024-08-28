-- select * from amazon_unificado veriricacion de la conexión
-- Calculo de la correlación entre las variables rating con discount_percentage


SELECT
    CORR(CAST(rating AS FLOAT8), CAST(discount_percentage AS FLOAT8)) AS correlation
FROM
    amazon_unificado

-- -0.17405556580057413 
-- Tiene a 0, no hay correlación