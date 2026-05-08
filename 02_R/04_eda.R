
# Tabla EDA  ---------------------------------------------------------------
# EDA = EXPLORATORY DTA ANALYSIS

eda_table <- data_clean %>%
  pivot_longer(
    cols = `2003`:`2019`,
    names_to = "Year",
    values_to = "Value"
  ) %>%
  group_by(`Series Name`) %>%
  summarise(
    observaciones = n(),
    promedio = mean(Value, na.rm = TRUE),
    mediana = median(Value, na.rm = TRUE),
    minimo = min(Value, na.rm = TRUE),
    maximo = max(Value, na.rm = TRUE),
    desviacion = sd(Value, na.rm = TRUE),
    .groups = "drop"
  )
