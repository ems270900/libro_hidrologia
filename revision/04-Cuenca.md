# Revisión del capítulo 4: la cuenca como unidad hidrológica

Revisión hecha con `GUIA_ESTILO.md`. El código R de los ejemplos se ejecutó completo y el capítulo se renderiza sin avisos.

## Resumen

| Indicador | Antes | Después |
|---|---|---|
| Palabras (texto y código) | 14 038 | 8 803 |
| Avisos de `revisar_estilo.sh` | 218 | 13 |
| Ejemplos con R completos (planteamiento, pseudocódigo, código, interpretación) | 0 | 6 |
| Referencias nuevas en `references.bib` | | 6 |
| Marcas `CITA PENDIENTE` o `VERIFICAR` | 0 | 12 |

La reducción viene de quitar repeticiones (la definición de cuenca y de sistema aparecía tres veces), de pasar los cuadros de clasificación de código R a cuadros de Markdown y de reescribir los ejemplos para que R calcule en lugar de copiar resultados.

## Errores técnicos encontrados

Estos puntos cambian el contenido. Revísalos primero.

1. **Curva hipsométrica al revés.** El texto asignaba la curva cóncava a la cuenca joven y la convexa a la vieja. Según Strahler (1952) es al contrario: convexa = joven, en S = madura, cóncava = vieja. Se corrigió el texto. Hay que revisar si la figura `hipso.png` también lo tiene al revés (quedó un `VERIFICAR`).
2. **Ecuación de Taylor y Schwarz invertida.** Para tramos iguales decía $S_3 = [\frac{1}{m}\sum 1/\sqrt{S_i}]^2$, que da el inverso de una pendiente. La correcta es $S_3 = [m / \sum 1/\sqrt{S_i}]^2$. En el ejemplo, la ecuación escrita también estaba invertida ($[\sum/L]^2$), aunque el resultado (0.0301) era el correcto. El apellido es Schwarz, no Schwartz.
3. **Método de Horton para la pendiente de laderas invertido.** Decía $P = \sum L/(n\,e)$. La correcta es $S = n\,e/\sum L$.
4. **Ejemplo de densidad de drenaje.** El planteamiento daba $\sum L = 26.06$ km y el cálculo usaba 86.06 km. Se dejó 86.06 km, que es el que da el resultado del texto (1.63 km/km²).
5. **Ejemplo del índice de pendiente.** La suma empezaba en $i = 2$ y dejaba fuera la primera franja; el cuadro mezclaba "intervalos de pendiente" con franjas de elevación y tenía una columna sin uso. Se rehízo con franjas de 100 m y la suma sobre todas: $I_p = 0.142$ (antes 0.122).
6. **Ejemplo de la curva hipsométrica.** El código emparejaba el área acumulada de cada franja con la cota de arriba, desplazando la curva una franja, y no incluía el punto de 100 %. Se corrigió y se agregó el cálculo de la elevación mediana (687 m).
7. **Ejemplo del histograma de elevaciones.** El área por debajo de 200 m (5.2 km²) no aparecía en ningún intervalo, así que los porcentajes sumaban 90 %. Se agregó el intervalo "menos de 200 m".
8. **Histograma del río La Estrella.** Las clases se calculaban con `floor(elevacion/20)*20` y daban rótulos como "80 - 100" para intervalos de 100 m. Se corrigieron los rótulos.
9. **Coeficiente de compacidad.** Decía que "valores mayores a 1 corresponden a cuencas alargadas", pero todo $K_c$ es mayor o igual a 1. Se reescribió: cuanto más se aleja de 1, más alargada o irregular es la cuenca. Se agregó la definición exacta $P/(2\sqrt{\pi A})$, de donde sale el 0.28.
10. **Rectángulo equivalente.** Se agregó que solo tiene solución si $K_c \geq 1.12$.
11. **Sinuosidad.** El texto llamaba *thalweg* al eje del valle; el *thalweg* es la línea más profunda del cauce. La interpretación del ejemplo ($S = 1.5$, "sinuosidad moderada con meandros bien desarrollados") se ajustó al umbral de 1.5 de Leopold y Wolman (1957).
12. **Cauces trenzados "o con anastomosis".** Son dos tipos distintos. Se separaron y se agregó un recuadro de Cuidado.
13. **Mapa de cobertura** atribuido a la Sociedad Geológica de Costa Rica. Se quitó la atribución y se marcó como pendiente.
14. **"La vegetación y litosfera"** con una nota al pie que definía la litosfera. Se cambió por "la vegetación y el suelo".
15. **Patrones de drenaje.** Se quitaron afirmaciones sin fuente (márgenes continentales con "crestas del manto", el drenaje centrífugo "en el interior de grandes meandros") y se agregó el patrón distributario.

