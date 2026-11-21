# Revisión del capítulo 6: principios de meteorología y climatología

Revisión hecha con `GUIA_ESTILO.md`. Los tres ejemplos se ejecutaron y el capítulo se renderiza sin avisos.

## Resumen

| Indicador | Antes | Después |
|---|---|---|
| Ejemplos con "Solución:", pseudocódigo, R e interpretación | 0 | 3 |
| Ecuaciones con etiqueta `eq-` | 0 | 10 |
| Figuras propias hechas en R | 1 | 3 |
| Referencias nuevas en `references.bib` | | 13 |
| Subrayados `<u>`, `<span class="firebrick">`, `<br>` y notas al pie | 62 | 0 |

## Errores técnicos corregidos

1. **Inversión térmica.** Decía que la inversión crea "condiciones de gran inestabilidad". Es al revés: es la condición más estable. Estaba en dos lugares.
2. **Masa de la atmósfera.** Decía $5.8\times10^{14}$ t; el valor es $5.1\times10^{18}$ kg ($5.1\times10^{15}$ t) [@trenberth2005mass].
3. **Composición del aire (cuadro 6.2).** El CO₂ estaba en 0.036 % (valor de los años noventa); en 2019 era 0.041 % (410 ppm). El kriptón estaba en 0.001 % (es 0.0001 %) y el xenón en 0.00009 % (es 0.000009 %). Se agregaron metano, óxido nitroso, vapor de agua y ozono.
4. **Mezcla homogénea.** Decía que las proporciones se mantienen hasta 60 km; es hasta unos 100 km.
5. **Temperatura sin efecto invernadero.** Decía −40 °C; el valor de equilibrio es unos −18 °C (33 °C menos que la media observada). Ahora es un ejemplo resuelto.
6. **Efecto Foehn.** Lo definía como el ascenso orográfico. El efecto Foehn es el viento cálido y seco que baja por sotavento. La leyenda decía "gradientes de presión".
7. **Célula de Hadley.** Decía que el aire pierde la humedad en el flujo hacia los polos en altura. La lluvia cae en el ascenso, en la ZCIT. El chorro del Caribe estaba como quinto paso de la célula; ahora es una sección aparte.
8. **Gas ideal.** El texto nombraba la masa $m$ pero la ecuación usaba $n$; se definieron $R^*$ y $R_d$.
9. **Escalas atmosféricas.** Estaban en km² (área) y no coincidían con el cuadro, que estaba en km. Se unificó con la clasificación de Orlanski (1975).
10. **Nivel del mar.** Se cambió "1.5 a 3.2 mm/año" por los valores del IPCC (2021): 1.3 mm/año en 1901–1971 y 3.7 mm/año en 2006–2018.
11. **Escenarios.** Mencionaba RCP y SRES; se agregaron los SSP del sexto informe del IPCC.
12. **Cifras sin fuente que se quitaron:** duración media de El Niño (15.6 meses) y La Niña (19.6 meses), "el ENOS explica hasta el 40 % de la variabilidad" y "el 80 % de los años La Niña coincidieron con inundaciones en el Pacífico Norte".
13. **Epígrafe.** La frase atribuida a Rossby no se encontró en sus obras. Se reemplazó por la de Richardson (1922) sobre los remolinos, que además introduce las escalas del movimiento.

## Figuras

- Las cinco fotos de las capas de la atmósfera (WorldAtlas) y el perfil de temperatura ajeno se reemplazaron por una figura propia del perfil de la atmósfera estándar de 1976, con las capas y la presión (`fig-meteo-perfil`).
- El gráfico de barras de los gases (dos paneles con colores *turbo*) se reemplazó por un gráfico de puntos en escala logarítmica que resalta los gases de efecto invernadero.
- La captura de Google Maps de Nueva York y Madrid se reemplazó por un mapa propio (`fig-meteo-nueva-york-madrid`).
- Los cinturones de Van Allen pasaron a un recuadro "Para profundizar", porque no influyen en el ciclo del agua.

## Ejemplos nuevos

- Presión atmosférica y constante psicrométrica a 0, 1150 y 3400 m.
- Aire que cruza la cordillera de Talamanca (efecto Foehn).
- Temperatura de la Tierra sin efecto invernadero.

## Referencias nuevas

Richardson (1922), Wallace y Hobbs (2006), Trenberth y Smith (2005), atmósfera estándar de 1976 (NOAA, NASA y USAF), Kopp y Lean (2011), Lawrence (2005), Orlanski (1975), Amador (2008), Magaña et al. (1999), Trenberth et al. (2003), Milly et al. (2008), IPCC (2021) y la definición del ONI del Climate Prediction Center.

## Pendiente para el autor

- Las figuras `fig-calor`, `fig-latitud`, `fig-invernadero`, `fig-frente_frio` y `fig-conver_diver` no tienen fuente. Si son de otra obra, hay que agregarla.

## Segunda entrega (observaciones del autor, PR #23)

- La sección de corrientes oceánicas abre con una pregunta al lector: ¿por qué, si Nueva York y Madrid están casi en la misma latitud, los inviernos de Nueva York son mucho más fríos? Se creó el bloque `.pregunta` y se documentó en la guía de estilo.
- Se quitaron 61 negritas dentro de párrafos y listas. Quedan solo las etiquetas al inicio de cada elemento de lista y los rótulos de los ejemplos. El criterio quedó en la guía de estilo (sección 8).
