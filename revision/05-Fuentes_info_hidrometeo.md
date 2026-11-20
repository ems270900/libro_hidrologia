# Revisión del capítulo 5: fuentes de información hidrometeorológica

Revisión hecha con `GUIA_ESTILO.md`. Los cuatro ejemplos se ejecutaron y el capítulo se renderiza sin avisos.

## Resumen

| Indicador | Antes | Después |
|---|---|---|
| Ejemplos con "Solución:", pseudocódigo, R e interpretación | 0 | 4 |
| Ecuaciones con etiqueta `eq-` | 0 | 21 |
| Referencias nuevas en `references.bib` | | 12 |
| Marcas `CITA PENDIENTE` o `VERIFICAR` | | 0 |
| Subrayados `<u>`, `<br>` y avisos en color | 75 | 0 |

## Errores técnicos corregidos

Estos puntos cambian el contenido.

1. **Humedad gravimétrica y volumétrica invertidas.** Decía $w = M_s/M_w$ y $\theta = V_t/V_w$. Lo correcto es $w = M_w/M_s$ y $\theta = V_w/V_t$.
2. **Conversión de humedad invertida.** Decía $\theta = w\,\rho_w/\rho_b$. Lo correcto es $\theta = w\,\rho_b/\rho_w$.
3. **Permeámetro de carga variable.** Decía $K = (R^2/(r^2 L)) \ln(H_2/H_1)$: faltaba el tiempo, los radios estaban invertidos, $L$ iba en el denominador y el logaritmo daba negativo. Lo correcto es $K = \frac{a L}{A t} \ln(H_1/H_2)$ [@freeze1979groundwater].
4. **Presión y evaporación.** La nota al pie explicaba la ley de Dalton de las presiones parciales, que no es la relación entre evaporación y presión. Se quitó la nota y se citó a Chow. La lista decía "tres razones" y tenía dos.
5. **Nubes.** Decía "tres géneros" y listaba cuatro; ahora son cuatro raíces latinas. La altura de los cirros (más de 9000 m) se cambió a más de unos 6000 m en el trópico, que coincide con la figura.
6. **Leyendas que no coincidían con la imagen.** El "mapa de isoyetas" es la lluvia de un día (28 de junio de 2022, datos preliminares). El mapa de CHIRPS es la lluvia media de mayo a agosto, no la anual. La figura de sondas TDR incluye una sonda capacitiva y viene de un artículo sobre sensores capacitivos.
7. **Error en una imagen del IMN.** La @fig-viento dice "1 kn es igual a 1.94384 m/s"; es al revés. No se puede corregir la imagen, así que se agregó un recuadro de Cuidado.
8. **Tanque clase A.** Diámetro de 120.7 cm según FAO-56 (decía 1.21 m; el capítulo 14 dice 121.9 cm y conviene uniformarlo al revisarlo).
9. **Curva de descarga.** El gráfico simulaba una curva logarítmica que no era la potencial del texto. Se reemplazó por un ejemplo de ajuste de $Q = a(h - h_0)^n$.
10. **Nubosidad en décimos.** Se pasó a octas, la unidad de la OMM. El techo de nubes se define como la capa que cubre más de la mitad del cielo, y se agregó el ceilómetro.
11. **Radar.** Se agregó la relación de Marshall y Palmer ($a = 200$, $b = 1.6$) junto a la convectiva ($a = 300$, $b = 1.4$), con sus fuentes.
12. **Calidad del agua.** Se quitaron "letales para la biota" y el umbral de 5 mg/L de oxígeno, sin fuente. Se citó el reglamento de Costa Rica (Decreto 33903-MINAE-S) para el pH de 6.5 a 8.5.
13. **Epígrafe.** La frase atribuida a Horton no aparece en sus obras. Se reemplazó por la de lord Kelvin (1883).

## Ejemplos nuevos

- Humedad relativa a partir del punto de rocío (FAO-56).
- Conductividad hidráulica con el permeámetro de carga variable.
- Aforo por velocidad y área (sección media).
- Ajuste de una curva de descarga por regresión logarítmica.

Los datos de los ejemplos son de ejemplo y así se dice en el planteamiento.

## Referencias nuevas

FAO-56 (Allen et al., 1998), guía de instrumentos de la OMM (WMO-No. 8), manual de aforos de la OMM (WMO-No. 1044), Marshall y Palmer (1948), Fulton et al. (1998), Le Treut et al. (2007), Freeze y Cherry (1979), Peterson y Hennessey (1978), Kargas y Soulis (2012), Rheinheimer y Yarnell (2017), Global Solar Atlas y el Decreto 33903-MINAE-S. Se corrigió además la codificación de la entrada `CIEDES_UCR`.

Algunas figuras citan su fuente en texto plano porque es un sitio web sin autor ni fecha verificables: INETER, Seiscubos, Guías Prácticas, AEMET, Meteoblue, Dirección Meteorológica de Chile, Hanna Instruments y Biostats.

## Pendiente para el autor

- Hecho: la @fig-cr_estaciones se rehízo con `herramientas/mapas_cr.R` y el inventario de 1265 estaciones del visor de la UCR (`datos/mapas/estaciones_cr.gpkg`).
- La etiqueta `fig-aforo` existía en los capítulos 2 y 5; la del capítulo 5 pasó a `fig-aforo-seccion` (no se citaba en ningún otro lado).
