-- Limpiar, buscar duplicados, y agregar columna de aparición
WITH CleanedData AS (
    SELECT
        "Product ID" AS original_product_id,
        LOWER(REGEXP_REPLACE(TRIM("Product Name"), '[^a-zA-Z0-9áéíóúÁÉÍÓÚ]', '', 'g')) AS cleaned_product_name,
        LOWER(REGEXP_REPLACE(TRIM("Category"), '[^a-zA-Z0-9áéíóúÁÉÍÓÚ]', '', 'g')) AS cleaned_category,
        LOWER(REGEXP_REPLACE(TRIM("Discounted Price"), '[^a-zA-Z0-9áéíóúÁÉÍÓÚ]', '', 'g')) AS cleaned_discounted_price,
        LOWER(REGEXP_REPLACE(TRIM("Actual Price"), '[^a-zA-Z0-9áéíóúÁÉÍÓÚ]', '', 'g')) AS cleaned_actual_price,
        LOWER(REGEXP_REPLACE(TRIM("Discount Percentage"), '[^a-zA-Z0-9áéíóúÁÉÍÓÚ]', '', 'g')) AS cleaned_discount_percentage,
        LOWER(REGEXP_REPLACE(TRIM("About Product"), '[^a-zA-Z0-9áéíóúÁÉÍÓÚ]', '', 'g')) AS cleaned_about_product
    FROM
        amazon_product_noduplicados
),
RankedData AS (
    SELECT
        original_product_id,
        cleaned_product_name,
        cleaned_category,
        cleaned_discounted_price,
        cleaned_actual_price,
        cleaned_discount_percentage,
        cleaned_about_product,
        ROW_NUMBER() OVER (
            PARTITION BY cleaned_product_name, cleaned_category, cleaned_discounted_price, cleaned_actual_price, cleaned_discount_percentage, cleaned_about_product
            ORDER BY cleaned_product_name, cleaned_category, cleaned_discounted_price, cleaned_actual_price, cleaned_discount_percentage, cleaned_about_product
        ) - 1 AS appearance_rank
    FROM
        CleanedData
),
Duplicates AS (
    SELECT
        cleaned_product_name,
        cleaned_category,
        cleaned_discounted_price,
        cleaned_actual_price,
        cleaned_discount_percentage,
        cleaned_about_product,
        COUNT(*) AS cnt
    FROM
        CleanedData
    GROUP BY
        cleaned_product_name, cleaned_category, cleaned_discounted_price, cleaned_actual_price, cleaned_discount_percentage, cleaned_about_product
    HAVING
        COUNT(*) > 1
)

SELECT
    r.cleaned_product_name AS "Product Name",
    r.cleaned_category AS "Category",
    r.cleaned_discounted_price AS "Discounted Price",
    r.cleaned_actual_price AS "Actual Price",
    r.cleaned_discount_percentage AS "Discount Percentage",
    r.cleaned_about_product AS "About Product",
    r.appearance_rank AS "Appearance Rank",
    r.original_product_id AS "Product ID"
FROM
    RankedData r
JOIN
    Duplicates d
ON
    r.cleaned_product_name = d.cleaned_product_name AND
    r.cleaned_category = d.cleaned_category AND
    r.cleaned_discounted_price = d.cleaned_discounted_price AND
    r.cleaned_actual_price = d.cleaned_actual_price AND
    r.cleaned_discount_percentage = d.cleaned_discount_percentage AND
    r.cleaned_about_product = d.cleaned_about_product
ORDER BY
    r.cleaned_product_name, r.cleaned_category, r.appearance_rank;
