# Proyecto 4 - DataLab
## Amazon Sales

## Integrantes:
* [Berbesia Osiris](https://github.com/osirisberbesia/)
* [Fonseca Karen](https://github.com/Karenfonseca22)

# Hipótesis del caso

1. **Los usuarios confían más en las calificaciones que son más altas, en comparación a las calificaciones bajas.:** confiabilidad con el conteo de votos, y la categorización del rating (alto, bajo).
2. **Calificación promedio por categoría:** Diferencias significativas en la calificación promedio entre productos de distintas categorías.
3. **Impacto de las imágenes en las reseñas:** Los productos con reseñas que incluyen imágenes adicionales tienden a recibir calificaciones más altas que aquellos con reseñas solo textuales.
4. **Relación entre descuento y puntuación:** A mayor descuento, mejor será la calificación del producto.
5. **Descuento por categoría:** Variaciones significativas en los porcentajes de descuento entre productos de diferentes categorías.

# Procesamiento y Preparación de la Base de Datos

En esta primera etapa, se importarán y limpiarán los datos para asegurar su calidad, abordando valores nulos, duplicados y outliers. Se corregirán discrepancias en variables categóricas y numéricas, transformarán tipos de datos y crearán nuevas variables relevantes. 

Esta base de datos, que incluye variables numéricas y de texto sobre reseñas en Amazon, se consolidará para facilitar el análisis exploratorio enfocado en los ratings y la cantidad de reseñas disponibles.

## Conectar/Importar Datos a Herramientas

Desde los dataset .csv, llamados amazon_product y amazon_reviews, para trabajarlos se utilizó:

* BigQuery/PostgreSQL 
* Google Colab
* Tableau

Lo anterior con el fin de importar y conectar los datos. 


## Identificar y Manejar Valores Nulos

### Nulos para tabla de productos
* Consulta para la data: [Productos](SQL\nulos_indentificar_products.sql)


| Variable | Nulos| Acción |
|-|-|-|
| product_id |  0 | Ninguna acción requerida | 
| product_name |  0 |Ninguna acción requerida  | 
| category |  0 | Ninguna acción requerida | 
| discounted_price |  0 | Ninguna acción requerida | 
| actual_price |  0 |Ninguna acción requerida | 
| discount_percentage |  0 | Ninguna acción requerida | 
| about_product | 4 | No se realiza ningún cambio ya que al eliminar los duplicados de product_id, se desaparecen estos nulos |
||||

### Nulos para tabla de reviews

* Consulta para la data: [Reviews](SQL\nulos_indentificar_review.sql)


| Variable | Nulos | Acción |
|-|-|-|
| user_id| 0 | Ninguna acción requerida|
| user_name| 0 | Ninguna acción requerida|
| review_id| 0 | Ninguna acción requerida|
| review_title| 0 | Ninguna acción requerida|
| review_content| 0 | Ninguna acción requerida|
| img_link| 466 |  Se cambia el link a **about:blank** |
| product_link| 466 | Se cambia el link a **about:blank** |
| product_id| 0 | Ninguna acción requerida|
| rating| 0 | Ninguna acción requerida|
| rating_count| 2 | Se sustituyen nulos por 0|
||||

## Identificar y Manejar Valores Duplicados

### Duplicados para tabla de producto


* [Productos duplicados (conteo)](SQL\duplicados_product_conteo.sql)

| Variable | Duplicados| Acción |
|-|-|-|
| product_id | 118| Se dejan los datos únicos, dejando por fuera los 118 duplicados |
| product_name | 132 | Ninguna acción. Esta variable puede tener duplicados |
| category | 1258 | Ninguna acción. Esta variable puede tener duplicados |
| discounted_price | 919| Ninguna acción. Esta variable puede tener duplicados |
| actual_price | 1020 | Ninguna acción. Esta variable puede tener duplicados |
| discount_percentage | 1377 | Ninguna acción. Esta variable puede tener duplicados |
| about_product | 175 | Ninguna acción. Esta variable puede tener duplicados | 

###
Para los datos duplicados también se hizo un análisis del concatenado de toda la información.

Usando [esta](SQL\duplicados_product_conteovalidacion.sql) query.

Dando como resultado, que tenemos 16 datos que atender. Sin embargo, se decide dejar estos datos a pesar de estar duplicados, porque no tenemos la foto para corroborar si cambia en color o estilo, a pesar de tener las mismas características. E igualmente no tenemos información de si es el mismo vendedor quien lo publica.

Quedan 1351 datos posterior a la limpieza de duplicados.

### Duplicados en tabla review


* [Reviews duplicadas (conteo)](SQL\duplicados_review_conteo.sql)


| Variable | Duplicados| Acción |
|-|-|-|
| user_id |  271 | Ninguna acción. No se trabaja con esta variable  |
| user_name |  271 | Ninguna acción. No se trabaja con esta variable |
| review_id |  271 | Ninguna acción. No se trabaja con esta variable |
| review_title |  271 | Ninguna acción requerida. |
| review_content , img_link , product_link ,product_id |  253 | Se trabaja solo con los datos originales  |
| rating |  1439 | Ninguna acción, duplicados permitidos |
| rating_count |  321 |  Ninguna acción, duplicados permitidos |

Los duplicados se basarán en la coincidencia al mismo tiempo y con la misma información de las variables:

* review_content 
* img_link 
* product_link 
* product_id

> Finalizando la limpieza de los duplicados con las combinaciones anteriores, quedaron datos duplicados en product_id, los cuales se excluyeron con la [siguiente query](SQL\clean_product_id_review.sql). 

---


## Identificar y Manejar Datos Fuera del Alcance del Análisis

### Manejo de outliers para tabla amazon_product

Boxplot de variable discounted_price

![discounted_price box](https://github.com/user-attachments/assets/e997ce96-3c15-4ede-a43c-2e416b23ce4a)

Boxplot actual_price

![actual_price boxplot](https://github.com/user-attachments/assets/4a8b0226-b959-4b1a-830a-d34ff239716a)

Boxplot de discounted_percentage

![discounted_percentage boxplot](https://github.com/user-attachments/assets/0cfc352a-9ec9-4c81-a505-6406801c5c56)

### Manejo de outliers para tabla amazon_review

Boxplot de variable reviews_content (Variable que me cuenta los review_id)

![image](https://github.com/user-attachments/assets/4ccce97e-899d-4062-a8ac-e43395451669)

Boxplot de variable rating (Variable con su calificación)

![rating box](https://github.com/user-attachments/assets/76be8013-ae64-41d1-9cf8-6410af8ec2f9)

Boxplot de variable rating_count (conteo de personas que votaron por su calificación)

![rating_count boxplot](https://github.com/user-attachments/assets/66d62105-cf05-4875-9b7d-a47d1cfbffa7)

> Al identificar los outliers, por la naturaleza de estos, se decide dejarlos por fuera del analisis.


## Identificar y Manejar Datos Discrepantes en Variables Categóricas y Numéricas

En la variable 'rating' se encontro un dato con el simbolo '|', este campo se reemplazo con el numero 0


## Comprobar y Cambiar Tipo de Dato

Para la variable 'rating' se cambio de STRING a FLOAT64, con la función CAST

## Crear Nuevas Variables

| Variable origen |Variable creada | Significado | 
|--|--|--|
| review_id |  reviews_count| Separa los valores de los ID en forma de Array, los cuales están separados uno de los otros por comas en la variable origen, para cuantificar cuantos reviews se registraron en ese producto |
| category | general_category | Se eligió la primera categoría de la descripción de categorías en la que se encuentra el producto. |
| category | specific_category | Dado que la descripción de categorías va desde la más general a la más específica, se tomó en cuenta la última categoría en la que se encuentra el producto para crear la variable 'specific_category'.|
|discounted_percentage | category_discount | Separa el porcentaje de descuento en 4 grupos, leve (< 0.31), moderado (entre 0.31 y 0.49), intermedio (entre 0.49 y 0.62), significativo ( mayores a 0.62) |
| rating | category_rating | Se categorizaron los rating 1, 2, 3 como 'Bajo', y 4 , 5 de rating como 'Alto'|
|rating_count | category_rating_count | Segmentación del conteo de rating por cuartiles, las categorias son, Poco confiable (menores a 932), Medio confiable ( entre 932 y 3714), Moderadamente confiable (entre 3714 y 13156), Confiable (Mayores a 13156) |
| review_content | image_count | Conteo de link de imagenes dentro del contenido de review |
| category_rating y category_rating_count | rating_segmentation| Concatenacion de las variables creadas category_rating y category_rating_count, un ejemplo de retorno es 'Alto (Poco confiable)' |

## Unir Tablas

> Despues de realizar la limpieza de datos, en donde se identificaron y manejaron datos nulos, duplicados, discrepantes y atipicos (outliers), se unieron las tablas con el nombre "amazon_unificado".


# Análisis Exploratorio

Para este análisis se exploraron la visualizaron de las hipotesis planteadas al inicio del proyecto.

## Agrupar Datos Según Variables Categóricas

Se crearon nuevas variables categoricas que agrupan datos según confiabilidad (Rating Segmentation), según nivel de descuento (Category Discount), y según nivel de calificación (Category Rating).

## Visualizar las Variables Categóricas

![image](https://github.com/user-attachments/assets/56a34027-cdf4-4e74-9fd0-4c725b279d34)

![image](https://github.com/user-attachments/assets/329fcf85-1297-4a99-b5d8-b0eaeb82fcb8)

![image](https://github.com/user-attachments/assets/af1c9cac-3851-4a9b-b821-8dce2d8d3a4a)

## Aplicar Medidas de Tendencia Central

![image](https://github.com/user-attachments/assets/bf25544c-b55b-423c-8d80-977dd3605797)

![image](https://github.com/user-attachments/assets/1c9da602-b5eb-4b3c-929b-e7ccf09d49b6)


## Visualizar Distribución

![image](https://github.com/user-attachments/assets/a9f9e741-50ec-4855-b78a-64ca895826c4)


## Calcular Cuartiles, Deciles o Percentiles

![image](https://github.com/user-attachments/assets/995706ed-5d16-4828-8af3-56a7124437fe)

| Descripción          | Valor               |
|----------------------|---------------------|
| Cuartil 1            | Menor a 946.25      |
| Cuartil 2            | Menor a 3762.5      |
| Cuartil 3            | Menor a 13249.0     |
| Cuartil 4            | Mayores de 13249.0 |
| Valor Máximo         | 426973              |
| Valor Mínimo         | 0                   |
| Desviación Estándar  | 32784.90            |

## Calcular Correlación Entre Variables

```sql
SELECT
    CORR(CAST(rating AS FLOAT8), CAST(discount_percentage AS FLOAT8)) AS correlation
FROM
    amazon_unificado
```

Correlación de rating y discount percentage: 0.17


## Validar Hipótesis 

1. **Los usuarios confían más en las calificaciones que son más altas, en comparación a las calificaciones bajas.:** confiabilidad con el conteo de votos, y la categorización del rating (alto, bajo).

![image](https://github.com/user-attachments/assets/9b66698f-546c-4025-98ad-66182f91bef7)

> Esta hipotesis es verdadera, se puede obervar en el grafico que en los productos con un rating clasificado como Alto, tienen mas votos que en el de Bajo

![image](https://github.com/user-attachments/assets/252dfeda-ea32-4608-a095-d40d19affa24)

> Se exploró la correlación entre las variables rating y rating_count, obteniendo un resultado de 0.09. Esto indica que existe una correlación positiva muy débil entre ellas, lo que sugiere que no se afectan significativamente entre sí.

2. **Calificación promedio por categoría:** Diferencias significativas en la calificación promedio entre productos de distintas categorías.

![image](https://github.com/user-attachments/assets/fbb0fe1a-7211-40dc-a4e8-81ccf6448f0e)

![image](https://github.com/user-attachments/assets/6c157ba4-99a0-4573-bdf5-abd837e52668)

> Esta hipotesis es verdadera, se puede observar que para la catergoria de Home&Kitchen y Electronics estan muy parejas sin embargo para las demas catgorias si se puede ver una diferencia en rating, segun el grafico de regresión lineal, tienen una relación negatvia debil.

3. **Impacto de las imágenes en las reseñas:** Los productos con reseñas que incluyen imágenes adicionales tienden a recibir calificaciones más altas que aquellos con reseñas solo textuales.

![image](https://github.com/user-attachments/assets/f5c3ace1-770d-4b14-b68f-d3427c45c799)

> Esta hipotesis es verdadera, en las calificaciones altas hay mas imagenes en su review_content

4. **Relación entre descuento y puntuación:** A mayor descuento, mejor será la calificación del producto.

Grafica 1

![image](https://github.com/user-attachments/assets/970adb30-c5a2-4dfa-ad97-e30988a2c22a)


> Esta hipotesis es negativa, no tienen relación el porcentaje de descuento con su puntuación, esto se pudo validar a través del test de pearson con un resultado de -0.017, y en las graficas de Tableau.


5. **Descuento por categoría:** Variaciones significativas en los porcentajes de descuento entre productos de diferentes categorías.

![image](https://github.com/user-attachments/assets/100a28ba-e010-4422-86be-323a1cc9c88a)

> Esta hipotesis es verdadera, si hay diferencias significativas entre los porcentajes de descuento entre productos de diferentes categorías. La diferencia mas grande es entre Home Improvement y Office Products. Un hallazgo es que la categoria de Toys&Games no tienen descuento


## Calcular Riesgo Relativo

```sql
WITH quartiles AS (
    SELECT
        NTILE(4) OVER (ORDER BY actual_price) AS cuartil_price,
        category_rating
    FROM 
        `datalab-431915.Amazon_sales.amazon_unificado`
),
cuartiles_counts AS (
    SELECT
        cuartil_price,
        COUNT(CASE WHEN category_rating = 'Bajo' THEN 1 END) AS count_bajo,
        COUNT(CASE WHEN category_rating = 'Alto' THEN 1 END) AS count_alto
    FROM
        quartiles
    GROUP BY
        cuartil_price
),
cuartiles_sums AS (
    SELECT
        cuartil_price,
        count_bajo,
        count_alto,
        (count_bajo + count_alto) AS total_count
    FROM
        cuartiles_counts
),
cuartiles_total_sums AS (
    SELECT
        SUM(CASE WHEN cuartil_price = 1 THEN count_bajo ELSE 0 END) AS suma_cuartil_1_bajo,
        SUM(CASE WHEN cuartil_price = 1 THEN total_count ELSE 0 END) AS suma_cuartil_1_total,
        SUM(CASE WHEN cuartil_price = 2 THEN count_bajo ELSE 0 END) AS suma_cuartil_2_bajo,
        SUM(CASE WHEN cuartil_price = 2 THEN total_count ELSE 0 END) AS suma_cuartil_2_total,
        SUM(CASE WHEN cuartil_price = 3 THEN count_bajo ELSE 0 END) AS suma_cuartil_3_bajo,
        SUM(CASE WHEN cuartil_price = 3 THEN total_count ELSE 0 END) AS suma_cuartil_3_total,
        SUM(CASE WHEN cuartil_price IN (1, 3, 4) THEN count_bajo ELSE 0 END) AS suma_cuartiles_1_3_4_bajo,
        SUM(CASE WHEN cuartil_price IN (1, 3, 4) THEN total_count ELSE 0 END) AS suma_cuartiles_1_3_4_total,
        SUM(CASE WHEN cuartil_price IN (2, 3, 4) THEN count_bajo ELSE 0 END) AS suma_cuartiles_2_3_4_bajo,
        SUM(CASE WHEN cuartil_price IN (2, 3, 4) THEN total_count ELSE 0 END) AS suma_cuartiles_2_3_4_total,
        SUM(CASE WHEN cuartil_price IN (1, 2, 4) THEN count_bajo ELSE 0 END) AS suma_cuartiles_1_2_4_bajo,
        SUM(CASE WHEN cuartil_price IN (1, 2, 4) THEN total_count ELSE 0 END) AS suma_cuartiles_1_2_4_total,
        SUM(CASE WHEN cuartil_price IN (1, 2, 3) THEN count_bajo ELSE 0 END) AS suma_cuartiles_1_2_3_bajo,
        SUM(CASE WHEN cuartil_price IN (1, 2, 3) THEN total_count ELSE 0 END) AS suma_cuartiles_1_2_3_total
    FROM
        cuartiles_sums
)

-- Resultados por cuartil con cálculos adicionales
SELECT
    CASE 
        WHEN cuartil_price = 1 THEN 'Cuartil 1'
        WHEN cuartil_price = 2 THEN 'Cuartil 2'
        WHEN cuartil_price = 3 THEN 'Cuartil 3'
        WHEN cuartil_price = 4 THEN 'Cuartil 4'
    END AS cuartil_group,
    count_bajo,
    count_alto,
    total_count,
    CASE
        WHEN cuartil_price = 1 THEN
            (count_bajo / NULLIF(total_count, 0)) /
            NULLIF(
                (SELECT suma_cuartiles_2_3_4_bajo / NULLIF(suma_cuartiles_2_3_4_total, 0) FROM cuartiles_total_sums),
                0
            )
        WHEN cuartil_price = 2 THEN
            (count_bajo / NULLIF(total_count, 0)) /
            NULLIF(
                (SELECT suma_cuartiles_1_3_4_bajo / NULLIF(suma_cuartiles_1_3_4_total, 0) FROM cuartiles_total_sums),
                0
            )
        WHEN cuartil_price = 3 THEN
            (count_bajo / NULLIF(total_count, 0)) /
            NULLIF(
                (SELECT suma_cuartiles_1_2_4_bajo / NULLIF(suma_cuartiles_1_2_4_total, 0) FROM cuartiles_total_sums),
                0
            )
        WHEN cuartil_price = 4 THEN
            (count_bajo / NULLIF(total_count, 0)) /
            NULLIF(
                (SELECT suma_cuartiles_1_2_3_bajo / NULLIF(suma_cuartiles_1_2_3_total, 0) FROM cuartiles_total_sums),
                0
            )
        ELSE
            NULL
    END AS riesgo_relativo
FROM
    cuartiles_sums
JOIN
    cuartiles_total_sums
ON
    TRUE
ORDER BY
    cuartil_price;

```
> Se calculo el riesgo relativo de que fuera un rating alto o bajo de las siguientes variables:

* Actual_price
* Discount_percentage


## Aplicar Análisis por Cohorte

Hicimos cohorte de rating, de actual_price y discount_percentage


![image](https://github.com/user-attachments/assets/648bb4f3-ef82-47b6-8570-3f208b3566a5)

![image](https://github.com/user-attachments/assets/144be70a-b3e0-4f76-9de7-3217eb3712a0)

![image](https://github.com/user-attachments/assets/e7e57d48-7be3-48d5-831c-46be0ada5c33)

![image](https://github.com/user-attachments/assets/e2a0f4b2-a37b-4614-9432-4dd8cdc276a5)

![image](https://github.com/user-attachments/assets/4a9b84de-d52f-4984-89b6-cc3b3b4c0557)


## Prueba de Significancia

[Visualizar significancia](https://significancia.tiiny.site/)

## Regresión Lineal

Para este analisis se convirtio a variable numerica, las variables categoricas Rating Segmentation y General Category. Se hizo este analisis para las combinaciones:
* rating_count_complete y segmentation_rating_num
* rating y general_category_num
* rating y image_count
* rating y discount_percentage
* general_category_num y discount_percentage

![image](https://github.com/user-attachments/assets/ab28016a-ed8e-486a-b8f4-23fbbcf81c44)

![image](https://github.com/user-attachments/assets/7d535447-68b9-4886-84c2-73b1b57843e4)


## Regresión Logística

Se hizo este analisis de probabilidad para las variables:

* Discount_percentage
* Actual_price

![image](https://github.com/user-attachments/assets/f44dfaca-b59f-4999-bcd5-8eaf074a1440)

![image](https://github.com/user-attachments/assets/576232ac-83ba-43b0-8e41-e58f666e167e)


# Presentación de Resultados


## Hallazgos

1. **Toys & Games sin descuentos:** La categoría "Toys & Games" no presentó descuentos, lo que puede indicar una estrategia de precios distinta o un mercado con poca competencia en precios.

2. **Mayor descuento en Home Improvement:** La categoría "Home Improvement" mostró los mayores porcentajes de descuento, lo que sugiere una competencia más agresiva o una alta sensibilidad al precio en esta categoría.

3. **Baja correlación entre rating y rating_count:** La correlación de 0.09 entre las variables de calificación y el conteo de votos revela que los usuarios pueden estar votando independientemente de la calificación, lo que podría indicar que el conteo de votos no es un buen predictor de la calidad percibida.

4. **Revisión de productos con imágenes:** Las reseñas sin imágenes tienden a ser mejor valoradas, lo que subraya la irrelevancia de incluir imágenes en las reseñas para mejorar la percepción del producto.

5. **La mayoria de productos son calificados con un rating alto:** Lo que sugiere que los clientes estan obteniendo lo que esperan del producto.

6. **La categoria Car&Motorbikes es la que tiene el promedio de rating mas bajo:** No se espera rating alto, suponemos que es debido a que es un producto que se adquiere de manera presencialmente.

## Recomendaciones

1. **Fomentar reseñas con imágenes:** Incentivar a los usuarios a incluir imágenes en sus reseñas, ya que esto puede mejorar la percepción y calificación del producto.

2. **Estrategias de descuento dirigidas:** Continuar explorando y aplicando estrategias de descuento específicas para categorías como "Home Improvement", donde parece haber una alta sensibilidad al precio.

3. **Análisis de mercado para Toys & Games:** Investigar más a fondo la categoría "Toys & Games" para entender por qué no se aplican descuentos y si esta estrategia es la más efectiva en términos de ventas y percepción del valor.

4. **Mejorar la relación entre votos y calificación:** Investigar cómo mejorar la relación entre el número de votos y la calificación, tal vez mediante el uso de incentivos para motivar a los usuarios a calificar los productos.

5. **Monitorear y ajustar la estrategia de calificación:** Implementar un seguimiento continuo de las calificaciones y los votos recibidos para identificar patrones y ajustar estrategias de marketing y ventas en consecuencia.

6. **Cantidad de unidades en inventario:** Se recomienda incorporar la variable de unidades por producto y la cantidad de unidades vendidas para llevar un control más detallado y realizar un seguimiento efectivo de la popularidad de los productos en términos de ventas. Además, se observa que cada producto cuenta con 8 calificaciones, pero no se dispone de datos adicionales que permitan realizar comparaciones significativas. Incluir estas variables proporcionaría una visión más completa del rendimiento de cada producto y facilitaría un análisis más profundo de su éxito en el mercado.


## Conclusiones

1. **Confiabilidad en calificaciones altas:** Los usuarios tienden a confiar más en las calificaciones altas, lo que se refleja en un mayor número de votos para productos con una calificación clasificada como "Alta".

2. **Diferencias entre categorías:** No se encontraron diferencias significativas en las calificaciones promedio entre productos de distintas categorías generales, lo que sugiere que la categoría no influye considerablemente en la percepción del usuario sobre la calidad del producto.

3. **Impacto de las imágenes en las reseñas:** Los productos con reseñas que incluyen imágenes adicionales tienden a recibir calificaciones más bajas, lo que cuestiona la importancia de la representación visual en la percepción del producto.

4. **Relación entre descuento y calificación:** No se identificó una correlación significativa entre el porcentaje de descuento y la calificación del producto, lo que indica que los usuarios no asocian necesariamente un descuento con una mayor calidad o satisfacción.

5. **Descuento por categoría:** Se observaron variaciones significativas en los porcentajes de descuento entre diferentes categorías de productos, lo que podría reflejar estrategias de precios diferenciadas según el tipo de producto.

6. **Outliers excluidos para evitar sesgos:** Los datos atípicos (outliers) fueron excluidos del análisis final, lo que contribuyó a evitar sesgos en los resultados y a asegurar una mayor precisión en las conclusiones.

7. **Calificaciones y número de votos:** La débil correlación entre la calificación y el número de votos sugiere que estos factores no se afectan significativamente entre sí, lo que indica que otros elementos podrían estar influyendo en la cantidad de votos que recibe un producto.

8. **Relación entre descuento y probabilidad de rating bajo:** El análisis de riesgo relativo y la regresión logística muestran que un mayor descuento en los productos tiende a asociarse con una mayor probabilidad de obtener una calificación baja.

9. **Relación entre precio y calificación:** Se observa que los productos con precios más altos tienden a recibir mejores calificaciones, lo que indica una preferencia por parte de los usuarios hacia productos más costosos.


## Enlaces de interes

| Analista | Video Loom | Dashboard | Exploratorio en Python | Presentación |
|----------|------------|-----------|------------------------|--------------|
| Osiris Berbesia | Enlace 1  | [Dashboard](https://public.tableau.com/app/profile/osiris.berbesia/viz/DashboardAmazonIndia/Dashboard1?publish=yes)  | Enlace 3               | Enlace 4     |
| Karen Fonseca | Enlace 5  | [Dashboard](https://public.tableau.com/app/profile/karen.fonseca6131/viz/Datalab_17247833763220/Dashboard1?publish=yes)  | [Google Colab](https://colab.research.google.com/drive/1xuTFoIijZUMkFRIfq1gIdGF2jkDPqiPI?usp=sharing)              | Enlace 8     |
