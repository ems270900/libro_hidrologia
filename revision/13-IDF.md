# Revisión del capítulo 13: intensidad, duración y frecuencia

Revisión hecha con `GUIA_ESTILO.md`. El código R de los ejemplos se ejecutó completo en una sesión limpia (R 4.3) y corre sin errores.

## Resumen

| Indicador | Antes | Después |
|---|---|---|
| Palabras (texto y código) | 12 067 | 7 552 |
| Avisos de `revisar_estilo.sh` | 120 | 8 |
| Citas bibliográficas | 13 | 26 |
| Marcas `CITA PENDIENTE` o `VERIFICAR` | 0 | 0 |
| Bloques de R | 25 | 14 |

La reducción de palabras viene sobre todo de tres cambios: se quitaron secciones repetidas, los cuadros de estaciones pasaron de código R a cuadros de Markdown y los cálculos se dejaron de copiar a mano en el código.

## Errores técnicos encontrados

Estos puntos cambian el contenido, no solo el estilo. Revísalos primero.

1. **El texto y el cuadro del bloque alterno no coincidían.** El texto ponía el bloque mayor en la posición 19 (minuto 95), pero el cuadro y el gráfico lo ponían en la 18 (minuto 90). El cuadro estaba bien calculado con la convención del bloque 18, así que se corrigió el texto. Los resultados no cambian.
2. **Las intensidades del ejemplo del bloque alterno eran inventadas** y demasiado altas: 680 mm/h en 5 min para $T = 10$ años. Se reemplazaron por las curvas IDF oficiales de la estación 84-141 IMN-Aranjuez, tomadas del boletín del IMN de estaciones automáticas, que da una intensidad de 136 mm/h en 5 min para el mismo periodo de retorno. Como el boletín solo cubre duraciones de hasta 30 min, el ejemplo ahora usa una tormenta de 30 min en lugar de una de 3 h.
3. **"Forma tipo Wenzel" mal nombrada.** La ecuación $i = c/(d+f)^e$ es la de Sherman. La de Wenzel es $i = c/(d^e + f)$. Se renombró a Sherman.
4. **"Lluvia estratigráfica"** decía estratigráfica cuando debía decir estratiforme.
5. **La ecuación del factor de frecuencia** $X_T = \bar X + K_T S$ quedaba sin "donde" y sin explicar sus variables. Se completó.
6. **Explicación incorrecta de la limitación del bloque alterno.** El texto decía que el método "asume que las intensidades son independientes" y que eso contradice cómo se construyen las curvas IDF, lo que no tiene sentido. Se reescribió: el problema es que el método junta en una sola tormenta máximos que en la realidad vienen de tormentas distintas, así que la tormenta resultante es más rara que $T$.
7. **"Dado que las intensidades están expresadas para un Δt = 60 min"** era incorrecto. Las intensidades están en mm/h y la lámina es $i \cdot d/60$. Se corrigió.
8. **Cuadros con la cita equivocada.** Las estaciones de Térraba citaban a Murillo (1994) en vez de García (2015), y las estaciones automáticas del IMN citaban el boletín de estaciones mecánicas. Ya existía `Rojas2011automaticas` en el `.bib` y se usó esa.
9. **Error de aritmética menor.** $\ln(125/35) = 1.2730$ y no 1.2720. El resultado ($n \approx 0.545$) no cambia.
10. **Datos del ejemplo de ajuste sin usar.** El ejemplo generaba una serie sintética de 30 años de máximos anuales, con su cuadro y su gráfico, pero después no la usaba. Se quitó. En su lugar se agregó el paso 4: la regresión sobre toda la malla que el texto describía y que no se hacía.

## Citas resueltas

