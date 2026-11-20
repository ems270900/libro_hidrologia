# Revisión del capítulo 1: la hidrología como ciencia

Revisión hecha con `GUIA_ESTILO.md`. El capítulo no tiene código R de cálculo; se renderizó sin avisos.

## Resumen

| Indicador | Antes | Después |
|---|---|---|
| Palabras | 1 456 | 1 541 |
| Avisos de `revisar_estilo.sh` | 19 | 6 |
| Marcas `CITA PENDIENTE` o `VERIFICAR` | 0 | 2 |

El capítulo crece un poco porque se juntaron secciones de una sola línea ("Enfoque multidisciplinario", "Concepto de hidrología") en una definición completa y se agregó un párrafo que explica por qué el libro usa R.

## Errores técnicos encontrados

1. **"Familia SHE (Systems Hydrological European)".** El nombre es *Système Hydrologique Européen*. Se corrigió.
2. **"MCG y otros modelos de simulación continua".** La sigla no se explicaba y no corresponde a un modelo conocido de simulación continua. Se reemplazó por el Stanford Watershed Model (1966), el ejemplo clásico de esa familia.
3. **Inicio de los modelos numéricos en 1950.** Los modelos de simulación continua aparecen con las computadoras en la década de 1960. Se ajustó.
4. **Descripción de las instituciones.** Varias se llamaban "ente rector" sin serlo (por ejemplo, SENARA y el ICE). Se describió lo que hace cada una sin asignar rectorías.
5. **"Análsis"** (errata) en la lista de obras.

## Citas pendientes

| Pendiente | Estado |
|---|---|
| Epígrafe atribuido a Leonardo da Vinci | `VERIFICAR`: la frase circula con esa atribución, pero no se encontró en sus cuadernos. |
| Línea de tiempo de la historia de la hidrología | `CITA PENDIENTE`: conviene citar la reseña histórica de un libro de texto (por ejemplo, Chow et al., 1988, cap. 1) después de confirmar que coincide. |

## Cambios de estilo

- Se juntaron cuatro secciones cortas en dos (definición y relación con la ingeniería civil). Cada sección principal tiene etiqueta `{#sec-hidrologia-…}`.
- Listas con minúscula inicial y punto y coma, como pide la guía.
- Se quitaron muletillas ("fundamental", "permite", "constituye un pilar") y frases de cierre sin contenido.
- Leyendas al formato `Fuente: @clave.`, con `fig-alt`, sin `<br>` ni `<span>`.

## Segunda pasada (2026-11-20)

- Se agregaron las tres preguntas que responde casi todo estudio hidrológico (cuánta agua hay, cuánta llega en una crecida, cuánta falta en una sequía) y para qué sirve cada una.
- **Corrección:** los primeros pronósticos del tiempo de FitzRoy fueron en 1861, no en la década de 1850.
- La nota de cita pendiente de la línea de tiempo ahora sugiere dónde buscar (capítulo 1 de Chow et al., 1988, o de Maidment, 1993).
- Todas las secciones tienen etiqueta y la referencia al ciclo hidrológico enlaza a su sección.
