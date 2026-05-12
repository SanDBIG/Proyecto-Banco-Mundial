
# Construcción del dashboard ----------------------------------------------


# Carga independiente de librerias para deploy de dashboard ---------------

library(shiny)
library(DT)
library(dplyr)
library(ggplot2)


# CARGAR OBJETOS PARA DASHBOARD ----------------------------------------------

data_conosur <- readRDS("03_outputs/04_datasource/data_conosur.rds")

tabla_conosur_resumen <- readRDS("03_outputs/04_datasource/tabla_conosur_resumen.rds")


# TABLA PARA DASHBOARD --------------------------------------------------------

tabla_dashboard <- DT::datatable(
  tabla_conosur_resumen,
  rownames = FALSE,
  filter = "top",
  options = list(
    pageLength = 10,
    scrollX = TRUE
  )
)


# GRÁFICO 1: PERMISOS DE CONSTRUCCIÓN ----------------------------------------

grafico_permisos <- data_conosur %>%
  filter(`Series Name` == "Dealing with construction permits: Time (days)") %>%
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
  scale_x_continuous(breaks = seq(2003, 2019, 2)) +
  labs(
    title = "Tiempo para obtener permisos de construcción",
    subtitle = "Chile, Argentina y Uruguay, 2003-2019",
    x = "Año",
    y = "Días",
    color = "País"
  ) +
  theme_minimal()


# GRÁFICO 2: STARTING A BUSINESS ---------------------------------------------

grafico_starting <- data_conosur %>%
  filter(`Series Name` == "Starting a business - Score") %>%
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
  scale_x_continuous(breaks = seq(2003, 2019, 2)) +
  labs(
    title = "Puntaje para iniciar un negocio",
    subtitle = "Chile, Argentina y Uruguay, 2003-2019",
    x = "Año",
    y = "Score",
    color = "País"
  ) +
  theme_minimal()




# UI --------------------------------------------------------------------------
# Define lo que se ve en pantalla: controles, tabla y gráficos.

ui <- fluidPage(
  
  # Título general del dashboard.
  titlePanel("Indicadores seleccionados en países del Cono Sur"),
  
  
  # ---------------------------------------------------------------------------
  # FILA 1: CONTROLES DEL DASHBOARD
  # ---------------------------------------------------------------------------
  
  fluidRow(
    
    # width = 12 hace que la botonera ocupe todo el ancho del dashboard.
    column(
      width = 12,
      
      # wellPanel crea el cuadro gris de controles.
      # padding controla el espacio interno.
      # margin-bottom separa visualmente la botonera de la tabla.
      wellPanel(
        style = "padding: 8px; margin-bottom: 10px;",
        
        # Fila interna para distribuir los controles.
        fluidRow(
          
          # Control del rango de años.
          # width = 4 ocupa un tercio de la botonera.
          column(
            width = 4,
            sliderInput(
              inputId = "rango_anios",
              label = "Rango de años",
              min = 2003,
              max = 2019,
              value = c(2003, 2019),
              step = 1,
              sep = ""
            )
          ),
          
          # Control de selección de países.
          # inline = TRUE deja las opciones en una misma línea.
          column(
            width = 5,
            checkboxGroupInput(
              inputId = "paises",
              label = "Países",
              choices = c("Argentina", "Chile", "Uruguay"),
              selected = c("Argentina", "Chile", "Uruguay"),
              inline = TRUE
            )
          ),
          
          # Control para mostrar u ocultar etiquetas numéricas.
          column(
            width = 3,
            checkboxInput(
              inputId = "mostrar_valores",
              label = "Mostrar valores",
              value = TRUE
            )
          )
        )
      )
    )
  ),
  
  
  # ---------------------------------------------------------------------------
  # FILA 2: TABLA RESUMEN HORIZONTAL
  # ---------------------------------------------------------------------------
  
  fluidRow(
    
    # width = 12 hace que la tabla ocupe todo el ancho disponible.
    column(
      width = 12,
      h4("Tabla resumen"),
      
      # max-height controla el alto máximo de la tabla.
      # overflow-y agrega scroll vertical si la tabla supera ese alto.
      div(
        style = "max-height: 220px; overflow-y: auto; margin-bottom: 15px;",
        DTOutput("tabla_resumen")
      )
    )
  ),
  
  
  # ---------------------------------------------------------------------------
  # FILA 3: GRÁFICOS
  # ---------------------------------------------------------------------------
  
  fluidRow(
    
    # width = 6 deja este gráfico en la mitad izquierda.
    column(
      width = 6,
      h4("Construction permits"),
      plotOutput("grafico_permisos", height = "500px")
    ),
    
    # width = 6 deja este gráfico en la mitad derecha.
    column(
      width = 6,
      h4("Starting a business"),
      plotOutput("grafico_starting", height = "500px")
    )
  )
)


