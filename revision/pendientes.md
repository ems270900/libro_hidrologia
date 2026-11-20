# Trabajo pendiente del libro

## Capítulo nuevo: productos satelitales para hidrología

Pedido por el autor el 2026-11-20. No se escribe todavía; se agrega cuando corresponda en el orden del libro (probablemente después de los capítulos de precipitación y evapotranspiración).

Contenido propuesto:

1. Principios de percepción remota útiles para hidrología: bandas, resolución espacial, temporal y radiométrica; sensores ópticos, de microondas pasivos y radar.
2. Precipitación por satélite: GPM IMERG, CHIRPS, PERSIANN, CMORPH. Validación contra estaciones del IMN y corrección de sesgo.
3. Evapotranspiración: MODIS MOD16, SSEBop, productos basados en balance de energía.
4. Humedad del suelo: SMAP, SMOS y ESA CCI.
5. Almacenamiento total de agua: GRACE y GRACE-FO.
6. Agua superficial y cuerpos de agua: Landsat, Sentinel-1 y 2, Global Surface Water, SWOT.
7. Cobertura y uso de la tierra, e índices como NDVI y NDWI, para parámetros hidrológicos (número de curva, coeficiente de escorrentía).
8. Modelos de elevación: SRTM, ALOS, Copernicus DEM; su efecto en la delimitación de cuencas.
9. Flujo de trabajo en R: descarga, recorte con la cuenca, series de tiempo y comparación con datos de campo (terra, sf, paquetes de acceso a datos).
10. Limitaciones: resolución frente al tamaño de las cuencas de Costa Rica, sesgo en zonas montañosas y nubosidad.

Las referencias se buscarán y verificarán al escribirlo.

## Mapas de Costa Rica con formato único

Rehacer todos los mapas de Costa Rica del libro con las coberturas oficiales del SNIT y el formato de los scripts de referencia del autor (CRTM05, EPSG:5367), usando `herramientas/mapas_cr.R`.

- Hecho (capítulo 4): cuencas hidrográficas y cobertura del suelo.
- Por hacer: mapas de los capítulos siguientes cuando se revisen (por ejemplo, las estaciones de la cuenca del río Grande de Térraba en el capítulo 13, que necesita las coordenadas de las estaciones), y los mapas de isoyetas y regiones del capítulo 2 si se consiguen los datos.
