
# DATA LIMPIA -------------------------------------------------------------

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

# str(data_clean) #Estructura de variables del objeto
# sapply(data_clean, class) # tipos de variables(funciona mejor)
# glimpse(data_clean) #Tipos de variables, más detallado
# colSums(is.na(data_clean)) #cantidad de valores por columna


# REVISIONES ADICIONALES PARA OBJETO}--------------------------------------

# sum(is.na(data_clean)) #detección de NA
# sapply(data_clean, is.numeric) #Detectar si las columnas son númericas (Boleano)
# lapply(data_clean, unique) #revisión de valores unicos por columna
# unique(data_clean$`Country Name`) #Revisión de valores unicos por columna
# summary(data_clean) #Detalles por columna
# table(sapply(data_clean, class)) # Conteo de tipos de variables



# AJUSTES TIPOS DE VARIABLES ----------------------------------------------

# Dada las revisiones de tipos de datos, se comprueba que las columnas de anios
# vienen con formato character, estas deben setearse en formato numeric para
# construir el dashboard.


data_clean <- data_clean %>%
  mutate(across(
    matches("^\\d{4}$"),
    as.numeric
  ))

#sapply(data_clean, class) #Comprobar si fueron transformadas


# Transformación de nombres de paises -------------------------------------

# TRANSFORMACIÓN DE NOMBRES DE PAÍSES -----------------------------------------

data_clean <- data_clean %>%
  mutate(
    `Country Name` = case_when(
      `Country Name` == "Antigua and Barbuda" ~ "Antigua_and_Barbuda",
      `Country Name` == "Bahamas, The" ~ "Bahamas_The",
      `Country Name` == "Bosnia and Herzegovina" ~ "Bosnia_and_Herzegovina",
      `Country Name` == "Brunei Darussalam" ~ "Brunei_Darussalam",
      `Country Name` == "Burkina Faso" ~ "Burkina_Faso",
      `Country Name` == "Central African Republic" ~ "Central_African_Republic",
      `Country Name` == "Congo, Dem. Rep." ~ "Congo_Dem_Rep",
      `Country Name` == "Congo, Rep." ~ "Congo_Rep",
      `Country Name` == "Costa Rica" ~ "Costa_Rica",
      `Country Name` == "C\xf4te d'Ivoire" ~ "Cote_d_Ivoire",
      `Country Name` == "Czech Republic" ~ "Czech_Republic",
      `Country Name` == "Dominican Republic" ~ "Dominican_Republic",
      `Country Name` == "Egypt, Arab Rep." ~ "Egypt_Arab_Rep",
      `Country Name` == "El Salvador" ~ "El_Salvador",
      `Country Name` == "Equatorial Guinea" ~ "Equatorial_Guinea",
      `Country Name` == "Gambia, The" ~ "Gambia_The",
      `Country Name` == "Guinea-Bissau" ~ "Guinea_Bissau",
      `Country Name` == "Iran, Islamic Rep." ~ "Iran_Islamic_Rep",
      `Country Name` == "Korea, Rep." ~ "Korea_Rep",
      `Country Name` == "Kyrgyz Republic" ~ "Kyrgyz_Republic",
      `Country Name` == "Lao PDR" ~ "Lao_PDR",
      `Country Name` == "Marshall Islands" ~ "Marshall_Islands",
      `Country Name` == "Micronesia, Fed. Sts." ~ "Micronesia_Fed_Sts",
      `Country Name` == "New Zealand" ~ "New_Zealand",
      `Country Name` == "North Macedonia" ~ "North_Macedonia",
      `Country Name` == "Papua New Guinea" ~ "Papua_New_Guinea",
      `Country Name` == "Puerto Rico" ~ "Puerto_Rico",
      `Country Name` == "Russian Federation" ~ "Russian_Federation",
      `Country Name` == "San Marino" ~ "San_Marino",
      `Country Name` == "S\xe3o Tom\xe9 and Principe" ~ "Sao_Tome_and_Principe",
      `Country Name` == "Saudi Arabia" ~ "Saudi_Arabia",
      `Country Name` == "Sierra Leone" ~ "Sierra_Leone",
      `Country Name` == "Slovak Republic" ~ "Slovak_Republic",
      `Country Name` == "Solomon Islands" ~ "Solomon_Islands",
      `Country Name` == "South Africa" ~ "South_Africa",
      `Country Name` == "South Sudan" ~ "South_Sudan",
      `Country Name` == "Sri Lanka" ~ "Sri_Lanka",
      `Country Name` == "St. Kitts and Nevis" ~ "St_Kitts_and_Nevis",
      `Country Name` == "St. Lucia" ~ "St_Lucia",
      `Country Name` == "St. Vincent and the Grenadines" ~ "St_Vincent_and_the_Grenadines",
      `Country Name` == "Syrian Arab Republic" ~ "Syrian_Arab_Republic",
      `Country Name` == "Taiwan, China" ~ "Taiwan_China",
      `Country Name` == "Timor-Leste" ~ "Timor_Leste",
      `Country Name` == "Trinidad and Tobago" ~ "Trinidad_and_Tobago",
      `Country Name` == "United Arab Emirates" ~ "United_Arab_Emirates",
      `Country Name` == "United Kingdom" ~ "United_Kingdom",
      `Country Name` == "United States" ~ "United_States",
      `Country Name` == "Venezuela, RB" ~ "Venezuela_RB",
      `Country Name` == "West Bank and Gaza" ~ "West_Bank_and_Gaza",
      `Country Name` == "Yemen, Rep." ~ "Yemen_Rep",
      
      `Country Name` == "Hong Kong, China" ~ "Hong_Kong_China",
      `Country Name` == "Los Angeles" ~ "Los_Angeles",
      `Country Name` == "Mexico City" ~ "Mexico_City",
      `Country Name` == "New York" ~ "New_York",
      `Country Name` == "Rio de Janeiro" ~ "Rio_de_Janeiro",
      `Country Name` == "Sao Paulo" ~ "Sao_Paulo",
      `Country Name` == "St. Petersburg" ~ "St_Petersburg",
      
      TRUE ~ `Country Name`
    )
  )

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

data_clean_long <- data_clean %>% 
  pivot_longer(
    cols = matches("^\\d{4}$"),
    names_to = "Year",
    values_to = "Value"
  ) %>% 
  mutate(
    Year = as.numeric(Year)
  )

# glimpse(data_clean) #Verificacion
# sapply(data_clean, class) #Verificacion

