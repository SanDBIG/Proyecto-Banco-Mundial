
# Construcción del dashboard ----------------------------------------------


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
        
        # Fila interna para distribuir los controles dentro de la botonera.
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
          # width = 5 ocupa un poco más de espacio horizontal.
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
          
          # Control para mostrar u ocultar etiquetas numéricas en los gráficos.
          # width = 3 completa la fila.
          # 4 + 5 + 3 = 12.
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
      
      # div permite controlar el tamaño vertical de la tabla.
      # max-height define el alto máximo del contenedor.
      # overflow-y permite scroll vertical si la tabla excede ese alto.
      # margin-bottom separa la tabla de los gráficos.
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
    
    # width = 6 hace que el primer gráfico ocupe la mitad izquierda.
    # height controla el alto del gráfico en pantalla.
    column(
      width = 6,
      h4("Construction permits"),
      plotOutput("grafico_permisos", height = "500px")
    ),
    
    # width = 6 hace que el segundo gráfico ocupe la mitad derecha.
    # 6 + 6 = 12, por eso ambos quedan en una misma fila.
    column(
      width = 6,
      h4("Starting a business"),
      plotOutput("grafico_starting", height = "500px")
    )
  )
)

# SERVER ----------------------------------------------------------------------

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
        
        # Número de filas visibles en la tabla.
        # Como la tabla está dispuesta horizontalmente y angosta,
        # conviene mostrar pocas filas.
        pageLength = 3,
        
        # Activa scroll horizontal para no deformar el dashboard
        # cuando hay muchas columnas.
        scrollX = TRUE,
        
        # Alto interno de la tabla.
        # Si quieres una tabla más alta, sube este valor.
        # Si quieres una tabla más angosta, bájalo.
        scrollY = "120px",
        
        # Controla qué elementos muestra la tabla.
        # f = filtros
        # t = tabla
        # i = información inferior
        # p = paginación
        # Se excluye "l" para ocultar el selector de número de filas.
        dom = "ftip"
      )
    )
  })
  
  
  # ---------------------------------------------------------------------------
  # GRÁFICO 1: CONSTRUCTION PERMITS
  # ---------------------------------------------------------------------------
  
  output$grafico_permisos <- renderPlot({
    
    # Se usa data_conosur ya construido.
    # Aquí solo se filtra dinámicamente según los controles del dashboard.
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
      
      # Línea temporal por país.
      geom_line(linewidth = 0.9, na.rm = TRUE) +
      
      # Puntos por año.
      geom_point(size = 1.8, na.rm = TRUE) +
      
      # Eje X dinámico según el rango de años seleccionado.
      scale_x_continuous(
        breaks = seq(input$rango_anios[1], input$rango_anios[2], 2)
      ) +
      
      # Etiquetas generales del gráfico.
      labs(
        title = "Dealing with construction permits: Time (days)",
        subtitle = "Chile, Argentina y Uruguay, 2003-2019",
        x = "Año",
        y = "Días",
        color = "País"
      ) +
      
      # Tema visual base.
      theme_minimal()
    
    
    # Si el usuario activa "Mostrar valores",
    # se agregan etiquetas numéricas con un decimal.
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
    
    # Devuelve el gráfico final.
    p
  })
  
  
  # ---------------------------------------------------------------------------
  # GRÁFICO 2: STARTING A BUSINESS
  # ---------------------------------------------------------------------------
  
  output$grafico_starting <- renderPlot({
    
    # Se usa data_conosur ya construido.
    # Aquí solo se filtra dinámicamente según los controles del dashboard.
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
      
      # Línea temporal por país.
      geom_line(linewidth = 0.9, na.rm = TRUE) +
      
      # Puntos por año.
      geom_point(size = 1.8, na.rm = TRUE) +
      
      # Eje X dinámico según el rango de años seleccionado.
      scale_x_continuous(
        breaks = seq(input$rango_anios[1], input$rango_anios[2], 2)
      ) +
      
      # Etiquetas generales del gráfico.
      labs(
        title = "Starting a business - Score",
        subtitle = "Chile, Argentina y Uruguay, 2003-2019",
        x = "Año",
        y = "Score",
        color = "País"
      ) +
      
      # Tema visual base.
      theme_minimal()
    
    
    # Si el usuario activa "Mostrar valores",
    # se agregan etiquetas numéricas con un decimal.
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
    
    # Devuelve el gráfico final.
    p
  })
}
# APP -------------------------------------------------------------------------

shinyApp(ui = ui, server = server)
