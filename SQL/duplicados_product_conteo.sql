-- Contar solo los duplicados

WITH ProductIDDuplicates AS (
    SELECT
        "product_id",
        COUNT(*) -1 AS duplicate_count
    FROM
        tabla_amazon_product
    GROUP BY
        "product_id"
    HAVING
        COUNT(*) > 1
),
ProductNameDuplicates AS (
    SELECT
        "product_name",
        COUNT(*) - 1 AS duplicate_count
    FROM
        tabla_amazon_product
    GROUP BY
        "product_name"
    HAVING
        COUNT(*) > 1
),
CategoryDuplicates AS (
    SELECT
        "category",
        COUNT(*) - 1 AS duplicate_count
    FROM
        tabla_amazon_product
    GROUP BY
        "category"
    HAVING
        COUNT(*) > 1
),
DiscountedPriceDuplicates AS (
    SELECT
        "discounted_price",
        COUNT(*) - 1 AS duplicate_count
    FROM
        tabla_amazon_product
    GROUP BY
        "discounted_price"
    HAVING
        COUNT(*) > 1
),
ActualPriceDuplicates AS (
    SELECT
        "actual_price",
        COUNT(*) - 1 AS duplicate_count
    FROM
        tabla_amazon_product
    GROUP BY
        "actual_price"
    HAVING
        COUNT(*) > 1
),
DiscountPercentageDuplicates AS (
    SELECT
        "discount_percentage",
        COUNT(*) - 1 AS duplicate_count
    FROM
        tabla_amazon_product
    GROUP BY
        "discount_percentage"
    HAVING
        COUNT(*) > 1
),
AboutProductDuplicates AS (
    SELECT
        "about_product",
        COUNT(*) - 1 AS duplicate_count
    FROM
        tabla_amazon_product
    GROUP BY
        "about_product"
    HAVING
        COUNT(*) > 1
)

SELECT
    COALESCE((SELECT SUM(duplicate_count) FROM ProductIDDuplicates), 0) AS product_id_duplicates,
    COALESCE((SELECT SUM(duplicate_count) FROM ProductNameDuplicates), 0) AS product_name_duplicates,
    COALESCE((SELECT SUM(duplicate_count) FROM CategoryDuplicates), 0) AS category_duplicates,
    COALESCE((SELECT SUM(duplicate_count) FROM DiscountedPriceDuplicates), 0) AS discounted_price_duplicates,
    COALESCE((SELECT SUM(duplicate_count) FROM ActualPriceDuplicates), 0) AS actual_price_duplicates,
    COALESCE((SELECT SUM(duplicate_count) FROM DiscountPercentageDuplicates), 0) AS discount_percentage_duplicates,
    COALESCE((SELECT SUM(duplicate_count) FROM AboutProductDuplicates), 0) AS about_product_duplicates;
