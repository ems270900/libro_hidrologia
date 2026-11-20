# Mapas de Costa Rica con el formato único del libro
#
# Todos los mapas del país se dibujan en CRTM05 (EPSG:5367), con ejes nativos de
# ggplot cada 100 000 m, fuente serif, escala gráfica abajo a la izquierda, norte
# arriba a la derecha, límite provincial y nacional, y el recuadro de la Isla del
# Coco. Las capas están en datos/mapas/ (ver datos/mapas/LEEME.md).
#
# Uso en un capítulo:
#   source("herramientas/mapas_cr.R")
#   capas <- leer_capas_cr()
#   ggplot() + ... + contorno_cr(capas) + marco_cr(capas)

library(sf)
library(ggplot2)

DIR_MAPAS <- "datos/mapas"
CRS_CR <- 5367L
FUENTE_MAPA <- "serif"
COLOR_CONTORNO <- "#343A40"
COLOR_PROVINCIAS <- "grey65"
COLOR_CUADRICULA <- "#DDDDDD"

# Lee los límites y calcula la extensión del mapa (país más 3 % de margen)
leer_capas_cr <- function(dir = DIR_MAPAS) {
  sf_use_s2(FALSE)
  gpkg <- file.path(dir, "limites_cr.gpkg")
  provincias <- st_read(gpkg, layer = "provincias", quiet = TRUE)
  cuencas <- st_read(gpkg, layer = "cuencas", quiet = TRUE)
  pais <- st_sf(geometry = st_union(st_geometry(provincias)))
  caja <- st_bbox(pais)
  rx <- caja[["xmax"]] - caja[["xmin"]]
  ry <- caja[["ymax"]] - caja[["ymin"]]
  list(
    provincias = provincias,
    cuencas = cuencas,
    pais = pais,
    xlim = c(caja[["xmin"]] - 0.03 * rx, caja[["xmax"]] + 0.03 * rx),
    ylim = c(caja[["ymin"]] - 0.03 * ry, caja[["ymax"]] + 0.03 * ry)
  )
}

# Bordes de los polígonos como líneas (así el recuadro de la Isla del Coco,
# que es un polígono con hueco, se dibuja como marco y la isla queda visible)
bordes <- function(x) {
  lineas <- st_boundary(st_geometry(x))
  if (inherits(lineas, "sfc_GEOMETRY") || inherits(lineas, "sfc_GEOMETRYCOLLECTION")) {
    lineas <- st_collection_extract(lineas, "LINESTRING", warn = FALSE)
  }
  st_sf(geometry = lineas[!st_is_empty(lineas)])
}

# Quita islas y huecos pequeños (canales de manglar, islotes) para que el
# contorno no se empaste a escala de página. Solo afecta el dibujo.
limpiar_contorno <- function(x, area_min = 2e6, hueco_min = 3e7) {
  poligonos <- st_cast(st_geometry(x), "POLYGON", warn = FALSE)
  poligonos <- poligonos[as.numeric(st_area(poligonos)) >= area_min]
  limpios <- lapply(poligonos, function(pol) {
    anillos <- unclass(pol)
    grandes <- vapply(anillos, function(a) {
      abs(sum(a[-1, 1] * a[-nrow(a), 2] - a[-nrow(a), 1] * a[-1, 2])) / 2 >= hueco_min
    }, logical(1))
    st_polygon(anillos[c(TRUE, grandes[-1])])
  })
  st_sfc(limpios, crs = st_crs(x))
}

