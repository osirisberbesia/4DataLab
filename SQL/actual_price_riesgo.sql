-- Paso 1: Calcular cuartiles y conteos globales en una sola consulta
WITH price_quartiles AS (
    SELECT
        percentile_cont(0.25) WITHIN GROUP (ORDER BY actual_price::numeric) AS q1,
        percentile_cont(0.50) WITHIN GROUP (ORDER BY actual_price::numeric) AS q2,
        percentile_cont(0.75) WITHIN GROUP (ORDER BY actual_price::numeric) AS q3
    FROM
        amazon_unificado
),
global_counts AS (
    SELECT
        COUNT(CASE WHEN category_rating = 'Bajo' THEN 1 END) AS count_bajo_global,
        COUNT(CASE WHEN category_rating = 'Alto' THEN 1 END) AS count_alto_global,
        COUNT(*) AS total_count_global
    FROM
        amazon_unificado
)
SELECT
    CASE
        WHEN actual_price::numeric <= (SELECT q1 FROM price_quartiles) THEN 'Menor a ' || CAST((SELECT q1 FROM price_quartiles) AS TEXT)
        WHEN actual_price::numeric <= (SELECT q2 FROM price_quartiles) THEN 'Menor a ' || CAST((SELECT q2 FROM price_quartiles) AS TEXT)
        WHEN actual_price::numeric <= (SELECT q3 FROM price_quartiles) THEN 'Menor a ' || CAST((SELECT q3 FROM price_quartiles) AS TEXT)
        ELSE 'Mayores de ' || CAST((SELECT q3 FROM price_quartiles) AS TEXT)
    END AS price_category,
    COUNT(CASE WHEN category_rating = 'Bajo' THEN 1 END) AS count_bajo,
    COUNT(CASE WHEN category_rating = 'Alto' THEN 1 END) AS count_alto,
    COUNT(*) AS total_count,
    (COUNT(CASE WHEN category_rating = 'Bajo' THEN 1 END)::FLOAT / NULLIF(COUNT(*), 0)) AS proportion_bajo,
    ((COUNT(CASE WHEN category_rating = 'Bajo' THEN 1 END)::FLOAT / NULLIF(COUNT(*), 0)) / NULLIF((SELECT count_bajo_global::FLOAT / NULLIF(total_count_global, 0) FROM global_counts), 0)) AS risk_relative
FROM
    amazon_unificado
GROUP BY
    CASE
        WHEN actual_price::numeric <= (SELECT q1 FROM price_quartiles) THEN 'Menor a ' || CAST((SELECT q1 FROM price_quartiles) AS TEXT)
        WHEN actual_price::numeric <= (SELECT q2 FROM price_quartiles) THEN 'Menor a ' || CAST((SELECT q2 FROM price_quartiles) AS TEXT)
        WHEN actual_price::numeric <= (SELECT q3 FROM price_quartiles) THEN 'Menor a ' || CAST((SELECT q3 FROM price_quartiles) AS TEXT)
        ELSE 'Mayores de ' || CAST((SELECT q3 FROM price_quartiles) AS TEXT)
    END
ORDER BY
    price_category;
