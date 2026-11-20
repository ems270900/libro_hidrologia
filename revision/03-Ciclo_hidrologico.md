# Revisión del capítulo 3: el ciclo hidrológico

Revisión hecha con `GUIA_ESTILO.md`. El código R del cuadro se ejecutó y el capítulo se renderizó sin avisos.

## Resumen

| Indicador | Antes | Después |
|---|---|---|
| Palabras (texto y código) | 2 227 | 1 611 |
| Avisos de `revisar_estilo.sh` | 33 | 5 |
| Citas nuevas en `references.bib` | | 3 |
| Marcas `CITA PENDIENTE` o `VERIFICAR` | 0 | 1 |

## Errores técnicos encontrados

1. **Extensión de la hidrosfera.** El texto decía que llega "hasta un kilómetro por debajo de la litosfera". Según Chow et al. (1988), se extiende unos 15 km hacia la atmósfera y cerca de 1 km *dentro* de la litosfera. Se corrigió y se citó.
2. **Ecuación de agua virtual inventada.** La "disponibilidad hídrica total = (P − ET − Q) + (VW_import − VW_export)" no viene de ninguna fuente, mezcla un balance físico con un flujo comercial y su "donde" definía ΔS, que no aparece en la ecuación. Se quitó. Se mantiene el concepto, con la aclaración de que el comercio no cambia el balance de la cuenca, solo la presión sobre sus fuentes.
3. **Cuadro de agua virtual sin fuente.** Los rangos (trigo 1 000 a 1 500 L/kg, carne de res 5 000 a 13 500 L/kg, "1 caloría = 1 litro", microchip 8 622 L) no tenían cita. Se reemplazaron por los promedios mundiales de Mekonnen y Hoekstra: trigo 1 827 L/kg (2011) y carne de res 15 400 L/kg (2012). Se quitaron las filas que no tienen fuente.
4. **Salidas de la cuenca incompletas.** Faltaban el caudal en el punto de control, que es la salida principal, y las extracciones y transvases hacia otras cuencas. Se agregaron. La infiltración profunda se precisó: es salida solo si recarga acuíferos que drenan fuera de la cuenca.
5. **Ecuación del embalse sin variables.** $S_t = S_{t-1} + X_t - Y_t$ no explicaba $X_t$ ni $Y_t$. Se agregó el "donde" con unidades y la ecuación tiene etiqueta (`@eq-ciclo-embalse`). La ecuación de continuidad también (`@eq-ciclo-continuidad`).
6. **"San Pablo, en Brasil".** Es São Paulo.
7. **Diagrama de Rippl sin explicación.** La figura aparecía sin decir qué es. Se agregó una frase.

## Citas

| Pendiente | Cómo se resolvió |
|---|---|
| Origen del concepto de agua virtual | @allan1998virtual (*Ground Water* 36(4), 545–546). |
| Valores de agua virtual | @mekonnen2011green (*HESS* 15, 1577–1600) y @mekonnen2012animal (*Ecosystems* 15, 401–415). |
| Extensión de la hidrosfera | @chow1988appliedhydrology. |
| Epígrafe de Cousteau | `VERIFICAR`: la frase se le atribuye en muchas recopilaciones, pero no se encontró la obra original. |

## Cambios de estilo

- Título "El Ciclo Hidrológico" pasó a "El ciclo hidrológico".
- Se quitaron tres párrafos de introducción que repetían la definición del ciclo y la nota al pie larga sobre el balance hídrico, que pasó al texto en una frase.
- `firebrick` y `<u>` pasaron a negrita.
- Leyendas al formato `Fuente: @clave.` (antes "Tomado de:"), con `fig-alt`.
- Secciones con etiqueta `{#sec-ciclo-…}`. Las etiquetas de figuras y cuadros no cambiaron.
