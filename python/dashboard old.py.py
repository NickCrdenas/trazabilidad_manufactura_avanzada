import streamlit as st
import pandas as pd
import psycopg2
import plotly.express as px
import time

st.title("Dashboard Manufactura en Tiempo Real")

# Conexión a PostgreSQL
conn = psycopg2.connect(
    host="localhost",
    database="tesis_manufactura",       # <- cambia por tu DB
    user="postgres",        # <- cambia por tu usuario
    password="tu contraceña"  # <- cambia por tu contraseña
)

# Loop para actualización automática
placeholder = st.empty()

while True:
    df = pd.read_sql("""
        SELECT rp.id_registro, op.fecha_inicio, c.nombre AS cliente, m.nombre AS maquina,
               rp.tiempo_operacion_horas, rp.energia_kwh
        FROM manufactura.registro_proceso rp
        JOIN manufactura.orden_produccion op ON rp.id_orden = op.id_orden
        JOIN manufactura.cliente c ON op.id_cliente = c.id_cliente
        JOIN manufactura.maquina m ON rp.id_maquina = m.id_maquina
        ORDER BY rp.id_registro DESC
    """, conn)

    fig1 = px.line(df, x='fecha_inicio', y='tiempo_operacion_horas', color='cliente', title="Tiempo de operación por cliente")
    fig2 = px.line(df, x='fecha_inicio', y='energia_kwh', color='maquina', title="Consumo de energía por máquina")

    with placeholder.container():
        st.plotly_chart(fig1, use_container_width=True)
        st.plotly_chart(fig2, use_container_width=True)

    time.sleep(60)