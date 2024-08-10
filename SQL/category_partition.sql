WITH cleaneddata AS (
    SELECT 
        TRIM(BOTH FROM amazon_products.product_id) AS cleaned_product_id,
        TRIM(BOTH FROM amazon_products.product_name) AS cleaned_product_name,
        TRIM(BOTH FROM amazon_products.category) AS cleaned_category,
        TRIM(BOTH FROM amazon_products.discounted_price) AS cleaned_discounted_price,
        TRIM(BOTH FROM amazon_products.actual_price) AS cleaned_actual_price,
        TRIM(BOTH FROM amazon_products.discount_percentage) AS cleaned_discount_percentage,
        TRIM(BOTH FROM amazon_products.about_product) AS cleaned_about_product
    FROM amazon_products
), rankeddata AS (
    SELECT 
        cleaneddata.cleaned_product_id,
        cleaneddata.cleaned_product_name,
        cleaneddata.cleaned_category,
        cleaneddata.cleaned_discounted_price,
        cleaneddata.cleaned_actual_price,
        cleaneddata.cleaned_discount_percentage,
        cleaneddata.cleaned_about_product,
        row_number() OVER (PARTITION BY cleaneddata.cleaned_product_id ORDER BY (
            CASE
                WHEN cleaneddata.cleaned_product_name IS NOT NULL AND cleaneddata.cleaned_product_name <> ''::text THEN 1
                ELSE 0
            END +
            CASE
                WHEN cleaneddata.cleaned_category IS NOT NULL AND cleaneddata.cleaned_category <> ''::text THEN 1
                ELSE 0
            END +
            CASE
                WHEN cleaneddata.cleaned_discounted_price IS NOT NULL AND cleaneddata.cleaned_discounted_price <> ''::text THEN 1
                ELSE 0
            END +
            CASE
                WHEN cleaneddata.cleaned_actual_price IS NOT NULL AND cleaneddata.cleaned_actual_price <> ''::text THEN 1
                ELSE 0
            END +
            CASE
                WHEN cleaneddata.cleaned_discount_percentage IS NOT NULL AND cleaneddata.cleaned_discount_percentage <> ''::text THEN 1
                ELSE 0
            END +
            CASE
                WHEN cleaneddata.cleaned_about_product IS NOT NULL AND cleaneddata.cleaned_about_product <> ''::text THEN 1
                ELSE 0
            END) DESC) - 1 AS appearance_rank
    FROM cleaneddata
)
SELECT 
    cleaned_product_id AS product_id,
    cleaned_product_name AS product_name,
    split_part(cleaned_category, '|', 1) AS general_category,
    CASE
        WHEN length(cleaned_category) - length(replace(cleaned_category, '|', '')) >= 1 THEN
            split_part(cleaned_category, '|', array_length(regexp_split_to_array(cleaned_category, '\|'), 1))
        ELSE
            'No second category'
    END AS specific_category,
    cleaned_discounted_price AS discounted_price,
    cleaned_actual_price AS actual_price,
    cleaned_discount_percentage AS discount_percentage,
    cleaned_about_product AS about_product
FROM rankeddata
WHERE appearance_rank = 0
ORDER BY cleaned_product_id, appearance_rank;
