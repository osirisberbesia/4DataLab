WITH ProductIDDuplicates AS (
    SELECT
        "Product ID",
        COUNT(*) - 1 AS duplicate_count
    FROM
        amazon_product_noduplicados
    GROUP BY
        "Product ID"
    HAVING
        COUNT(*) > 1
),
ProductNameDuplicates AS (
    SELECT
        "Product Name",
        COUNT(*) - 1 AS duplicate_count
    FROM
        amazon_product_noduplicados
    GROUP BY
        "Product Name"
    HAVING
        COUNT(*) > 1
),
CategoryDuplicates AS (
    SELECT
        "Category",
        COUNT(*) - 1 AS duplicate_count
    FROM
        amazon_product_noduplicados
    GROUP BY
        "Category"
    HAVING
        COUNT(*) > 1
),
DiscountedPriceDuplicates AS (
    SELECT
        "Discounted Price",
        COUNT(*) - 1 AS duplicate_count
    FROM
        amazon_product_noduplicados
    GROUP BY
        "Discounted Price"
    HAVING
        COUNT(*) > 1
),
ActualPriceDuplicates AS (
    SELECT
        "Actual Price",
        COUNT(*) - 1 AS duplicate_count
    FROM
        amazon_product_noduplicados
    GROUP BY
        "Actual Price"
    HAVING
        COUNT(*) > 1
),
DiscountPercentageDuplicates AS (
    SELECT
        "Discount Percentage",
        COUNT(*) - 1 AS duplicate_count
    FROM
        amazon_product_noduplicados
    GROUP BY
        "Discount Percentage"
    HAVING
        COUNT(*) > 1
),
AboutProductDuplicates AS (
    SELECT
        "About Product",
        COUNT(*) - 1 AS duplicate_count
    FROM
        amazon_product_noduplicados
    GROUP BY
        "About Product"
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
