import psycopg2
import random
from datetime import datetime
import schedule
import time

def insertar_datos():
    conn = psycopg2.connect(
        host="localhost",
        database="tesis_manufactura",       # <- cambia por el nombre de tu DB
        user="postgres",        # <- cambia por tu usuario
        password="tu contraceña"  # <- cambia por tu contraseña
    )
    cur = conn.cursor()

    # Datos aleatorios
    id_orden = random.randint(1, 10)
    id_maquina = random.randint(1, 5)
    id_operador = random.randint(1, 4)
    tiempo_operacion_horas = round(random.uniform(1, 8), 2)
    energia_kwh = round(random.uniform(20, 60), 2)
    costo_kwh = 2.5
    sensor_vibracion = round(random.uniform(0.01, 0.05), 3)
    sensor_temperatura = random.randint(55, 75)

    # Insertar registro
    cur.execute("""
        INSERT INTO manufactura.registro_proceso
        (id_orden, id_maquina, id_operador, tiempo_operacion_horas, energia_kwh, costo_kwh, sensor_vibracion, sensor_temperatura)
        VALUES (%s,%s,%s,%s,%s,%s,%s,%s)
    """, (id_orden, id_maquina, id_operador, tiempo_operacion_horas, energia_kwh, costo_kwh, sensor_vibracion, sensor_temperatura))

    conn.commit()
    cur.close()
    conn.close()
    print(f"Registro insertado {datetime.now()}")

# Ejecutar cada minuto
schedule.every(1).minutes.do(insertar_datos)

while True:
    schedule.run_pending()
    time.sleep(5)