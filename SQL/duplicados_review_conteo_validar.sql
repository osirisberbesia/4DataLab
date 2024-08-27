-- Contar solo los duplicados en amazon_review_clean

WITH 

ReviewTitleDuplicates AS (
    SELECT
        "review_title",
        COUNT(*) - 1 AS duplicate_count
    FROM
        amazon_review_clean
    GROUP BY
        "review_title"
    HAVING
        COUNT(*) > 1
),
ReviewContentDuplicates AS (
    SELECT
        "review_content",
        COUNT(*) - 1 AS duplicate_count
    FROM
        amazon_review_clean
    GROUP BY
        "review_content"
    HAVING
        COUNT(*) > 1
),
ImgLinkDuplicates AS (
    SELECT
        "img_link",
        COUNT(*) - 1 AS duplicate_count
    FROM
        amazon_review_clean
    GROUP BY
        "img_link"
    HAVING
        COUNT(*) > 1
),
ProductLinkDuplicates AS (
    SELECT
        "product_link",
        COUNT(*) - 1 AS duplicate_count
    FROM
        amazon_review_clean
    GROUP BY
        "product_link"
    HAVING
        COUNT(*) > 1
),
ProductIDDuplicates AS (
    SELECT
        "product_id",
        COUNT(*) - 1 AS duplicate_count
    FROM
        amazon_review_clean
    GROUP BY
        "product_id"
    HAVING
        COUNT(*) > 1
),
RatingDuplicates AS (
    SELECT
        "rating",
        COUNT(*) - 1 AS duplicate_count
    FROM
        amazon_review_clean
    GROUP BY
        "rating"
    HAVING
        COUNT(*) > 1
),
RatingCountDuplicates AS (
    SELECT
        "rating_count",
        COUNT(*) - 1 AS duplicate_count
    FROM
        amazon_review_clean
    GROUP BY
        "rating_count"
    HAVING
        COUNT(*) > 1
)

SELECT
    COALESCE((SELECT SUM(duplicate_count) FROM ReviewTitleDuplicates), 0) AS review_title_duplicates,
    COALESCE((SELECT SUM(duplicate_count) FROM ReviewContentDuplicates), 0) AS review_content_duplicates,
    COALESCE((SELECT SUM(duplicate_count) FROM ImgLinkDuplicates), 0) AS img_link_duplicates,
    COALESCE((SELECT SUM(duplicate_count) FROM ProductLinkDuplicates), 0) AS product_link_duplicates,
    COALESCE((SELECT SUM(duplicate_count) FROM ProductIDDuplicates), 0) AS product_id_duplicates,
    COALESCE((SELECT SUM(duplicate_count) FROM RatingDuplicates), 0) AS rating_duplicates,
    COALESCE((SELECT SUM(duplicate_count) FROM RatingCountDuplicates), 0) AS rating_count_duplicates;
