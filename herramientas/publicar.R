# =============================================================================
# publicar.R
# -----------------------------------------------------------------------------
# Genera dos salidas del libro sin tocar los archivos fuente:
#
#   1. salidas/Hidrologia_Aplicada.html
#      Un solo archivo HTML con todo el libro (texto, figuras, tablas, estilos).
#      Se abre con doble clic en cualquier navegador, sin RStudio y sin
#      internet. Se puede copiar a una llave USB o enviar por correo/Drive.
#
#   2. _publicar/_book/
#      El sitio web del libro (varias páginas, con buscador), con las imágenes
#      reducidas para que pese poco. Es lo que se sube a la web.
#
# Cómo usarlo desde RStudio (con el proyecto libro_hidrologia.Rproj abierto):
#
#   source("herramientas/publicar.R")
#   libro_un_archivo()      # solo el HTML de un archivo
#   libro_web()             # solo el sitio web
#   libro_todo()            # las dos cosas
#
# Desde la terminal:  Rscript herramientas/publicar.R todo
#
# Paquetes que necesita además de los del libro:  install.packages(c("yaml", "magick"))
#
# Qué hace por dentro:
#   - Copia el proyecto a la carpeta temporal _publicar/ (ignorada por git).
#   - En esa copia reduce las imágenes grandes (máximo 1600 px de lado y
#     formato WebP). Los originales en assets/img/ no se modifican.
#   - Para el HTML de un archivo, une todos los capítulos en un único .qmd,
#     en el orden de _quarto.yml, y lo renderiza con embed-resources.
# =============================================================================

local({
  for (p in c("yaml", "magick")) {
    if (!requireNamespace(p, quietly = TRUE)) {
      stop("Falta el paquete '", p, "'. Instálelo con install.packages(\"", p, "\")",
           call. = FALSE)
    }
  }
})

# --- Configuración ------------------------------------------------------------

PUB_DIR        <- "_publicar"      # copia de trabajo (se puede borrar sin problema)
SALIDAS_DIR    <- "salidas"        # donde queda el HTML de un archivo
NOMBRE_HTML    <- "Hidrologia_Aplicada.html"
LADO_MAX_PX    <- 2000             # lado mayor de las imágenes reducidas
CALIDAD_WEBP   <- 92               # 0-100; antes 80, que emborronaba líneas y letras
# Los PNG y GIF (mapas, esquemas, gráficos con texto) usan además "sharp YUV",
# que conserva mejor los bordes de color finos. WebP sin pérdida se probó y
# triplica el peso del HTML (160 MB).
UMBRAL_KB      <- 300              # imágenes más livianas que esto se dejan igual

# --- Utilidades ---------------------------------------------------------------

buscar_quarto <- function() {
  if (requireNamespace("quarto", quietly = TRUE)) {
    q <- tryCatch(quarto::quarto_path(), error = function(e) NULL)
    if (!is.null(q) && nzchar(q)) return(q)
  }
  q <- Sys.which("quarto")
  if (nzchar(q)) return(unname(q))
  # Quarto que trae RStudio en Windows
  pandoc <- Sys.getenv("RSTUDIO_PANDOC")
  if (nzchar(pandoc)) {
    cand <- file.path(dirname(pandoc), "quarto", "bin", "quarto.exe")
    if (file.exists(cand)) return(cand)
  }
  stop("No encontré Quarto. Instálelo desde https://quarto.org o instale el paquete 'quarto'.",
       call. = FALSE)
}

correr_quarto <- function(args, dir) {
  q <- buscar_quarto()
  viejo <- setwd(dir)
  on.exit(setwd(viejo), add = TRUE)
  st <- system2(q, args)
  if (!identical(st, 0L)) stop("Quarto terminó con error (código ", st, ").", call. = FALSE)
  invisible(TRUE)
}

