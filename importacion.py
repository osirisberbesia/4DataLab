import pandas as pd
import os

def generate_sql_from_csv(csv_file_path, table_name):
    # Leer el archivo CSV usando pandas
    df = pd.read_csv(csv_file_path)

    # Generar la sentencia CREATE TABLE
    columns = df.columns
    create_table_query = f'CREATE TABLE {table_name} (\n'
    
    for column in columns:
        dtype = df[column].dtype
        if dtype == 'int64':
            column_type = 'INTEGER'
        elif dtype == 'float64':
            column_type = 'FLOAT'
        elif dtype == 'datetime64[ns]':
            column_type = 'TIMESTAMP'
        else:
            column_type = 'TEXT'
        create_table_query += f'    {column} {column_type},\n'
    
    # Quitar la última coma y agregar el paréntesis final
    create_table_query = create_table_query.rstrip(',\n') + '\n);'

    # Generar las sentencias INSERT INTO
    insert_queries = []
    for _, row in df.iterrows():
        values = ', '.join([f"'{str(value).replace('\'', '\'\'')}'" if pd.notna(value) else 'NULL' for value in row])
        insert_query = f'INSERT INTO {table_name} ({", ".join(columns)}) VALUES ({values});'
        insert_queries.append(insert_query)

    return create_table_query, insert_queries

def save_sql_to_file(csv_file_path, create_table_query, insert_queries):
    # Extraer el nombre del archivo sin la extensión
    base_path = os.path.dirname(csv_file_path)
    file_name = os.path.basename(csv_file_path)
    table_name = 'tabla_' + os.path.splitext(file_name)[0].replace(' ', '_')
    output_file_path = os.path.join(base_path, f'{table_name}_queries.sql')

    # Guardar el código SQL en un archivo con codificación utf-8
    with open(output_file_path, 'w', encoding='utf-8') as file:
        # Escribir solo las consultas SQL sin encabezados
        file.write(create_table_query + '\n\n')
        for query in insert_queries:
            file.write(query + '\n')

    print(f"SQL queries have been saved to {output_file_path}")

def main():
    # Ruta al archivo CSV
    csv_file_path = 'C:/Users/Oberb/OneDrive/Documentos/Laboratoria/4DataLab/amazon_review.csv'  # Reemplaza con la ruta a tu archivo CSV

    # Extraer el nombre de la tabla del archivo CSV
    file_name = os.path.basename(csv_file_path)
    table_name = 'tabla_' + os.path.splitext(file_name)[0].replace(' ', '_')

    create_table_query, insert_queries = generate_sql_from_csv(csv_file_path, table_name)
    save_sql_to_file(csv_file_path, create_table_query, insert_queries)

if __name__ == '__main__':
    main()
