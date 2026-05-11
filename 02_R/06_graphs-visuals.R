
# Se toman los anios con >80 cobertura ------------------------------------

umbral_anios <- ceiling(0.80 * length(2003:2019))


# Cobertura por país e indicador ---------------------------------------------

cobertura_pais_indicador <- data_clean_long %>%
  filter(Year >= 2003, Year <= 2019) %>%
  group_by(`Country Name`, 
           `Country Code`, 
           `Series Name`, 
           `Series Code`) %>%
  summarise(anios_con_dato = n_distinct(Year[!is.na(Value)]),
    cobertura = anios_con_dato / length(2003:2019),
    .groups = "drop"
  )


# Filtrar país-indicador con cobertura >= 80% --------------------------------

data_80cob <- data_clean_long %>%
  filter(Year >= 2003, Year <= 2019) %>%
  group_by(`Country Name`, 
           `Country Code`, 
           `Series Name`, 
           `Series Code`) %>%
  mutate(
    anios_con_dato = n_distinct(Year[!is.na(Value)]),
    cobertura = anios_con_dato / length(2003:2019)
  ) %>%
  filter(anios_con_dato >= ceiling(0.80 * length(2003:2019))) %>%
  ungroup()

# unique(data_80cob$`Country Name`)


# Tablas ------------------------------------------------------------------
# Paises del cono sur

data_conosur <- data_80cob %>%
  filter(`Country Name` %in% c("Chile", "Argentina", "Uruguay"))



# Graficos ----------------------------------------------------------------