# Lista de capítulos en orden, con la parte a la que pertenece cada uno
leer_capitulos <- function(cfg) {
  out <- list()
  for (ch in cfg$book$chapters) {
    if (is.character(ch)) {
      out[[length(out) + 1]] <- list(archivo = ch, parte = NA_character_)
    } else if (!is.null(ch$part)) {
      for (sub in ch$chapters) {
        out[[length(out) + 1]] <- list(archivo = sub, parte = ch$part)
      }
    }
  }
  out
}

# Separa el encabezado YAML del cuerpo de un .qmd
partir_qmd <- function(lineas) {
  if (length(lineas) > 0 && grepl("^---\\s*$", lineas[1])) {
    fin <- which(grepl("^---\\s*$", lineas))[2]
    if (!is.na(fin)) {
      yml <- tryCatch(yaml::yaml.load(paste(lineas[2:(fin - 1)], collapse = "\n")),
                      error = function(e) list())
      cuerpo <- if (fin < length(lineas)) lineas[(fin + 1):length(lineas)] else character()
      return(list(yaml = yml, cuerpo = cuerpo))
    }
  }
  list(yaml = list(), cuerpo = lineas)
}

# --- Paso 1: copia de trabajo con imágenes livianas ---------------------------

preparar_copia <- function() {
  dir.create(PUB_DIR, showWarnings = FALSE)

  # Archivos del proyecto (sin carpetas de salida ni la propia copia)
  excluir <- c(PUB_DIR, SALIDAS_DIR, "_book", ".quarto", ".git", "herramientas",
               ".Rproj.user", "renv")
  elementos <- setdiff(list.files(".", all.files = FALSE, no.. = TRUE), excluir)
  elementos <- elementos[!grepl("_files$", elementos)]
  for (e in elementos) {
    if (e == "assets") next
    file.copy(e, PUB_DIR, recursive = TRUE, overwrite = TRUE)
  }
  # Funciones que usan los capítulos (por ejemplo, los mapas de Costa Rica)
  dir.create(file.path(PUB_DIR, "herramientas"), showWarnings = FALSE)
  file.copy("herramientas/mapas_cr.R", file.path(PUB_DIR, "herramientas"),
            overwrite = TRUE)
  # assets sin imágenes, que se tratan aparte
  dir.create(file.path(PUB_DIR, "assets", "img"), recursive = TRUE, showWarnings = FALSE)
  for (d in setdiff(list.files("assets"), "img")) {
    file.copy(file.path("assets", d), file.path(PUB_DIR, "assets"),
              recursive = TRUE, overwrite = TRUE)
  }

  # Imágenes: reducir las pesadas a WebP, copiar el resto tal cual
  renombres <- character()   # "assets/img/x.png" -> "assets/img/x.webp"
  imgs <- list.files("assets/img", full.names = TRUE)
  imgs <- imgs[!dir.exists(imgs)]
  n_red <- 0
  for (src in imgs) {
    ext <- tolower(tools::file_ext(src))
    pesada <- file.size(src) > UMBRAL_KB * 1024 && ext %in% c("png", "jpg", "jpeg", "jfif")
    if (!pesada) {
      dst <- file.path(PUB_DIR, "assets", "img", basename(src))
      if (!file.exists(dst) || file.mtime(dst) < file.mtime(src)) file.copy(src, dst, overwrite = TRUE)
      next
    }
    nuevo <- paste0(tools::file_path_sans_ext(basename(src)), ".webp")
    dst <- file.path(PUB_DIR, "assets", "img", nuevo)
    renombres[paste0("assets/img/", basename(src))] <- paste0("assets/img/", nuevo)
    if (file.exists(dst) && file.mtime(dst) >= file.mtime(src)) next   # ya estaba hecha
    im <- magick::image_read(src)
    info <- magick::image_info(im)[1, ]
    if (max(info$width, info$height) > LADO_MAX_PX) {
      im <- magick::image_resize(im, paste0(LADO_MAX_PX, "x", LADO_MAX_PX, ">"))
    }
    if (ext %in% c("png", "gif")) {
      magick::image_write(im, dst, format = "webp", quality = CALIDAD_WEBP,
                          defines = c("webp:use-sharp-yuv" = "true"))
    } else {
      magick::image_write(im, dst, format = "webp", quality = CALIDAD_WEBP)
    }
    n_red <- n_red + 1
  }
  message("Imágenes reducidas en esta corrida: ", n_red,
          " (", length(renombres), " en total pasan a WebP)")

  # Cambiar las referencias en los .qmd de la copia
  qmds <- list.files(PUB_DIR, pattern = "\\.qmd$", full.names = TRUE)
  if (length(renombres)) {
    orden <- order(nchar(names(renombres)), decreasing = TRUE)
    for (f in qmds) {
      txt <- readLines(f, encoding = "UTF-8", warn = FALSE)
      for (k in orden) {
        txt <- gsub(names(renombres)[k], renombres[[k]], txt, fixed = TRUE, useBytes = TRUE)
      }
      writeLines(txt, f, useBytes = TRUE)
    }
  }
  invisible(renombres)
}

