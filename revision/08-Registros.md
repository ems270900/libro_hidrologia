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
4. **Regresión El Destierro y Tres de Junio.** El ejemplo usaba 255 pares escritos a mano, pero la serie tiene 274 meses con dato en las dos estaciones. Con los 274: $r = 0.706$ (antes 0.765), $\hat{y} = 296.4 + 0.9486\,x$ (antes $293.47 + 1.0058\,x$). El ejemplo dice ahora que la correlación es significativa pero explica la mitad de la varianza.
5. **Thomas y Fiering.** Para rellenar se usa $Z = 0$ (valor esperado), y la serie sintética con $Z$ aleatorio se presenta como uso distinto, con una comprobación de que conserva medias y desviaciones. Antes se rellenaba con valores aleatorios y se medía la "bondad de ajuste" contra datos que no existían.
6. **Epígrafe.** La frase atribuida a Lord Kelvin ("Lo que no se define no se puede medir...") no aparece en sus obras. Se reemplazó por la frase verificada de su conferencia *Electrical units of measurement* (1883).
7. Se quitaron afirmaciones sin fuente: la recomendación del Servicio Meteorológico de Estados Unidos sobre el 10 % (el criterio es de Linsley et al., 1958), el método de cuadrantes atribuido al mismo servicio, el umbral $R^2 \ge 0.70$ y la "regla aceptada en manuales" sobre las pruebas.

## Datos

- `datos/lluvia_mensual_tres_junio_destierro.csv`: lluvia mensual de las estaciones 73039 Tres de Junio y 73037 El Destierro (ICE), 1986–2010. Antes estaba escrita dentro del capítulo, dos veces.
- `datos/caudal_mensual_tapanti.csv`: caudal medio mensual de la estación 0922 Tapantí Arriba, 1992–2023.

## Figuras y ejemplos

- Se conservó la figura de relleno y extensión (`fig-datos`).
- Figuras nuevas hechas en R: curvas de doble masa de C y D con la corrección, relleno de El Destierro (dispersión y serie) y relleno y generación en Tapantí.
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

- Confirmar la institución que opera la estación 0922 Tapantí Arriba y el periodo exacto del registro, para citarlo en el ejemplo.
- Los datos de las estaciones A a E y del ejemplo de relleno son de ejemplo. Si vienen de otro libro, hay que citarlo.
