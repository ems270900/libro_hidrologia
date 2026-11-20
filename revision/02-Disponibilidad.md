# Revisión del capítulo 2: disponibilidad del recurso hídrico

Revisión hecha con `GUIA_ESTILO.md`. El capítulo se renderizó sin avisos.

## Resumen

| Indicador | Antes | Después |
|---|---|---|
| Palabras (texto y código) | 2 553 | 2 249 |
| Avisos de `revisar_estilo.sh` | 67 | 9 |
| Marcas `CITA PENDIENTE` o `VERIFICAR` | 0 | 1 |

## Errores técnicos encontrados

1. **Sección repetida.** "Variabilidad espacial del recurso hídrico" aparecía dos veces con casi el mismo contenido. Se dejó una sola, con los factores de las dos versiones (clima, relieve, cercanía al mar y geología).
2. **Fila mal nombrada en el cuadro de distribución del agua.** La fila de 47 971 710 km³ (3.5 %) decía "Aguas superficiales", pero ese volumen es el total del agua en los continentes, incluida la subterránea y el hielo. Se renombró a "Agua en los continentes (total)". Los valores no cambian.
3. **Separador de miles.** El cuadro usaba punto como separador de miles (1.338.000.000), que se confunde con el punto decimal del libro. Pasó a espacio (1 338 000 000).
4. **Epígrafe de Thomas Fuller.** Se cambió la fecha de vida por la obra donde aparece la frase (*Gnomologia*, 1732).
5. **Ejemplo del Pacífico Norte.** El texto decía que la accesibilidad era limitada "pese a la abundancia relativa". Se reescribió para que quede clara la causa: la lluvia se concentra en pocos meses y no hay capacidad para guardar el agua para la estación seca.

## Pendientes

| Pendiente | Estado |
|---|---|
| Tiempos de residencia | `VERIFICAR`: el cuadro (tomado de Maidment, 1993) da 20 000 años para el agua subterránea y 17 días para los ríos, y el texto da 1400 a 10 000 años y 16 días. Hay que confirmar en la fuente y unificar. No se cambiaron las cifras. |

## Cambios de estilo

- Muletillas: "fundamental", "permite", "de manera significativa", "constituye" y "crítico" casi desaparecen.
- Se quitaron 16 subrayados (`<u>`) y el texto en rojo (`firebrick`); los términos clave van en negrita.
- Leyendas de las 11 figuras al formato `Fuente: @clave.`, con `fig-alt`. Se quitaron `fig-align`, `out-width` y `class: fig-border`, que repetían la configuración global.
- El video de YouTube pasó del `<iframe>` al código corto `{{< video >}}` de Quarto.
- Secciones con etiqueta `{#sec-disponibilidad-…}`.

## Segunda pasada (2026-11-20)

- Nuevo ejemplo con R: qué porcentaje del agua dulce está en lagos, ríos y pantanos (0.3 %) y qué lámina formaría el agua de los ríos repartida sobre los continentes (14 mm). Usa los volúmenes del cuadro de distribución del agua.
- La sección de confiabilidad enlaza al ejemplo de operación de un embalse del capítulo 3.
- Títulos de sección más cortos y con etiqueta (`{#sec-disponibilidad-…}`).