# --- Paso 2a: sitio web -------------------------------------------------------

libro_web <- function(preparar = TRUE) {
  if (preparar) preparar_copia()
  # La copia usa el _quarto.yml original del libro
  file.copy("_quarto.yml", file.path(PUB_DIR, "_quarto.yml"), overwrite = TRUE)
  correr_quarto(c("render", "--to", "html"), PUB_DIR)
  message("Sitio web listo en ", file.path(PUB_DIR, "_book"),
          " (abra index.html para revisarlo)")
  invisible(file.path(PUB_DIR, "_book"))
}

# --- Paso 2b: un solo archivo -------------------------------------------------

unir_capitulos <- function(cfg) {
  caps <- leer_capitulos(cfg)
  vistos <- character()          # etiquetas ya usadas en capítulos anteriores
  parte_actual <- NA_character_
  salida <- character()

  for (i in seq_along(caps)) {
    cap <- caps[[i]]
    if (basename(cap$archivo) == "99-Referencias.qmd") next   # va al final
    ruta <- file.path(PUB_DIR, cap$archivo)
    if (!file.exists(ruta)) next
    p <- partir_qmd(readLines(ruta, encoding = "UTF-8", warn = FALSE))
    cuerpo <- p$cuerpo
    if (!any(nzchar(trimws(cuerpo)))) next                   # capítulos aún vacíos

    # Etiquetas repetidas entre capítulos (p. ej. tbl-KA): en un solo documento
    # chocarían, así que se renombran dentro de este capítulo.
    etiquetas <- unique(c(
      sub("^#\\|\\s*label:\\s*", "", grep("^#\\|\\s*label:", cuerpo, value = TRUE)),
      regmatches(cuerpo, regexpr("(?<=\\{#)(fig|tbl|eq|sec)-[A-Za-z0-9_-]+", cuerpo, perl = TRUE))
    ))
    etiquetas <- trimws(etiquetas)
    repetidas <- intersect(etiquetas, vistos)
    for (et in repetidas) {
      nueva <- paste0(et, "-c", i)
      patron <- paste0("(?<![A-Za-z0-9_-])", et, "(?![A-Za-z0-9_-])")
      cuerpo <- gsub(patron, nueva, cuerpo, perl = TRUE)
    }
    vistos <- c(vistos, setdiff(etiquetas, repetidas), paste0(repetidas, "-c", i))

    if (!is.na(cap$parte) && !identical(cap$parte, parte_actual)) {
      salida <- c(salida, "", paste0("# ", cap$parte, " {.unnumbered .parte}"), "")
      parte_actual <- cap$parte
    }
    if (!is.null(p$yaml$title)) {
      salida <- c(salida, "", paste0("# ", p$yaml$title), "")
    }
    # Los videos de YouTube no se reproducen dentro de un archivo abierto desde
    # el disco (file://): YouTube muestra el "Error 153". Se reemplazan por un
    # enlace que abre el video en el navegador.
    txt <- paste(cuerpo, collapse = "\n")
    enlace <- "[\u25B6 Ver el video en YouTube](https://www.youtube.com/watch?v=\\1){.video-enlace}"
    txt <- gsub("<iframe[^>]*?src=\"https://www\\.youtube\\.com/embed/([A-Za-z0-9_-]+)\"[^>]*>\\s*</iframe>",
                enlace, txt, perl = TRUE)
    txt <- gsub("\\{\\{< video https://www\\.youtube\\.com/embed/([A-Za-z0-9_-]+) >\\}\\}",
                enlace, txt, perl = TRUE)
    cuerpo <- strsplit(txt, "\n", fixed = TRUE)[[1]]
    salida <- c(salida, cuerpo, "")
  }
  salida
}

