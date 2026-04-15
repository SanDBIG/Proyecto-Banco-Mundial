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


# Tabla EDA ---------------------------------------------------------------

eda_table <- data_clean %>%
  summarise(
    observaciones = n(),
    promedio = mean(Value,na.rm = TRUE),
    mediana = median(Value,na.rm = TRUE),
    minimo = min(Value,na.rm = TRUE),
    maximo = max(Value,na.rm = TRUE),
    desviacion = sd(Value,na.rm = TRUE)
  )

print(eda_table)
