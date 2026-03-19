# ==========================================
# EDA simple - Una variable de Chile
# ==========================================

# 1 cargar datos
data_raw <- read_csv("01_data/01_raw/5567436c-13eb-4381-8d4c-d6439b957b80_Data.csv")

# 1.1 visualizar estructura data
view(data_raw)
head(data_raw)
tail(data_raw)
str(data_raw)
summary(data_raw)
dim(data_raw)
names(data_raw)
unique(data_raw["Country Name"])

# 2 filtrar Chile
chile <- data_raw %>%
  filter(`Country Name` == "Chile")

# 3 pasar a formato largo
chile_long <- chile %>%
  pivot_longer(
    cols = starts_with("20"),
    names_to = "year",
    values_to = "value"
  )

# 4 elegir una variable real del dataset
variable <- unique(chile_long$`Series Name`)[1]

# 4.1

view(chile_long)
view(chile)
view(variable)

# 5 filtrar variable
biz_time <- chile_long %>%
  filter(`Series Name` == variable) %>%
  mutate(
    value = na_if(value, ".."),
    value = as.numeric(value),
    year = as.numeric(substr(year,1,4))
  ) %>%
  drop_na(value)

# 5.1 ver construcción de biz time
view(biz_time)

# 6 tabla EDA
eda_table <- biz_time %>%
  summarise(
    observaciones = n(),
    promedio = mean(value),
    mediana = median(value),
    minimo = min(value),
    maximo = max(value),
    desviacion = sd(value)
  )

print(eda_table)

# 7 tabla evolución temporal
ggplot(biz_time, aes(year, value)) +
  
  geom_line(color = "#1f78b4", linewidth = 1.5) +
  
  geom_point(
    size = 3,
    color = "#1f78b4"
  ) +
  
  geom_text(
    aes(label = value),
    vjust = -1,
    size = 4
  ) +
  
geom_vline(
    xintercept = 2011,
    linetype = "dashed",
    color = "red",
    alpha = 0.6
  ) +
  
  theme_minimal(base_size = 14) +
  
  scale_x_continuous(breaks = seq(min(biz_time$year), max(biz_time$year), 1)) +
  
  labs(
    title = "Calidad regulatoria en permisos de construcción",
    subtitle = "Chile — Doing Business (Banco Mundial)",
    x = "Año",
    y = "Score (0-100)",
    caption = "Salto en 2011 asociado a cambios regulatorios/metodológicos"
  )
