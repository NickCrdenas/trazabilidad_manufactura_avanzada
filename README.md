# trazabilidad_manufactura_avanzada
Proyecto de tesis: Arquitectura integral de trazabilidad técnico-económica en manufactura avanzada.
# Arquitectura de Trazabilidad Técnico-Económica (Industria 4.0)

Este proyecto forma parte de mi tesis de Ingeniería Mecatrónica en la UMSNH. 
El objetivo es resolver la fragmentación de datos en plantas industriales mediante una arquitectura en PostgreSQL que vincula variables técnicas (sensores, energía) con costos financieros.

##  Tecnologías
- **Base de Datos:** PostgreSQL 16
- **Lógica de Negocio:** SQL / Python
- **Visualización:** Power BI (vía DirectQuery)

##  Estructura del Proyecto
- `sql/`: Scripts de creación de base de datos y vistas de costos reales.
- `python/`: (En desarrollo) Simulador de datos de sensores para tiempo real.

## Enfoque GRC (Governance, Risk & Compliance)
A diferencia de un modelo técnico estándar, esta arquitectura incluye dimensiones de **Cumplimiento Normativo (NOM-STPS)** y **Gestión de Riesgos Legales**, integrando mi formación dual en Ingeniería y Derecho.

Componentes del Sistema
- **Backend:** PostgreSQL para el almacenamiento persistente y normalizado.
- **Simulación:** Script en Python que genera telemetría industrial (sensores y energía) en tiempo real.
- **Frontend Operativo:** Dashboard interactivo en **Streamlit** para visualización inmediata de KPIs en planta.
- **Análisis Estratégico:** Reportes en Power BI para el cálculo del Costo Real por Pieza.
