# Revisión del capítulo 9: conceptos básicos de probabilidad

Revisión hecha con `GUIA_ESTILO.md`. El capítulo se renderiza sin avisos y los cuatro ejemplos se ejecutaron en una sesión limpia. Antes no tenía ningún ejemplo resuelto ni código visible; ahora tiene cuatro ejemplos con datos y tres ejercicios propuestos.

## Estructura nueva

1. La estadística en hidrología (usos, población y muestra, análisis de sistemas, modelos, fuentes de incertidumbre).
2. Experimentos, eventos y variables.
3. Probabilidad: definición frecuentista y axiomas.
4. Reglas de la probabilidad: suma, condicional, multiplicación e independencia.
5. Variables aleatorias: FDA y FDP.
6. Estadísticos descriptivos: centro, dispersión, forma y medidas resistentes.
7. Ejercicios propuestos.

## Errores técnicos corregidos

1. **Curtosis.** No decía que la normal tiene $C_k = 3$ ni que algunos programas reportan el exceso de curtosis ($C_k - 3$). Ahora se definen el estimador y la referencia.
2. **Asimetría.** La fórmula $C_s = \mu_3/S^3$ mezclaba un momento de la población con un estimador de la muestra. Se reemplazó por el estimador con corrección por tamaño de muestra de Chow et al. (1988), y el ejemplo muestra que `moments::skewness()` no la aplica.
3. **Varianza.** Se usaban $\sigma^2$ y $S^2$ como si fueran lo mismo. Ahora se distinguen el momento de la población y el estimador muestral, y se explica por qué se divide entre $n - 1$.
4. **FDA.** La integral $P(a \le Y \le b)$ estaba debajo de la propiedad "no decreciente", sin relación con ella, y las propiedades estaban repetidas en dos listas. Quedó una sola lista de cuatro propiedades, y la probabilidad de un intervalo se explica con la FDP.
5. **Robustez y resistencia.** El texto decía que un método robusto "no es óptimo, pero funciona bien", y ponía de ejemplo la media con datos normales, que trata de otra cosa. Se rehízo con la definición de Wilks (2019).
6. **Moda.** Se quitó "en un hietograma corresponde a la clase con mayor altura", que confunde un histograma con un hietograma.
7. **Epígrafe.** La frase atribuida a Gumbel ("Es imposible que lo improbable nunca ocurra") circula sin fuente. Se reemplazó por la de Laplace en el *Ensayo filosófico sobre las probabilidades* (1814).
8. Se quitaron dos afirmaciones sin fuente: que las series de menos de 20 a 25 años "suelen ser insuficientes" y que un registro de 30 a 50 años "caracteriza de forma confiable" la población. El texto muestra la idea con los datos del capítulo.
9. Se quitaron un `\color{red}` que no se convertía en la web, cuatro `<u>` y la instalación automática de `DiagrammeR` dentro de un bloque.

## Figuras

- Se conservó la figura de Venn de Wilks (2019), con la fuente en la leyenda.
- El diagrama de análisis de sistemas se rehízo con los colores del libro.
- Se reemplazaron seis imágenes: la del dado, en inglés; el diagrama de caja; los diagramas de Venn y de asimetría y curtosis, que parecían generados; y dos figuras de FDA y FDP escaneadas sin fuente. Las nuevas son figuras de R con datos del capítulo: frecuencia relativa que converge, eventos excluyentes, FDA y FDP de la lluvia anual, y formas de distribución.

## Ejemplos y datos

Todos usan `datos/lluvia_mensual_dos_estaciones.csv` (datos ilustrativos, estaciones anónimas), con botón de descarga y vista paginada.

1. **Eventos.** Lluvia mensual y época lluviosa: $P(A) = 0.463$, $P(A \mid B) = 0.726$; los eventos no son independientes.
2. **No excedencia.** Probabilidades de la lluvia anual con la FDA empírica y con la normal. En la cola alta difieren: 0.12 contra 0.075.
3. **Estadísticos.** De la lluvia anual: media 3298.3 mm, $s = 487.5$ mm, $C_s = 0.745$, $C_k = 2.73$. Se comparan con `summary()`, `IQR()` y el paquete `moments`.
4. **Error de transcripción.** La media sube 28 % y la mediana cambia 8 mm.

## Otros cambios

- Ecuaciones etiquetadas `eq-prob-*` (15) y secciones `sec-prob-*`. Las etiquetas viejas no las citaba otro capítulo.
- Una pregunta al lector, en la probabilidad condicional.
- Ejemplos de variables con casos de hidrología (cobertura, alertas, días con lluvia) en lugar de sexo, profesión o salario.

## Pendiente para el autor

- Ninguno.
