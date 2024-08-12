# Proyecto 4 - DataLab
## Amazon Sales

 [![HitCount](https://hits.dwyl.com/osirisberbesia/4DataLab.svg?style=flat-square)](http://hits.dwyl.com/osirisberbesia/4DataLab)

## Integrantes:
* [Berbesia Osiris](https://github.com/osirisberbesia/)
* [Fonseca Karen](https://github.com/Karenfonseca22)

# Hipótesis del caso

1. **Fiabilidad de la calificación según los votos:** La relación entre la fiabilidad de las calificaciones y el número de votos.
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