libro_un_archivo <- function(preparar = TRUE) {
  if (preparar) preparar_copia()
  cfg <- yaml::read_yaml("_quarto.yml")
  html_cfg <- cfg$format$html
  html_cfg$`include-after-body` <- NULL   # se vuelve a poner abajo, con la navegación

  cuerpo <- unir_capitulos(cfg)
  encabezado <- list(
    title    = cfg$book$title,
    subtitle = cfg$book$subtitle,
    author   = vapply(cfg$book$author, function(a) a$name, ""),
    date     = format(Sys.Date(), "%Y-%m-%d"),
    lang     = cfg$lang,
    bibliography = "references.bib",
    csl      = "assets/csl/apa.csl",
    nocite   = "@*",
    # Numeración por capítulo (Figura 13.2), como en el libro de varias páginas
    crossref = c(cfg$crossref, list(chapters = TRUE)),
    format   = list(html = c(
      html_cfg,
      list(`embed-resources` = TRUE, `toc-location` = "left", `toc-expand` = 1L,
           # Un capítulo por pantalla, con enlaces de anterior y siguiente
           # y las herramientas de lectura (búsqueda y accesibilidad)
           `include-after-body` = list("assets/js/paginas.html", "assets/js/accesibilidad.html"),
           `title-block-banner` = FALSE,
           # MathML: las ecuaciones se ven sin internet (Chrome, Edge, Firefox)
           `html-math-method` = "mathml")
    )),
    execute  = cfg$execute
  )
  texto <- c("---", yaml::as.yaml(encabezado, handlers = list(
               logical = function(x) { v <- ifelse(x, "true", "false"); class(v) <- "verbatim"; v })), "---", "",
             cuerpo, "", "# Referencias {.unnumbered}", "", "::: {#refs}", ":::", "")
  qmd <- "Hidrologia_Aplicada.qmd"
  writeLines(enc2utf8(texto), file.path(PUB_DIR, qmd), useBytes = TRUE)

  # Dentro de la copia el proyecto pasa a ser un documento normal (no libro)
  writeLines(c("project:", "  type: default"), file.path(PUB_DIR, "_quarto.yml"))
  on.exit(file.copy("_quarto.yml", file.path(PUB_DIR, "_quarto.yml"), overwrite = TRUE),
          add = TRUE)
  correr_quarto(c("render", qmd, "--to", "html"), PUB_DIR)

  dir.create(SALIDAS_DIR, showWarnings = FALSE)
  destino <- file.path(SALIDAS_DIR, NOMBRE_HTML)
  file.copy(file.path(PUB_DIR, sub("\\.qmd$", ".html", qmd)), destino, overwrite = TRUE)
  message(sprintf("Listo: %s (%.1f MB). Ábralo con doble clic.",
                  destino, file.size(destino) / 1024^2))
  invisible(destino)
}

libro_todo <- function() {
  preparar_copia()
  libro_web(preparar = FALSE)
  libro_un_archivo(preparar = FALSE)
}

# --- Uso desde la terminal ----------------------------------------------------

if (!interactive() && sys.nframe() == 0L) {
  arg <- commandArgs(trailingOnly = TRUE)
  arg <- if (length(arg)) arg[1] else "todo"
  switch(arg,
         web    = libro_web(),
         unico  = libro_un_archivo(),
         todo   = libro_todo(),
         stop("Opciones: web, unico o todo"))
}
