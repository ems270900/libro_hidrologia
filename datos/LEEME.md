# Datos del libro

- `mapas/`: capas geográficas de Costa Rica (ver `mapas/LEEME.md`).
- `precipitacion_zonal_gpcp.csv`: precipitación media anual por banda de latitud de 2.5°, promedio de todas las longitudes (tierra y océano), periodo 1991–2020. Columnas: `lat` (centro de la banda, grados; negativo al sur) y `p_mm_anio` (mm/año). Se calculó con la climatología mensual GPCP versión 2.3 (`precip.mon.ltm.1991-2020.nc`, NOAA PSL, https://psl.noaa.gov/data/gridded/data.gpcp.html): promedio de los 12 meses en mm/d por 365.25 y promedio zonal. Referencia: Adler et al. (2018). Se usa en la figura de distribución de la precipitación por latitud del capítulo 7.
