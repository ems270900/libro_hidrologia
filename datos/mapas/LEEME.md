# Capas para los mapas de Costa Rica

Capas livianas que usa `herramientas/mapas_cr.R`. Todas están en CRTM05 (EPSG:5367). Se prepararon el 2026-11-20 a partir de los archivos originales del autor, que no se modificaron.

## limites_cr.gpkg

- **provincias** (8 registros): campos `PROVINCIA`, `PROV` y `tipo`. La fila con `PROVINCIA = "NA"` es el marco del recuadro de la Isla del Coco (`tipo = "marco_isla_coco"`); Puntarenas incluye la isla trasladada dentro del recuadro.
- **cuencas** (34 registros): campos `cuenca_no`, `nombre` y `area_ha` (área del archivo original, sin recalcular).
- Proceso: `st_make_valid`, simplificación con tolerancia de 50 m (`preserveTopology = TRUE`) y `st_make_valid` de nuevo. Entre polígonos vecinos puede haber holguras o traslapes menores de 50 m, que no se ven a escala de página.

## cobertura_snit_100m.tif y cobertura_clases.csv

Raster entero de 100 m (NoData = 255) con cinco clases, construido con las capas oficiales de cobertura del Sistema Nacional de Información Territorial (SNIT):

| Código | Capa SNIT | Clase | Fecha de la capa (campo `version`) |
|:-:|:--|:--|:--|
| 1 | Forestal (170102) | Bosque arbóreo | 2019-12-19 |
| 2 | Forestal (170104) | Manglar | 2019-12-19 |
| 3 | Pastos (170103) | Pastos | 2022-05-06 |
| 4 | Cultivos (170201) | Cultivos | 2019-11-16 |
| 5 | Urbano (1401xx a 1402xx) | Urbano / edificaciones | 2020-09-01 |

Método:

- Bosque, pastos y cultivos: `terra::rasterize` (la celda toma la clase si su centro cae en el polígono).
- Urbano: las edificaciones se rasterizaron a 10 m y una celda de 100 m se marcó urbana si al menos el 10 % de su área está construida.
- Donde hay traslape gana, en este orden: urbano, cultivos, pastos, bosque.
- La Isla del Coco se trasladó al recuadro (dx = +178 354.5 m, dy = +335 313.0 m).
- Se enmascaró con el límite nacional.
- Las zonas sin ninguna de las cuatro capas (agua, humedales, páramo, suelo desnudo) quedan como NoData.

`cobertura_clases.csv` trae el código, la capa, el código SNIT, el nombre, el color del estilo oficial (`.qml`), el color usado en el libro, el número de celdas y el área en km².

## hillshade_400m.tif

Relieve sombreado de 10 m agregado por media a 400 m. Se usa solo como fondo visual.
