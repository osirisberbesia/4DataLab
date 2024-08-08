# Proyecto 4 - DataLab
## Amazon Sales

### Integrantes:
* [Berbesia Osiris](https://github.com/osirisberbesia/)
* [Fonseca Karen](https://github.com/Karenfonseca22)

### Conjunto de datos a analizar

Datos de Amazon Reviews.
Datos de Amazon Products.

### Identificación de nulos:
---
###

* [Reviews](SQL\nulos_indentificar_review.sql)

#### Nulos

| Variable | Nulos | Acción |
|-|-|-|
| user_id| 0 | |
| user_name| 0 | |
| review_id| 0 | |
| review_title| 0 | |
| review_content| 0 | |
| img_link| 466 |  Se cambia el link a about:blank |
| product_link| 466 | Se cambia el link a about:blank |
| product_id| 0 | |
| rating| 0 | |
| rating_count| 2 ||
||||
###
---
###

* [Productos](SQL\nulos_indentificar_products.sql)


#### Nulos
| Variable | Nulos| Acción |
|-|-|-|
| product_id |  0 | | 
| product_name |  0 | | 
| category |  0 | | 
| discounted_price |  0 | | 
| actual_price |  0 | | 
| discount_percentage |  0 | | 
| about_product | 4 | Sustituir a una cadena que contenga "Sin descripción"
||||
###


### Identificación de duplicados:
---
###

* [Productos duplicados (conteo)](SQL\duplicados_product_conteo.sql)


#### Duplicados
| Variable | Nulos| Acción |
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

Usando [esta](SQL\duplicados_product_conteo.sql) query.

Dando como resultado, que tenemos 16 datos que atender. Sin embargo, se decide dejar estos datos a pesar de estar duplicados, porque no tenemos la foto para corroborar si cambia en color o estilo, a pesar de tener las mismas características.


###

* [Reviews duplicadas (conteo)](SQL\duplicados_review_conteo.sql)


#### Duplicados
| Variable | Nulos| Acción |
|-|-|-|
| user_id |  271 | Ninguna acción. Esta variable puede tener duplicados |
| user_name |  271 | Ninguna acción. Esta variable puede tener duplicados |
| review_id |  271 |
| review_title |  271 | Ninguna acción. Esta variable puede tener duplicados |
| review_content | 253 | Ninguna acción. Esta variable puede tener duplicados |
| img_link |  514 | Ninguna acción. Esta variable puede tener duplicados |
| product_link |  465 | Ninguna acción. Esta variable puede tener duplicados |
| product_id |  114 | Ninguna acción. Esta variable puede tener duplicados |
| rating |  1439 | Ninguna acción. Esta variable puede tener duplicados |
| rating_count |  321 | Ninguna acción. Esta variable puede tener duplicados |
