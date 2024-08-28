WITH category_counts AS (

    SELECT
        general_category,
        COUNT(CASE WHEN category_rating = 'Bajo' THEN 1 END) AS count_bajo,
        COUNT(CASE WHEN category_rating = 'Alto' THEN 1 END) AS count_alto,
        COUNT(*) AS total_count
    FROM
        amazon_unificado
    GROUP BY
        general_category
),
global_counts AS (

    SELECT
        COUNT(CASE WHEN category_rating = 'Bajo' THEN 1 END) AS count_bajo_global,
        COUNT(CASE WHEN category_rating = 'Alto' THEN 1 END) AS count_alto_global,
        COUNT(*) AS total_count_global
    FROM
        amazon_unificado
),
category_risk_relative AS (

    SELECT
        c.general_category,
        c.count_bajo,
        c.count_alto,
        c.total_count,
        c.count_bajo::FLOAT / NULLIF(c.total_count, 0) AS proportion_bajo,
        g.count_bajo_global::FLOAT / NULLIF(g.total_count_global, 0) AS global_proportion_bajo,
        (c.count_bajo::FLOAT / NULLIF(c.total_count, 0)) / NULLIF((g.count_bajo_global::FLOAT / NULLIF(g.total_count_global, 0)), 0) AS riesgo_relativo
    FROM
        category_counts c
    CROSS JOIN
        global_counts g
)

SELECT
    general_category AS "Categoría",
    count_bajo AS "Conteo Bajo",
    count_alto AS "Conteo Alto",
    total_count AS "Total",
    proportion_bajo AS "Proporción Bajo",
    riesgo_relativo AS "Riesgo Relativo"
FROM
    category_risk_relative
ORDER BY
    general_category;
