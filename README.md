# Proyecto 4 - DataLab
## Amazon Sales

## Integrantes:
* [Berbesia Osiris](https://github.com/osirisberbesia/)
* [Fonseca Karen](https://github.com/Karenfonseca22)

# Hipótesis del caso

1. **Los usuarios confían más en las calificaciones que son más altas, en comparación a las calificaciones bajas.:** La relación entre la fiabilidad de las calificaciones y el número de votos.
2. **Calificación promedio por categoría:** Diferencias significativas en la calificación promedio entre productos de distintas categorías.
3. **Impacto de las imágenes en las reseñas:** Los productos con reseñas que incluyen imágenes adicionales tienden a recibir calificaciones más altas que aquellos con reseñas solo textuales.
4. **Relación entre descuento y puntuación:** A mayor descuento, mejor será la calificación del producto.
5. **Descuento por categoría:** Variaciones significativas en los porcentajes de descuento entre productos de diferentes categorías.


# Conjunto de datos a analizar

## Datos de Amazon Reviews.

### Nulos

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

### Duplicados


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


## Datos de Amazon Products.

### Nulos
* Consulta para la data: [Productos](SQL\nulos_indentificar_products.sql)
---


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

### Duplicados


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


# Creación de nuevas variables

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

## Cambio de tipo de dato

Para la variable 'rating' se cambio de STRING a FLOAT64, con la función CAST

# Identificar y manejar datos discrepantes

En la variable 'rating' se encontro un dato con el simbolo '|', este campo se reemplazo con el numero 0

# Manejo de outliers para tabla amazon_review

Boxplot de variable reviews_content (Variable que me cuenta los review_id)

![image](https://github.com/user-attachments/assets/4ccce97e-899d-4062-a8ac-e43395451669)

Boxplot de variable rating (Variable con su calificación)

![rating box](https://github.com/user-attachments/assets/76be8013-ae64-41d1-9cf8-6410af8ec2f9)

Boxplot de variable rating_count (conteo de personas que votaron por su calificación)

![rating_count boxplot](https://github.com/user-attachments/assets/66d62105-cf05-4875-9b7d-a47d1cfbffa7)

# Manejo de outliers para tabla amazon_product

Boxplot de variable discounted_price







