
# Conexión a shinyapps.io -------------------------------------------------

rsconnect::setAccountInfo(name='dbigggg',
                          token='45B5AF9C9D27422C0B7F7428FED876BA',
                          secret='zf7AETeQBWRH/AeyhrrUWTVpU6Q7F6TzRomGvXEZ')

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