# SERVER ----------------------------------------------------------------------
# Define cómo se actualizan la tabla y los gráficos según los controles.

server <- function(input, output) {
  
  
  # ---------------------------------------------------------------------------
  # TABLA RESUMEN
  # ---------------------------------------------------------------------------
  
  output$tabla_resumen <- renderDT({
    
    DT::datatable(
      tabla_conosur_resumen,
      rownames = FALSE,
      filter = "top",
      
      options = list(
        
        # Número de filas visibles.
        pageLength = 3,
        
        # Scroll horizontal para tablas con muchas columnas.
        scrollX = TRUE,
        
        # Alto interno de la tabla.
        scrollY = "120px",
        
        # f = buscador/filtros
        # t = tabla
        # i = información inferior
        # p = paginación
        dom = "ftip"
      )
    )
  })
  
  
  # ---------------------------------------------------------------------------
  # GRÁFICO 1: CONSTRUCTION PERMITS
  # ---------------------------------------------------------------------------
  
  output$grafico_permisos <- renderPlot({
    
    # Filtra dinámicamente según países y rango de años.
    p <- data_conosur %>%
      filter(
        `Series Name` == "Dealing with construction permits: Time (days)",
        `Country Name` %in% input$paises,
        Year >= input$rango_anios[1],
        Year <= input$rango_anios[2]
      ) %>%
      ggplot(aes(
        x = Year,
        y = Value,
        color = `Country Name`,
        group = `Country Name`
      )) +
      geom_line(linewidth = 0.9, na.rm = TRUE) +
      geom_point(size = 1.8, na.rm = TRUE) +
      scale_x_continuous(
        breaks = seq(input$rango_anios[1], input$rango_anios[2], 2)
      ) +
      labs(
        title = "Dealing with construction permits: Time (days)",
        subtitle = "Chile, Argentina y Uruguay, 2003-2019",
        x = "Año",
        y = "Días",
        color = "País"
      ) +
      theme_minimal()
    
    # Agrega etiquetas si el checkbox está activado.
    if (input$mostrar_valores) {
      p <- p +
        geom_text(
          aes(label = round(Value, 1)),
          size = 3,
          vjust = -0.8,
          na.rm = TRUE,
          show.legend = FALSE
        )
    }
    
    p
  })
  
  
  # ---------------------------------------------------------------------------
  # GRÁFICO 2: STARTING A BUSINESS
  # ---------------------------------------------------------------------------
  
  output$grafico_starting <- renderPlot({
    
    # Filtra dinámicamente según países y rango de años.
    p <- data_conosur %>%
      filter(
        `Series Name` == "Starting a business - Score",
        `Country Name` %in% input$paises,
        Year >= input$rango_anios[1],
        Year <= input$rango_anios[2]
      ) %>%
      ggplot(aes(
        x = Year,
        y = Value,
        color = `Country Name`,
        group = `Country Name`
      )) +
      geom_line(linewidth = 0.9, na.rm = TRUE) +
      geom_point(size = 1.8, na.rm = TRUE) +
      scale_x_continuous(
        breaks = seq(input$rango_anios[1], input$rango_anios[2], 2)
      ) +
      labs(
        title = "Starting a business - Score",
        subtitle = "Chile, Argentina y Uruguay, 2003-2019",
        x = "Año",
        y = "Score",
        color = "País"
      ) +
      theme_minimal()
    
    # Agrega etiquetas si el checkbox está activado.
    if (input$mostrar_valores) {
      p <- p +
        geom_text(
          aes(label = round(Value, 1)),
          size = 3,
          vjust = -0.8,
          na.rm = TRUE,
          show.legend = FALSE
        )
    }
    
    p
  })
}


# APP -------------------------------------------------------------------------
# Ejecuta el dashboard.

shinyApp(ui = ui, server = server)
