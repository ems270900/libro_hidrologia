# Revisión del capítulo 8: verificación y completado de registros hidrológicos

Revisión hecha con `GUIA_ESTILO.md`. Los cuatro ejemplos se ejecutaron y el capítulo se renderiza sin avisos. El capítulo pasó de 4553 líneas a unas 600: los mismos métodos, sin código repetido.

## Estructura nueva

1. Relleno y extensión de registros.
2. Control de calidad (valores posibles, comparación con vecinas, homogeneidad).
3. Análisis de doble masa: factor de ajuste y pruebas de estabilidad de la media ($t$) y de la varianza ($F$).
4. Relleno: promedio aritmético, razón normal, inverso de la distancia y regresión lineal (con la ecuación de extensión que conserva la varianza).
5. Generación estocástica con el método de Thomas y Fiering.

## Errores técnicos corregidos

1. **Razón normal.** La primera forma de la ecuación tenía $P_x/\bar{P}_i$ en lugar de $\bar{P}_x/\bar{P}_i$. El procedimiento decía que el método se aplica "únicamente si se cumple el criterio del 10 %", que es al revés: la razón normal se usa cuando alguna normal difiere en más de 10 %.
2. **Doble masa, estación C.** El texto concluía que C tenía un quiebre en 1978. Con las pruebas del propio capítulo, ninguna rechaza la homogeneidad ($t_c = 0.86$, $F_c = 2.27$), así que C no se corrige. Ahora el ejemplo lo muestra como caso de quiebre aparente.
3. **Doble masa, estación D.** La conclusión no cambia (D es inconsistente desde 1979). El factor de ajuste pasa de 1.279 a 1.252, porque ahora la pendiente de cada tramo es el cociente de los acumulados del tramo, como en Searcy y Hardison (1960), en lugar de una regresión por el origen de los acumulados.
4. **Regresión entre dos estaciones de lluvia.** El ejemplo usaba 255 pares escritos a mano, pero la serie tiene 274 meses con dato en las dos estaciones. Con los 274: $r = 0.706$ (antes 0.765), $\hat{y} = 296.4 + 0.9486\,x$ (antes $293.47 + 1.0058\,x$). El ejemplo dice ahora que la correlación es significativa pero explica la mitad de la varianza.
5. **Thomas y Fiering.** Para rellenar se usa $Z = 0$ (valor esperado), y la serie sintética con $Z$ aleatorio se presenta como uso distinto, con una comprobación de que conserva medias y desviaciones. Antes se rellenaba con valores aleatorios y se medía la "bondad de ajuste" contra datos que no existían.
6. **Epígrafe.** La frase atribuida a Lord Kelvin ("Lo que no se define no se puede medir...") no aparece en sus obras. Se reemplazó por la frase verificada de su conferencia *Electrical units of measurement* (1883).
7. Se quitaron afirmaciones sin fuente: la recomendación del Servicio Meteorológico de Estados Unidos sobre el 10 % (el criterio es de Linsley et al., 1958), el método de cuadrantes atribuido al mismo servicio, el umbral $R^2 \ge 0.70$ y la "regla aceptada en manuales" sobre las pruebas.

## Datos

- `datos/lluvia_mensual_dos_estaciones.csv`: lluvia mensual de dos estaciones vecinas de montaña, 1986–2010. Por pedido del autor, las estaciones no se identifican.
- `datos/caudal_mensual_estacion_montana.csv`: caudal medio mensual de una estación de montaña, 32 años. Por pedido del autor, la estación no se identifica (los datos son de una institución y no deben usarse sin su permiso).

## Figuras y ejemplos

- Se conservó la figura de relleno y extensión (`fig-datos`).
- Figuras nuevas hechas en R: curvas de doble masa de C y D con la corrección, relleno de lluvia mensual (dispersión y serie) y relleno y generación de caudales en la estación de montaña.
- Ejemplos: doble masa (C y D), relleno de un mes con tres métodos (antes eran tres ejemplos separados con datos distintos), regresión lineal y Thomas y Fiering. Todos con "Solución:", pseudocódigo, código e interpretación.
- Se quitaron el ejemplo con datos simulados, que repetía el de las estaciones A a E, y el script final de Thomas y Fiering, que repetía el del ejemplo.

## Otros cambios

- Ecuaciones etiquetadas `eq-registros-*` (10) y secciones `sec-registros-*`.
- Una pregunta al lector al inicio de la doble masa.
- El inverso de la distancia remite a la ecuación del capítulo 7 en lugar de repetirla.
- La etiqueta `tbl-precip-promedio-multianual` estaba repetida en este capítulo y en el 7; quedó solo en el 7.

## Referencias nuevas

Searcy y Hardison (1960), Paulhus y Kohler (1952), Matalas y Jacobs (1964) y Thomas y Fiering (1962). Se completaron los autores de Linsley et al. (1958).

## Pendiente para el autor

- Resuelto (2026-11-20): las estaciones de caudal y de lluvia quedaron anónimas y los datos de las estaciones A a E y del ejemplo de relleno se presentan como hipotéticos, según el autor.

## Segunda entrega (observaciones del autor, 2026-11-20)

- Datos de los ejemplos: cada ejemplo que usa un archivo CSV muestra un botón para descargarlo (el archivo va incrustado en la página y funciona sin internet) y, en este capítulo, una vista previa paginada de la tabla. La función está en `R/ver_datos.R` (paquetes `xfun` y `DT`). También se agregó el botón al ejemplo de Tárcoles del capítulo 7.
- Prueba $t$ de la correlación: se conserva el cálculo con la fórmula y se agrega `cor.test()`, que da el mismo $t$, el valor p y el intervalo de confianza de $r$ (también en el capítulo 7).
- Thomas y Fiering: se conserva la versión paso a paso y se agrega la solución con el paquete `pcts` (PAR(1) con `fitPM()` y `sim_pc()`). Sus coeficientes son algo menores; julio de 2013 da 8.95 m³/s en lugar de 8.70.
- Figura del relleno: el panel de la serie tiene título en el eje x ("Año").
- Figura de Thomas y Fiering: la leyenda dice "Serie sintética (100 años)" en lugar de "100 años sintéticos".
- Referencia nueva: Boshnakov (2025), paquete `pcts`.
