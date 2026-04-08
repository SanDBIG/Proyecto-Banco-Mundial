# =====================================================
# 1. CARGA DE LIBRERIAS
# =====================================================

install.packages("pacman")
install.packages("renv") #para manejar reproducibilidad

# Cargar librerías
pacman::p_load(
  tidyverse,   # Manipulación y visualización (dplyr, ggplot2, etc.)
  janitor,     # Limpieza de nombres y tablas
  skimr,       # Exploración rápida de datos
  lubridate,   # Manejo de fechas
  readxl,      # Importar Excel
  writexl,     # Exportar Excel
  data.table,  # Manipulación rápida de grandes datasets
  scales,      # Escalas para gráficos
  patchwork,   # Combinar gráficos ggplot
  ggthemes,     # Temas adicionales para gráficos
  renv         # libreria que documenta versiones de librerias 
)



# 2. REPRODUCIBILIDAD -----------------------------------------------------

renv::init() #Inicializar el entorno con librerias y variables.

# Más info: https://posit.co/blog/renv-project-environments-for-r/

renv::snapshot() #Este comando guarda versiones de librerias usadas y crea
# el archivo renv.lock
