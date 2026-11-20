# Revisión del capítulo 13: intensidad, duración y frecuencia

Revisión hecha con `GUIA_ESTILO.md`. El código R de los ejemplos se ejecutó completo en una sesión limpia (R 4.3) y corre sin errores.

## Resumen

| Indicador | Antes | Después |
|---|---|---|
| Palabras (texto y código) | 12 067 | 7 910 |
| Avisos de `revisar_estilo.sh` | 120 | 8 |
| Citas bibliográficas | 13 | 21 |
| Marcas `CITA PENDIENTE` o `VERIFICAR` | 0 | 10 |
| Bloques de R | 25 | 17 |

La reducción de palabras viene sobre todo de tres cambios: se quitaron secciones repetidas, los cuadros de estaciones pasaron de código R a cuadros de Markdown y los cálculos se dejaron de copiar a mano en el código.

## Errores técnicos encontrados

Estos puntos cambian el contenido, no solo el estilo. Revísalos primero.

1. **El texto y el cuadro del bloque alterno no coincidían.** El texto ponía el bloque mayor en la posición 19 (minuto 95), pero el cuadro y el gráfico lo ponían en la 18 (minuto 90). El cuadro estaba bien calculado con la convención del bloque 18, así que se corrigió el texto. Los resultados no cambian.
2. **Intensidades del ejemplo del bloque alterno.** 680 mm/h en 5 min para $T = 10$ años equivale a 57 mm en 5 min, y la tormenta de 3 h suma 224 mm. Son valores muy altos para Costa Rica. No se cambiaron. **Necesito saber de dónde salen** para dejarlos o reemplazarlos por los de una estación real.
3. **"Forma tipo Wenzel" mal nombrada.** La ecuación $i = c/(d+f)^e$ es la de Sherman. La de Wenzel es $i = c/(d^e + f)$. Se renombró a Sherman.
4. **"Lluvia estratigráfica"** decía estratigráfica cuando debía decir estratiforme.
5. **La ecuación del factor de frecuencia** $X_T = \bar X + K_T S$ quedaba sin "donde" y sin explicar sus variables. Se completó.
6. **Explicación incorrecta de la limitación del bloque alterno.** El texto decía que el método "asume que las intensidades son independientes" y que eso contradice cómo se construyen las curvas IDF, lo que no tiene sentido. Se reescribió: el problema es que el método junta en una sola tormenta máximos que en la realidad vienen de tormentas distintas, así que la tormenta resultante es más rara que $T$.
7. **"Dado que las intensidades están expresadas para un Δt = 60 min"** era incorrecto. Las intensidades están en mm/h y la lámina es $i \cdot d/60$. Se corrigió.
8. **Cuadros con la cita equivocada.** Las estaciones de Térraba citaban a Murillo (1994) en vez de García (2015), y las estaciones automáticas del IMN citaban el boletín de estaciones mecánicas. Ya existía `Rojas2011automaticas` en el `.bib` y se usó esa.
9. **Error de aritmética menor.** $\ln(125/35) = 1.2730$ y no 1.2720. El resultado ($n \approx 0.545$) no cambia.
10. **Datos del ejemplo de ajuste sin usar.** El ejemplo generaba una serie sintética de 30 años de máximos anuales, con su cuadro y su gráfico, pero después no la usaba. Se quitó. En su lugar se agregó el paso 4: la regresión sobre toda la malla que el texto describía y que no se hacía.

## Citas que faltan o hay que verificar

Están marcadas en el capítulo con `<!-- CITA PENDIENTE -->` o `<!-- VERIFICAR -->`.

- **Universidad de Salamanca (2025):** el ejemplo de la banda de pluviógrafo dice que se tomó de ahí, pero la referencia no está en el `.bib`.
- **FHWA HDS-2 y HEC-22:** sustentan el uso del bloque alterno en drenaje menor.
- **ASCE (1996):** el texto tenía una cita textual entre comillas que no se pudo verificar. Se cambió por una paráfrasis. Si quieres la cita textual, falta la página.
- **NRCS, NEH 630:** hay que confirmar en qué sección trata el tema de las distribuciones de tormenta.
- **USBR (1989):** el límite de 250 km² para el bloque alterno. No se encontró la fuente y se quitó el número hasta confirmarlo.
- **SIECA:** la recomendación de usar el método con cautela en la región.
- **ASCE y USGS:** los estudios sobre hidrogramas con picos exagerados.
- **CORDEX:** el estudio sobre curvas IDF proyectadas para Costa Rica.
- **Talbot, Sherman y la forma potencial:** las referencias originales de cada ecuación.

Además, en el `.bib` los boletines `Rojas2011mecanicas` y `Rojas2011automaticas` están como tesis de maestría de la UCR. Por el texto parecen boletines del IMN. Conviene revisar el tipo de entrada.

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
