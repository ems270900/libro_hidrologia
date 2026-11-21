# Revisión del capítulo 10: periodo de retorno y riesgo

Revisión hecha con `GUIA_ESTILO.md`. El capítulo se renderiza sin avisos y los cuatro bloques de R se ejecutaron en una sesión limpia. Antes tenía un solo ejemplo, sin código, y cinco figuras hechas con una serie diaria sintética. Ahora tiene tres ejemplos con solución a mano, pseudocódigo y R, y tres ejercicios propuestos.

## Estructura nueva

1. Probabilidad de excedencia.
2. Periodo de retorno, con la distribución geométrica del tiempo hasta la primera ocurrencia, el nivel de retorno y los periodos de retorno de diseño (cuadro adaptado de Chow et al., 1988).
3. Riesgo hidrológico: distribución binomial, riesgo, confiabilidad y periodo de retorno para un riesgo dado.
4. Series para el análisis de frecuencia: máximos anuales, duración parcial y excedencias anuales, relación de Langbein y picos sobre umbral.
5. Ejercicios propuestos.

## Errores técnicos corregidos

1. **Riesgo para T = 50 y n = 50.** Decía 0.634 (63.4 %). El valor correcto es $1 - 0.98^{50} = 0.636$.
2. **Riesgo y binomial.** La fórmula del riesgo aparecía sin su origen. Ahora se deduce de la binomial, y el ejemplo calcula también la probabilidad de una y de dos o más excedencias en la vida útil.
3. **Periodo de retorno.** Se agregó que el tiempo hasta la primera ocurrencia sigue una distribución geométrica de media $T$. Así se aclara por qué el evento de 100 años puede ocurrir dos años seguidos.
4. **Serie parcial y serie anual.** Faltaba la relación entre sus periodos de retorno, $T = 1/(1 - e^{-1/T_E})$ (Langbein, 1949; Chow et al., 1988). Sin ella, el lector no sabe cuándo importa la diferencia.
5. **Estacionariedad.** Se agregó un aviso: el periodo de retorno supone que el clima y la cuenca no cambian.
6. Se quitó el párrafo sobre carteles de licitación, que no tenía fuente.

## Figuras y datos

- Se quitaron las cinco figuras con datos sintéticos (`fig-plot124`, `fig-plot125`, `fig-plot126`, `fig-plot128`, `fig-plot129`). En su lugar, el ejemplo de series usa el caudal mensual de la estación de montaña del capítulo 8 (datos ilustrativos), con su tabla y botón de descarga.
- Figura nueva del riesgo contra la vida útil para cinco periodos de retorno.
- El capítulo 12 citaba `fig-plot128`. Ahora remite a la sección y la figura nuevas de series.

## Otros

- El epígrafe de Ven Te Chow se conserva, firmado "Atribuida a", por decisión del autor.
- Se agregaron a `references.bib` Langbein (1949) y Coles (2001).