## Citas

| Pendiente | Cómo se resolvió |
|---|---|
| Epígrafe | Es de Gary Snyder (no "Snider"), del ensayo "Coming into the Watershed", en *A Place in Space* (1995). |
| Orden de cauces y razón de bifurcación | Se citan Horton (1945) y Strahler (1957), con el intervalo típico de 3 a 5 para $R_b$. |
| Curva hipsométrica | Strahler (1952). |
| Sinuosidad | Leopold y Wolman (1957). |
| Rectángulo equivalente e índice de pendiente | Roche (1963). |
| Pendiente de Taylor y Schwarz | Taylor y Schwarz (1952). |
| Rangos de $K_c$, $K_f$, densidad de drenaje y clases de pendiente; intercepción de 10 % a 30 %; Mundo GIS, SNIT, mapa geológico y mapa de cobertura | Sin fuente verificable. Quedaron como `CITA PENDIENTE`. |

## Cambios de estilo

- 27 subrayados, 17 `<br>`, 3 textos en rojo y una exclamación pasaron a texto normal, negrita o recuadros.
- "Escurrimiento" pasó a "escorrentía" y "período" a "periodo".
- Todas las ecuaciones tienen etiqueta (`@eq-cuenca-…`) y "donde" con unidades; todas las secciones tienen `{#sec-cuenca-…}`.
- Leyendas con `Fuente: @clave.` y `fig-alt`; se corrigieron erratas en las leyendas ("Cuendas", "Delmitación", "cuaces").
- Tres recuadros de Cuidado nuevos: el punto de control en el SIG, la dependencia de la densidad de drenaje con la escala y la diferencia entre cauces trenzados y anastomosados.
- La nota histórica sobre las leyes de Horton pasó a un recuadro "Para profundizar".

## Cambios en el código R

- Seis ejemplos con planteamiento, pseudocódigo, código autocontenido e interpretación: razón de bifurcación, histograma de elevaciones, curva hipsométrica, rectángulo equivalente, índice de pendiente y pendiente de Taylor y Schwarz.
- Los ejemplos calculan; ya no hay resultados escritos a mano dentro de `tribble()`.
- Nombres sin tildes ni comillas invertidas (`n_cauces`, `area_km2`, `cota_mediana`).
- Los cuadros de clasificación son cuadros de Markdown, no código R.

## Segunda pasada (2026-11-20)

Observaciones del autor y verificación de fuentes:

- **Punto 11 (thalweg).** Se conserva el término *thalweg* por pedido del autor, ahora definido como la línea que une los puntos más profundos del cauce, y $L$ se mide a lo largo de él.
- **Razón de bifurcación.** La frase "entre 3 y 5" no aparece en Strahler (1957). Se reemplazó por lo que el artículo sí reporta: 4.0 a 5.1 entre los órdenes 1 y 2, y 2.8 a 4.9 entre los órdenes 2 y 3.
- **Curva hipsométrica.** Strahler (1957) nombra las etapas de desequilibrio (joven), equilibrio (madura) y monadnock. La figura hipso.png ya asigna la curva convexa a la juventud y la cóncava a la vejez, de modo que se quitó la marca VERIFICAR.
- **Método de Horton y Taylor-Schwarz.** Las formas de las ecuaciones coinciden con las de Aparicio (1992, cap. 2), que ahora se cita junto con Taylor y Schwarz (1952). Se añadió la nota sobre $\sec\theta$ del criterio de Horton. Queda por confirmar el número de página.
- **Citas pendientes que siguen abiertas.** No se encontró una fuente verificable para los rangos de $K_c$, las clases de $K_f$ (el texto de la UPS, Ecuador, trae un cuadro pero contradice su propio texto), el rango típico de $D_d$ ni las clases de pendiente. Se dejan marcadas en lugar de inventarlas. La figura de cobertura y el mapa geológico se resolverán al rehacer los mapas con las coberturas oficiales del SNIT.
