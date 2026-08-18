# Visualización de indicadores informe Doing Business - Banco Mundial

## Presentación

Este proyecto realiza un análisis descriptivo de indicadores del proyecto Doing Business del Banco Mundial para Chile, Argentina y Uruguay entre los años 2003 y 2019.

El objetivo principal es construir visualizaciones comparadas sobre indicadores asociados a la facilidad para hacer negocios en países del Cono Sur. El proyecto utiliza datos históricos del Banco Mundial, los procesa en R y genera tablas, gráficos y un dashboard interactivo para explorar la evolución de los indicadores seleccionados.

## Accesos del proyecto

El proyecto cuenta con dos accesos principales: un dashboard interactivo actualmente disponible y un informe web que será completado en futuras actualizaciones.

| Recurso               | Descripción                                                                 | Estado        | Enlace                                                                            |
| --------------------- | --------------------------------------------------------------------------- | ------------- | --------------------------------------------------------------------------------- |
| Dashboard interactivo | Aplicación en Shiny para explorar países, años e indicadores seleccionados. | Disponible    | [Abrir dashboard](https://diturrietag.shinyapps.io/proyecto-banco-mundial-dashboard/) |
| Informe web           | Informe reproducible del proyecto, publicado mediante GitHub Pages.         | Disponible | [Ver informe](https://sandbig.github.io/Proyecto-Banco-Mundial/)                  |



## Objetivo

El proyecto analiza descriptivamente dos indicadores:

| Indicador                                      | Descripción general                                                     |
| ---------------------------------------------- | ----------------------------------------------------------------------- |
| Dealing with construction permits: Time (days) | Tiempo requerido para obtener permisos de construcción, medido en días. |
| Starting a business - Score                    | Puntaje asociado a la facilidad para iniciar un negocio.                |

El análisis se concentra en Chile, Argentina y Uruguay durante el periodo 2003-2019.

La selección de estos tres países permite observar diferencias y trayectorias dentro del Cono Sur. Además, el proyecto busca producir visualizaciones propias a partir de datos del Banco Mundial, complementando la información disponible en los reportes originales.

## Fuente de datos

Los datos provienen del proyecto Doing Business del Banco Mundial.

Doing Business recopiló indicadores comparables sobre regulaciones empresariales y su aplicación en distintas economías. El dataset utilizado contiene información para múltiples países e indicadores, lo que permite comparar dimensiones regulatorias entre países y a través del tiempo.

Fuente principal:

https://archive.doingbusiness.org/en/data

También puede consultarse la fuente en DataBank:

https://databank.worldbank.org/source/doing-business

## Países y periodo analizado

| País      | Periodo   |
| --------- | --------- |
| Chile     | 2003-2019 |
| Argentina | 2003-2019 |
| Uruguay   | 2003-2019 |

El periodo se define según la disponibilidad de datos para los indicadores seleccionados.

## Metodología

El proyecto sigue un flujo de trabajo reproducible en R:

1. Carga de librerías.
2. Carga del dataset original.
3. Limpieza de datos.
4. Transformación de datos desde formato wide a formato long.
5. Revisión exploratoria de los datos.
6. Selección de países del Cono Sur.
7. Selección de indicadores de interés.
8. Construcción de tabla resumen.
9. Generación de visualizaciones estáticas.
10. Exportación de objetos para dashboard.
11. Construcción de dashboard interactivo en Shiny.

La transformación a formato long permite trabajar de mejor manera con visualizaciones, filtros dinámicos y herramientas como ggplot2, Shiny, Power BI o Tableau.

## Estructura del repositorio

```text
Proyecto-Banco-Mundial/
├── 01_data/
│   └── 01_raw/                 # Datos originales
├── 02_R/                       # Scripts principales del proyecto
│   ├── 00_setup.R              # Creación de estructura base del proyecto
│   ├── 01.1_renv.R             # Configuración de entorno reproducible
│   ├── 01_libraries.R          # Carga de librerías
│   ├── 02_load_data.R          # Carga del dataset
│   ├── 03_clean_data.R         # Limpieza y transformación de datos
│   ├── 04_eda.R                # Análisis exploratorio
│   ├── 05_countries_cities.R   # Revisión de países y ciudades
│   ├── 06_graphs-visuals.R     # Tablas y gráficos
│   ├── 07_Ejemplo Chile.R      # Ejemplo específico para Chile (exploratorio)
│   └── 08_Dashboard.R          # Dashboard interactivo en Shiny
├── 03_outputs/
│   ├── 01_tables/              # Tablas exportadas
│   ├── 02_figures/             # Gráficos exportados
│   └── 04_datasource/          # Objetos usados por el dashboard
├── docs/                       # Informe generado con Quarto
├── renv/                       # Entorno reproducible de R
├── renv.lock                   # Versiones de paquetes utilizadas
├── main.R                      # Script principal de ejecución
├── Proyecto-Banco-Mundial.Rproj
├── LICENSE
└── README.md
```

## Requisitos

Este proyecto fue desarrollado en R.

Librerías principales utilizadas:

```r
tidyverse
janitor
skimr
lubridate
readxl
writexl
data.table
scales
patchwork
ggthemes
renv
shiny
DT
```

Para reproducir el entorno, se recomienda usar `renv`, ya que el repositorio incluye un archivo `renv.lock` con las versiones de paquetes utilizadas.

## Instalación y reproducción

Clonar el repositorio:

```bash
git clone https://github.com/SanDBIG/Proyecto-Banco-Mundial.git
```

Abrir el archivo del proyecto en RStudio:

```text
Proyecto-Banco-Mundial.Rproj
```

Restaurar el entorno de paquetes con `renv`:

```r
renv::restore()
```

Ejecutar el flujo principal:

```r
source("main.R")
```

También es posible ejecutar los scripts de forma secuencial desde la carpeta `02_R/`:

```r
source("02_R/01_libraries.R")
source("02_R/02_load_data.R")
source("02_R/03_clean_data.R")
source("02_R/04_eda.R")
source("02_R/06_graphs-visuals.R")
source("02_R/08_Dashboard.R")
```

## Outputs del proyecto

El proyecto genera tres tipos principales de salidas:

| Carpeta                     | Contenido                                                     |
| --------------------------- | ------------------------------------------------------------- |
| `03_outputs/01_tables/`     | Tabla resumen de indicadores para Chile, Argentina y Uruguay. |
| `03_outputs/02_figures/`    | Gráficos estáticos exportados en formato imagen.              |
| `03_outputs/04_datasource/` | Objetos `.rds` utilizados para alimentar el dashboard.        |

Entre los productos principales se encuentran:

```text
tabla_conosur_resumen.csv
grafico_conosur_serie_temporal.png
data_conosur.rds
tabla_conosur_resumen.rds
```

## Dashboard interactivo

El proyecto incluye un dashboard construido con Shiny.

El dashboard permite:

1. Seleccionar países.
2. Filtrar el rango de años.
3. Mostrar u ocultar valores en los gráficos.
4. Visualizar una tabla resumen.
5. Comparar la evolución de los dos indicadores seleccionados.

Para ejecutarlo:

```r
source("02_R/08_Dashboard.R")
```

## Resultados principales

El análisis permite observar la evolución de dos dimensiones regulatorias relevantes para Chile, Argentina y Uruguay:

1. El tiempo requerido para obtener permisos de construcción.
2. El puntaje asociado a la facilidad para iniciar un negocio.

Las visualizaciones permiten comparar trayectorias entre países y observar cambios en el tiempo. Desde una perspectiva descriptiva, estas diferencias pueden servir como punto de partida para analizar prioridades regulatorias, cambios institucionales y posibles vínculos entre política pública y competitividad económica.

A su vez, desde una perspectiva politológica da luces de como se construyó la agenda setting en el gobierno de turno, dejando una huella de como ciertas administraciones dan prioridad (o no) a impulsar la competitivadad económica del país.

## Limitaciones

Este proyecto tiene un alcance descriptivo. Las visualizaciones muestran tendencias y diferencias entre países, pero no permiten establecer relaciones causales entre cambios regulatorios, gobiernos específicos o resultados económicos.

Para avanzar hacia una explicación causal sería necesario incorporar:

1. Más indicadores.
2. Variables de control.
3. Modelos estadísticos.
4. Una estrategia metodológica explícita.
5. Revisión de literatura sobre regulación económica, competitividad y reformas institucionales.

Además, el proyecto utiliza una selección específica de indicadores, por lo que no representa la totalidad del informe Doing Business ni todas las dimensiones regulatorias medidas por el Banco Mundial.

## Futuras actualizaciones

Algunas mejoras planificadas son:

1. Agregar más indicadores del proyecto Doing Business.
2. Robustizar el dashboard con más filtros e indicadores.
3. Incorporar modelos de regresión para explorar asociaciones entre indicadores.
4. Incorporar modelos de clasfiicación para agrupar economías.
5. Comparar periodos presidenciales o cambios de gobierno.

## Autor

Proyecto desarrollado por Diego Iturrieta como ejercicio de análisis descriptivo, visualización de datos y documentación reproducible en R.

## Licencia

Este proyecto se distribuye bajo licencia MIT.

## Contribuciones

Diego Iturrieta desarrolló el flujo principal del proyecto, incluyendo la limpieza y transformación de datos, el análisis descriptivo, las visualizaciones, el dashboard interactivo y la documentación final.

[Diego Martinez](https://github.com/diegopinas) colaboró puntualmente en una etapa inicial del código, aportando una primera aproximación exploratoria que fue posteriormente revisada, ajustada y ampliada en el desarrollo final del proyecto.
