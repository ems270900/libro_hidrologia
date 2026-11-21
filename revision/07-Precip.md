# Revisión del capítulo 7: precipitación

Revisión hecha con `GUIA_ESTILO.md`. Los cinco ejemplos se ejecutaron y el capítulo se renderiza sin avisos.

## Figuras nuevas

Pedidas por el autor:

- **Figura 7.1** (formación de la lluvia). Se rehízo desde cero en R: tamaño, concentración y velocidad de caída del núcleo de condensación, la gota de nube y la gota de lluvia, con los procesos que las unen [@wallace2006atmospheric].
- **Figura 7.3** (lluvia por latitud). La anterior estaba en pulgadas y centímetros y no tenía fuente. Se rehízo en mm/año con datos reales de la climatología GPCP versión 2.3, 1991–2020 [@adler2018gpcp]. Los datos están en `datos/precipitacion_zonal_gpcp.csv` (ver `datos/LEEME.md`). Marca la ZCIT, los subtrópicos, las latitudes medias, los polos, la media global (983 mm) y la franja de Costa Rica.
- **Figura 7.8** (hietograma). Se rehicieron el hietograma y la curva masa a partir de un ejemplo resuelto con R, de modo que las dos figuras muestran la misma tormenta. Las anteriores estaban en inglés, con la curva masa en centímetros. Ahora el hietograma es la figura 7.7 y la curva masa la 7.8.

## Errores técnicos corregidos

1. **Frecuencia.** Se definía como "número probable de años", que es el periodo de retorno. Ahora se define como probabilidad de excedencia $p$, con $T = 1/p$.
2. **Thiessen.** Decía que el método asume "una variación lineal entre estaciones". Asume lluvia constante dentro de cada polígono.
3. **Epígrafe.** La frase atribuida a Bob Marley no tiene fuente verificable (también se atribuye a Roger Miller). Se reemplazó por Job 36:27.
4. **Ejemplo de Thiessen.** Los aportes a mano se uniformaron con los pesos redondeados (3.43 mm, sin cambio en el resultado).
5. **Ejercicio sin solución.** El "Ejemplo" de la cuenca hexagonal no tenía solución; ahora es un ejercicio propuesto, y el inverso de la distancia tiene su propio ejemplo resuelto.

## Ejemplos

- Hietograma, curva masa e intensidades máximas de 10, 30 y 60 min (nuevo).
- Precipitación media con polígonos de Thiessen (con código R).
- Precipitación media con isoyetas (con pseudocódigo y código R; se separó el cuadro del cálculo).
- Lluvia en un punto con el inverso del cuadrado de la distancia (nuevo).

## Otros cambios

- Ecuaciones etiquetadas `eq-precip-*` (7) y secciones `sec-precip-*`.
- Sin `<br>`, `<span class="firebrick">` ni estilos en línea.
- Los estudios de Costa Rica (Murillo, 1994; Maroto, 2011; Sandí, 2012) se citan desde `references.bib`.
- El video de YouTube pasó a un recuadro "En la práctica", con título descriptivo.
- `fig-niño` pasó a `fig-precip-enos` (no se citaba en otros capítulos).

## Referencias nuevas

Adler et al. (2018) y Trenberth et al. (2007).

## Segunda entrega (observaciones del autor, PR #23)

- Se volvió al epígrafe original ("Algunas personas sienten la lluvia. Otras solo se mojan."). Como no se encontró una fuente que confirme que es de Bob Marley (también se atribuye a Roger Miller), la firma dice "Frase popular, atribuida a Bob Marley".
- Se quitaron 15 negritas dentro de párrafos y listas.
- Figura 7.3: se marcó el máximo de la ZCIT (2213 mm a 6° N), el eje dice "Ecuador" en lugar de 0°, y se movieron las etiquetas que tocaban la curva y la línea de la media global.

## Tercera entrega (observaciones del autor, PR #25)

- **Factor de reducción por área** (sección nueva): definición, ecuación de Leclerc y Schaake (1972) para las curvas del Technical Paper 29 en unidades métricas (Allen y DeGaetano, 2002), figura del factor contra el área para 1, 3, 6 y 24 h, ejemplo resuelto (cuenca de 300 km²) y recuadro "Cuidado" sobre sus límites.
- **Ejemplo de lluvia contra altitud** con diez estaciones del IMN en la cuenca del río Grande de Tárcoles. Las normales se obtuvieron de los boletines meteorológicos mensuales de 2017 y 2018 (lluvia del mes menos anomalía); los datos están en `datos/lluvia_normal_tarcoles_imn.csv`. Resultado: $r = 0.36$, no significativo; en esta cuenca pesa más la posición respecto de la cordillera que la altitud.
- **Precipitación máxima probable:** queda como capítulo aparte (ver `pendientes.md`); el capítulo 7 la menciona en una oración.
- Referencias nuevas: U.S. Weather Bureau (1957), Leclerc y Schaake (1972), Allen y DeGaetano (2002) e IMN (2017, 2018).

## Qué le faltaba al capítulo (segunda entrega)

El capítulo cubre lo que se necesita antes de los capítulos de estadística e IDF. Lo que se podía agregar, en orden de utilidad para el diseño (los puntos 1 y 2 se hicieron en la tercera entrega y el 3 pasó a un capítulo aparte):

1. **Factor de reducción por área.** La lluvia de diseño de una estación es puntual; en cuencas de más de unos 25 km² la lluvia media de la misma tormenta es menor. Falta explicar el factor y dar un ejemplo.
2. **Ejemplo de regresión lluvia-altitud** con estaciones reales de una cuenca de Costa Rica (@eq-precip-altitud), con el inventario de `datos/mapas/estaciones_cr.gpkg` y lluvias de una fuente publicada.
3. **Precipitación máxima probable**, al menos su definición, si no se trata en otro capítulo.

La consistencia de registros (curva doble masa) y el relleno de datos van en el capítulo 8.
