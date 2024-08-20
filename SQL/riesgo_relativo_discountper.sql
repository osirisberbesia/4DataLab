-- Paso 1: Calcular cuartiles para discount_percentage
WITH discount_quartiles AS (
    SELECT
        percentile_cont(0.25) WITHIN GROUP (ORDER BY discount_percentage::numeric) AS q1,
        percentile_cont(0.50) WITHIN GROUP (ORDER BY discount_percentage::numeric) AS q2,
        percentile_cont(0.75) WITHIN GROUP (ORDER BY discount_percentage::numeric) AS q3
    FROM
        amazon_unificado
),

-- Paso 2: Contar los valores de category_rating por rango de descuento
discount_category_counts AS (
    SELECT
        CASE
            WHEN discount_percentage::numeric <= (SELECT q1 FROM discount_quartiles) THEN 'Menor a ' || CAST((SELECT q1 FROM discount_quartiles) AS TEXT)
            WHEN discount_percentage::numeric <= (SELECT q2 FROM discount_quartiles) THEN 'Menor a ' || CAST((SELECT q2 FROM discount_quartiles) AS TEXT)
            WHEN discount_percentage::numeric <= (SELECT q3 FROM discount_quartiles) THEN 'Menor a ' || CAST((SELECT q3 FROM discount_quartiles) AS TEXT)
            ELSE 'Mayores de ' || CAST((SELECT q3 FROM discount_quartiles) AS TEXT)
        END AS discount_category,
        COUNT(CASE WHEN category_rating = 'Bajo' THEN 1 END) AS count_bajo,
        COUNT(CASE WHEN category_rating = 'Alto' THEN 1 END) AS count_alto,
        COUNT(*) AS total_count,
        (COUNT(CASE WHEN category_rating = 'Bajo' THEN 1 END)::FLOAT / NULLIF(COUNT(*), 0)) AS proportion_bajo
    FROM
        amazon_unificado
    GROUP BY
        CASE
            WHEN discount_percentage::numeric <= (SELECT q1 FROM discount_quartiles) THEN 'Menor a ' || CAST((SELECT q1 FROM discount_quartiles) AS TEXT)
            WHEN discount_percentage::numeric <= (SELECT q2 FROM discount_quartiles) THEN 'Menor a ' || CAST((SELECT q2 FROM discount_quartiles) AS TEXT)
            WHEN discount_percentage::numeric <= (SELECT q3 FROM discount_quartiles) THEN 'Menor a ' || CAST((SELECT q3 FROM discount_quartiles) AS TEXT)
            ELSE 'Mayores de ' || CAST((SELECT q3 FROM discount_quartiles) AS TEXT)
        END
),

-- Paso 3: Contar los valores globales de category_rating
global_counts AS (
    SELECT
        COUNT(CASE WHEN category_rating = 'Bajo' THEN 1 END) AS count_bajo_global,
        COUNT(CASE WHEN category_rating = 'Alto' THEN 1 END) AS count_alto_global,
        COUNT(*) AS total_count_global
    FROM
        amazon_unificado
)

-- Paso 4: Calcular la proporción de 'Bajo' y el riesgo relativo
SELECT
    d.discount_category AS "Rango de Descuento",
    d.count_bajo AS "Conteo Bajo",
    d.count_alto AS "Conteo Alto",
    d.total_count AS "Total",
    d.proportion_bajo AS "Proporción Bajo",
    (d.proportion_bajo / NULLIF((g.count_bajo_global::FLOAT / NULLIF(g.total_count_global, 0)), 0)) AS "Riesgo Relativo"
FROM
    discount_category_counts d
CROSS JOIN
    global_counts g
ORDER BY
    d.discount_category;
