# =====================================================
# 00_setup.R
# Configuración inicial del proyecto
# =====================================================

# Crear estructura de carpetas del proyecto
folders <- c(
  "00_docs",
  "01_data/01_raw",
  "01_data/02_interim",
  "01_data/03_processed",
  "02_scripts",
  "03_R",
  "04_output/01_tables",
  "04_output/02_figures",
  "04_output/03_reports",
  "05_logs"
)

invisible(lapply(folders, 
                 dir.create, 
                 recursive = TRUE, 
                 showWarnings = FALSE))
