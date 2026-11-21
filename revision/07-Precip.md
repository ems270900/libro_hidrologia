# Revisión del capítulo 7: precipitación

Revisión hecha con `GUIA_ESTILO.md`. Los cinco ejemplos se ejecutaron y el capítulo se renderiza sin avisos.

## Figuras nuevas

Pedidas por el autor:

- **Figura 7.1** (formación de la lluvia). Se rehízo desde cero en R: tamaño, concentración y velocidad de caída del núcleo de condensación, la gota de nube y la gota de lluvia, con los procesos que las unen [@wallace2006atmospheric].
- **Figura 7.3** (lluvia por latitud). La anterior estaba en pulgadas y centímetros y no tenía fuente. Se rehízo en mm/año con datos reales de la climatología GPCP versión 2.3, 1991–2020 [@adler2018gpcp]. Los datos están en `datos/precipitacion_zonal_gpcp.csv` (ver `datos/LEEME.md`). Marca la ZCIT, los subtrópicos, las latitudes medias, los polos, la media global (983 mm) y la franja de Costa Rica.
- **Figura 7.8** (hietograma). Se rehicieron el hietograma y la curva masa a partir de un ejemplo resuelto con R, de modo que las dos figuras muestran la misma tormenta. Las anteriores estaban en inglés, con la curva masa en centímetros. Ahora el hietograma es la figura 7.7 y la curva masa la 7.8.

## Errores técnicos corregidos

1. **Frecuencia.** Se definía como "número probable de años", que es el periodo de retorno. Ahora se define como probabilidad de excedencia $p$, con $T = 1/p$.
2. **Thiessen.** Decía que el método asume "una variación lineal entre estaciones". Asume lluvia constante dentro de cada polígono.
3. **Epígrafe.** La frase atribuida a Bob Marley no tiene fuente verificable (también se atribuye a Roger Miller). Se reemplazó por Job 36:27.
4. **Ejemplo de Thiessen.** Los aportes a mano se uniformaron con los pesos redondeados (3.43 mm, sin cambio en el resultado).
5. **Ejercicio sin solución.** El "Ejemplo" de la cuenca hexagonal no tenía solución; ahora es un ejercicio propuesto, y el inverso de la distancia tiene su propio ejemplo resuelto.

## Ejemplos

- Hietograma, curva masa e intensidades máximas de 10, 30 y 60 min (nuevo).
- Precipitación media con polígonos de Thiessen (con código R).
- Precipitación media con isoyetas (con pseudocódigo y código R; se separó el cuadro del cálculo).
- Lluvia en un punto con el inverso del cuadrado de la distancia (nuevo).

## Otros cambios

- Ecuaciones etiquetadas `eq-precip-*` (7) y secciones `sec-precip-*`.
- Sin `<br>`, `<span class="firebrick">` ni estilos en línea.
- Los estudios de Costa Rica (Murillo, 1994; Maroto, 2011; Sandí, 2012) se citan desde `references.bib`.
- El video de YouTube pasó a un recuadro "En la práctica", con título descriptivo.
- `fig-niño` pasó a `fig-precip-enos` (no se citaba en otros capítulos).

## Referencias nuevas

Adler et al. (2018) y Trenberth et al. (2007).