# Límite provincial (gris) y nacional (oscuro), siempre encima de los datos
contorno_cr <- function(capas) {
  provincias <- capas$provincias
  marco <- provincias[provincias$tipo == "marco_isla_coco", ]
  tierra <- provincias[provincias$tipo != "marco_isla_coco", ]
  provincias_limpias <- do.call(c, lapply(seq_len(nrow(tierra)), function(i) {
    st_union(limpiar_contorno(tierra[i, ], area_min = 2e7))
  }))
  pais_limpio <- limpiar_contorno(capas$pais, area_min = 2e7)
  list(
    geom_sf(data = bordes(st_sf(geometry = provincias_limpias)),
            colour = COLOR_PROVINCIAS, linewidth = 0.22, inherit.aes = FALSE),
    geom_sf(data = bordes(marco), colour = COLOR_CONTORNO,
            linewidth = 0.60, inherit.aes = FALSE),
    geom_sf(data = bordes(st_sf(geometry = pais_limpio)), colour = COLOR_CONTORNO,
            linewidth = 0.45, inherit.aes = FALSE)
  )
}

tema_mapa_cr <- function(base = 12, eje = 11) {
  theme_minimal(base_size = base, base_family = FUENTE_MAPA) +
    theme(
      plot.background = element_rect(fill = "white", colour = NA),
      panel.background = element_rect(fill = "white", colour = NA),
      panel.grid.major = element_line(colour = COLOR_CUADRICULA, linewidth = 0.25),
      panel.grid.minor = element_blank(),
      axis.title = element_text(face = "bold", colour = COLOR_CONTORNO, size = base),
      axis.title.x = element_text(margin = margin(t = 8)),
      axis.title.y = element_text(margin = margin(r = 8)),
      axis.text = element_text(colour = COLOR_CONTORNO, size = eje),
      axis.ticks = element_line(colour = COLOR_CONTORNO, linewidth = 0.25),
      legend.position = "bottom",
      legend.box = "vertical",
      legend.title = element_text(face = "bold", size = base),
      legend.text = element_text(size = eje),
      plot.margin = margin(8, 12, 8, 8)
    )
}

# Sistema de coordenadas, ejes, escala gráfica y norte
marco_cr <- function(capas) {
  formato_eje <- scales::label_number(accuracy = 1, big.mark = " ",
                                      decimal.mark = ".")
  list(
    coord_sf(crs = st_crs(CRS_CR), datum = st_crs(CRS_CR),
             xlim = capas$xlim, ylim = capas$ylim, expand = FALSE),
    scale_x_continuous(breaks = seq(300000, 600000, by = 100000),
                       labels = formato_eje),
    scale_y_continuous(breaks = seq(900000, 1200000, by = 100000),
                       labels = formato_eje),
    labs(x = "Este CRTM05 (m)", y = "Norte CRTM05 (m)"),
    tema_mapa_cr(),
    ggspatial::annotation_scale(location = "bl", width_hint = 0.25,
                                text_family = FUENTE_MAPA, text_cex = 0.85,
                                unit_category = "metric"),
    ggspatial::annotation_north_arrow(
      location = "tr", which_north = "true",
      style = ggspatial::north_arrow_fancy_orienteering(text_family = FUENTE_MAPA),
      height = grid::unit(0.9, "cm"), width = grid::unit(0.9, "cm"))
  )
}

# Raster de relieve sombreado como capa de transparencia (solo visual)
capa_relieve <- function(capas, dir = DIR_MAPAS, alfa_max = 0.5) {
  r <- terra::rast(file.path(dir, "hillshade_400m.tif"))
  r <- terra::mask(r, terra::vect(capas$pais))
  d <- terra::as.data.frame(r, xy = TRUE, na.rm = TRUE)
  names(d)[3] <- "brillo"
  # Los valores muy bajos aparecen sobre agua y humedales, no sobre laderas
  d <- d[d$brillo >= 100, ]
  # El terreno plano tiene el brillo mediano; solo se sombrean las laderas
  # que quedan más oscuras que él
  plano <- stats::median(d$brillo)
  oscuro <- stats::quantile(d$brillo, 0.02)[[1]]
  d$sombra <- pmin(1, pmax(0, (plano - d$brillo) / (plano - oscuro))) * alfa_max
  list(
    geom_raster(data = d, aes(x = .data$x, y = .data$y, alpha = .data$sombra),
                fill = "black", inherit.aes = FALSE, show.legend = FALSE),
    scale_alpha_identity(guide = "none")
  )
}
