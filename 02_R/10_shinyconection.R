
# Conexión a shinyapps.io -------------------------------------------------

# Recordar token aqui, por resguardo se acciona directamente en consola
# y después se ejecuta el siguiente script.

# la parte de github pages debe lanzarse con el repo en modo público,
# en modo privado no funciona para deploy y poder mostrarlo.

rsconnect::deployApp(
  appDir = ".",
  appFiles = c(
    "02_R/08_Dashboard.R",
    "03_outputs/04_datasource/data_conosur.rds",
    "03_outputs/04_datasource/tabla_conosur_resumen.rds"
  ),
  appPrimaryDoc = "02_R/08_Dashboard.R",
  appName = "proyecto-banco-mundial-dashboard"
)

# se actualiza el token para uso del dashboard.