| Pendiente | Cómo se resolvió |
|---|---|
| Datos del ejemplo del bloque alterno | Se usan las curvas oficiales del IMN, estación 84-141 (`Rojas2011automaticas`). |
| CORDEX | Se cita a @mendez2024bias (*Water* 16(23), 3473). |
| Talbot, Sherman y la forma potencial | Se cita a @sherman1931frequency, y a @koutsoyiannis1998idf como marco general de todas las formas. |
| NRCS, distribuciones de tormenta | Se cita el capítulo 4 del NEH 630 (`nrcs2019neh630cap4`). |
| FHWA HDS-2 y HEC-22, frase textual de ASCE, USBR (250 km²), SIECA y "estudios ASCE/USGS" | No se pudo confirmar que esas fuentes digan lo que el texto les atribuía. Se quitaron las atribuciones y se dejó el razonamiento técnico, que se sostiene solo. El límite de 250 km² se eliminó. |

**Universidad de Salamanca:** el ejemplo de la banda viene de la práctica "Construcción de un hietograma y de una curva I-D" del sitio de hidrología de la Universidad de Salamanca (hidrologia.usal.es), donde aparecen la lectura entre las 14 y las 15 h y el valor de 1.2 mm en 10 min. El PDF no muestra autor ni año; se atribuyó a F. Javier Sánchez San Román, autor de ese sitio. Las figuras de la banda llevan ahora "Fuente: adaptado de".

Además, en el `.bib` los boletines `Rojas2011mecanicas` y `Rojas2011automaticas` estaban como tesis de maestría de la UCR de "Rojas (2011)". Edwin confirmó (2026-11-20) que el autor es el IMN. Ninguno de los dos PDF trae año de publicación: el de estaciones mecánicas usa datos hasta 2010 y los PDF se generaron en 2014. Quedaron como informes técnicos del IMN sin fecha (s. f.). Las claves no cambiaron.

## Cambios de estilo

- **Redundancia.** Las tres variables (intensidad, duración y periodo de retorno) se definían dos veces seguidas, y $p = 1/T$ aparecía tres veces. Ahora se definen una vez. La advertencia sobre el periodo de retorno pasó a un recuadro de Cuidado.
- **Muletillas.** "fundamental" pasó de 8 apariciones a 0, "permite" de 13 a 2, "de forma/manera" de 13 a 0 y "enfoque" de 7 a 0. También se quitaron los párrafos de cierre del tipo "esto es lo que distingue a un analista experto".
- **Formato.** Se quitaron 18 subrayados, los `<br>` y los `<span>` en las leyendas. Las ecuaciones que se citan tienen etiqueta (`@eq-idf-…`), cada sección tiene `{#sec-idf-…}` y la nota al pie larga sobre el hietograma de diseño se pasó al texto.
- **Títulos.** "Procesamiento de Datos Pluviográficos" pasó a "Procesamiento de registros pluviográficos", siguiendo la regla de mayúsculas.
- **Epígrafe.** La frase atribuida a Shakespeare sí existe: es de *Ricardo II*, acto II, escena 1 ("Small showers last long, but sudden storms are short"). Se tradujo con más fidelidad y se puso la fuente.

## Cambios en el código R

- **Los ejemplos calculan, ya no copian resultados.** El hietograma de la banda se calcula a partir de las lecturas, con la corrección del sifón. La curva de masa y el reordenamiento del bloque alterno se calculan desde la tabla IDF. Antes eran tres tablas escritas a mano, y los resultados coinciden con ellas.
- **Cálculo separado del formato.** Los bloques visibles hacen el cálculo y los bloques de `kbl()` van ocultos.
- **Nombres sin tildes ni comillas invertidas** (`d_min`, `t_ret`, `i_mmh`). La variable `c` pasó a `c_idf` para no tapar la función `c()`.
- **Paquetes que sobraban.** Se quitaron `viridis` (ggplot2 ya trae `scale_color_viridis_d`) y `moments` (no se usaba).
- **Títulos dentro de los gráficos.** Se quitaron porque repetían la leyenda de la figura.
- **Pseudocódigo e interpretación** en los tres ejemplos.
