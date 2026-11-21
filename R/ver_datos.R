# =============================================================================
# ver_datos.R
# -----------------------------------------------------------------------------
# Muestra, dentro de un ejemplo, el archivo de datos que usa:
#   - un botón para descargar el CSV (el archivo va incrustado en la página,
#     así que funciona también en el HTML de un solo archivo y sin internet);
#   - una vista previa paginada de la tabla, con pocas filas por página.
#
# Uso en un capítulo (bloque con `#| echo: false`):
#   source("R/ver_datos.R")
#   ver_datos("datos/lluvia_mensual_dos_estaciones.csv")
#   ver_datos("datos/lluvia_normal_tarcoles_imn.csv", tabla = FALSE)  # solo el botón
# =============================================================================

ver_datos <- function(archivo, filas = 6, tabla = TRUE, nombres = NULL) {
  boton <- xfun::embed_file(
    archivo,
    text = htmltools::HTML(paste0("&#11015; Descargar <code>", basename(archivo), "</code>")),
    class = "boton-datos"
  )
  if (!tabla) return(htmltools::div(class = "datos-ejemplo", boton))

  datos <- utils::read.csv(archivo, check.names = FALSE, fileEncoding = "UTF-8")
  vista <- DT::datatable(
    datos,
    rownames = FALSE,
    colnames = if (is.null(nombres)) names(datos) else nombres,
    class = "compact stripe hover",
    options = list(
      pageLength = filas,
      lengthChange = FALSE,
      searching = FALSE,
      ordering = FALSE,
      autoWidth = FALSE,
      dom = "tip",
      language = list(
        info = "Filas _START_ a _END_ de _TOTAL_",
        infoEmpty = "Sin filas",
        paginate = list(previous = "Anterior", `next` = "Siguiente",
                        first = "Primera", last = "Última")
      )
    )
  )
  htmltools::div(class = "datos-ejemplo", boton, vista)
}
