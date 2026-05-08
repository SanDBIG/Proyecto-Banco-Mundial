
# 2. REPRODUCIBILIDAD -----------------------------------------------------

renv::init() #Inicializar el entorno con librerias y variables.

# Más info: https://posit.co/blog/renv-project-environments-for-r/

renv::snapshot() #Este comando guarda versiones de librerias usadas y crea
# el archivo renv.lock
