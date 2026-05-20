# Instalacion base librerias ----------------------------------------------

if (!requireNamespace("pacman", quietly = TRUE)) {
  install.packages("pacman")
}

# Cargar librerias --------------------------------------------------------

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
  renv,         # libreria que documenta versiones de librerias 
  shiny, # creacion de aplicaciones interactivas/dashboard
  DT, # crea tablas navegables
  renv, # para manejar reproducibilidad
  rsconnect # esto es para conectar a los servicios de shiny
)
