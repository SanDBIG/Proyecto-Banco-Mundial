
# Primeros 94 -------------------------------------------------------------












# Ultimos 94 --------------------------------------------------------------


data_clean <- data_raw %>%
  slice(1:(n() - 5)) %>%  # eliminar últimas 5 filas
  rename_with(
    ~ str_extract(.x, "\\d{4}"), 
    matches("^\\d{4}")
  ) %>%                   # dejar solo el año como nombre de columna
  mutate(across(
    everything(),
    ~ na_if(.x, "..")
  ))


# REVISIÓN RECOMENDADA PARA OBJETOS ---------------------------------------

str(data_clean) #Estructura de variables del objeto
sapply(data_clean, class) # tipos de variables(funciona mejor)
glimpse(data_clean) #Tipos de variables, más detallado
colSums(is.na(data_clean)) #cantidad de valores por columna


# REVISIONES ADICIONALES PARA OBJETO}--------------------------------------

sum(is.na(data_clean)) #detección de NA
sapply(data_clean, is.numeric) #Detectar si las columnas son númericas (Boleano)
lapply(data_clean, unique) #revisión de valores unicos por columna
unique(data_clean$`Country Name`) #Revisión de valores unicos por columna
summary(data_clean) #Detalles por columna
table(sapply(data_clean, class)) # Conteo de tipos de variables



# AJUSTES TIPOS DE VARIABLES ----------------------------------------------

# Dada las revisiones de tipos de datos, se comprueba que las columnas de anios
# vienen con formato character, estas deben setearse en formato numeric para
# construir el dashboard.


data_clean <- data_clean %>%
  mutate(across(
    matches("^\\d{4}$"),
    as.numeric
  ))

sapply(data_clean, class) #Comprobar si fueron transformadas


# NOTA TÉCNICA ------------------------------------------------------------

# Para construir dashboards los datos deben ir en formato long, esto para que los
# filtros dinamicos puedan funcionar de forma correcta, además de poder operar
# con funciones más complejas para poder gráficar tal como ggplot e incluso
# programas como powerbi, tableau, etc.

# Dado lo anterior, debemos pasar los años a formato long, osea hacia abajo.
# Ya que el CSV muestra en formato wide los datos, un criterio básico es ver
# hacia donde están apilados los anios, si es hacia la derecha es wide, si son 
# hacia abajo es long.


# TRANSFORMAR A LONG ------------------------------------------------------

data_clean <- data_clean %>% 
  pivot_longer(
    cols = matches("^\\d{4}$"),
    names_to = "Year",
    values_to = "Value"
  ) %>% 
  mutate(
    Year = as.numeric(Year)
  )

glimpse(data_clean) #Verificacion
sapply(data_clean, class) #Verificacion

