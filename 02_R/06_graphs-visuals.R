
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

# Filtrar variables de interes, usaremos 2 para tablas y graficos comparados

data_conosur <- data_conosur %>% 
  filter(`Series Name` %in% c("Dealing with construction permits: Time (days)",
                              "Starting a business - Score"))

check_conosur <- data_conosur %>%
  distinct(`Country Name`, `Series Name`) %>%
  group_by(`Series Name`) %>%
  summarise(
    n_paises = n_distinct(`Country Name`),
    paises = paste(sort(unique(`Country Name`)), collapse = ", "),
    .groups = "drop"
  )

tabla_conosur_resumen <- data_conosur %>%
  filter(!is.na(Value)) %>%
  group_by(`Country Name`, `Series Name`) %>%
  summarise(
    anios_con_dato = n_distinct(Year),
    primer_anio = min(Year),
    ultimo_anio = max(Year),
    valor_inicial = Value[which.min(Year)],
    valor_final = Value[which.max(Year)],
    variacion_abs = valor_final - valor_inicial,
    promedio = mean(Value),
    minimo = min(Value),
    maximo = max(Value),
    .groups = "drop"
  )


# Exportar Tabla ----------------------------------------------------------

write_csv(
  tabla_conosur_resumen,
  "03_outputs/01_tables/tabla_conosur_resumen.csv"
)


# Graficos ----------------------------------------------------------------

# Serie temporal

grafico_conosur <- data_conosur %>%
  ggplot(aes(
    x = Year,
    y = Value,
    color = `Country Name`,
    group = `Country Name`
  )) +
  geom_line(linewidth = 0.9, na.rm = TRUE) +
  geom_point(size = 1.8, na.rm = TRUE) +
  geom_text(
    aes(label = round(Value, 1)),
    size = 3,
    vjust = -0.8,
    na.rm = TRUE,
    show.legend = FALSE
  ) +
  facet_wrap(~ `Series Name`, scales = "free_y") +
  scale_x_continuous(breaks = seq(2003, 2019, 2)) +
  labs(
    title = "Evolución de indicadores en países del Cono Sur",
    subtitle = "Chile, Argentina y Uruguay, 2003-2019",
    x = "Año",
    y = "Valor",
    color = "País",
    caption = "Fuente: elaboración propia a partir de datos del Banco Mundial"
  ) +
  theme_minimal()


grafico_conosur


# Exportar grafico --------------------------------------------------------

ggsave(
  filename = "03_outputs/02_figures/grafico_conosur_serie_temporal.png",
  plot = grafico_conosur,
  width = 12,
  height = 7,
  dpi = 300,
  bg = "white"
)

# EXPORTAR OBJETOS PARA DASHBOARD --------------------------------------------

saveRDS(
  data_conosur,
  file = "03_outputs/04_datasource/data_conosur.rds"
)

saveRDS(
  tabla_conosur_resumen,
  file = "03_outputs/04_datasource/tabla_conosur_resumen.rds"
)




