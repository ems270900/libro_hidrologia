# Instrucciones para trabajar en este repositorio

Libro *Hidrología Aplicada a la Ingeniería Civil* (Edwin Matarrita Segura, Escuela de Ingeniería Civil, UCR). Es un libro de Quarto con ejemplos en R. Lectores: estudiantes que aprenden el tema y profesionales que lo consultan.

## Reglas

- Todo en español: texto, comentarios de código, mensajes de commit y PR.
- **Antes de escribir o revisar un capítulo, leer `GUIA_ESTILO.md` completa.** Es la referencia de tono, terminología, unidades, ecuaciones, figuras, citas y código R.
- Los capítulos nuevos parten de `_plantillas/plantilla_capitulo.qmd`.
- Después de editar un capítulo, correr `bash herramientas/revisar_estilo.sh <archivo>.qmd` y revisar los avisos. El script solo señala; la decisión es de quien edita.
- No inventar referencias, cifras ni datos de estaciones. Si falta una fuente, dejar `<!-- CITA PENDIENTE: ... -->`.
- No renombrar claves existentes de `references.bib` ni etiquetas `fig-`, `tbl-`, `eq-` ya citadas: otros capítulos dependen de ellas.
- Un capítulo por PR cuando se revisan capítulos existentes, para que la revisión sea manejable.
- Cambios de contenido técnico (valores, métodos, conclusiones) se señalan en la descripción del PR. La revisión de estilo no debe cambiar resultados.
- Licencia, formato de salida (web o PDF) y plazos los decide el autor. No asumirlos.

## Estructura

- `NN-tema.qmd`: capítulos, en el orden de `_quarto.yml`.
- `references.bib`: bibliografía. Estilo APA en `assets/csl/apa.csl`.
- `assets/img/`: imágenes. `assets/css/styles.css`: estilos.
- `herramientas/`: scripts de apoyo (`publicar.R`, `revisar_estilo.sh`).
- `_plantillas/`: plantilla de capítulo (Quarto no la renderiza por empezar con `_`).

## Renderizar

```bash
quarto render                 # libro completo
quarto render 13-IDF.qmd      # un capítulo
```
