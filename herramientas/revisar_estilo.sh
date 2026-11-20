#!/usr/bin/env bash
# Revisión rápida de estilo de un capítulo (ver GUIA_ESTILO.md, secciones 2 a 8).
# No corrige nada: lista las líneas que conviene mirar.
# Uso: bash herramientas/revisar_estilo.sh "13-IDF.qmd" [más archivos]

if [ $# -eq 0 ]; then
  echo "Uso: bash herramientas/revisar_estilo.sh <capitulo.qmd> [...]"
  exit 1
fi

# patrón|motivo
reglas=(
  'fundamental|Muletilla: borrar o decir por qué importa'
  '[Pp]ermite|Muletilla: decir qué se hace'
  'de (forma|manera) [a-záéíóú]+|Giro largo: usar adverbio, verbo o número'
  'significativ|Solo en sentido estadístico'
  '[Rr]obust|Solo en sentido estadístico'
  '[Ee]nfoque|Muletilla: "método", "criterio" o nada'
  'proporciona|Muletilla: "da", "mide", "entrega"'
  'herramienta|Nombrar la cosa'
  '\bclave\b|Muletilla: borrar'
  '[Ee]sencial|[Cc]rucial|Muletilla: borrar o dar la consecuencia'
  '[Ee]s importante|Decir la cosa importante directamente'
  '[Ee]n este (contexto|sentido)|Muletilla: borrar'
  'no solo|Dos oraciones simples'
  '[Ee]n este capítulo se|[Aa] continuación se|Arranque anunciador'
  '[a-záéíóú] — [a-záéíóú]|Raya en medio de la oración: usar comas o paréntesis'
  '¡|Exclamación'
  'escurrimiento|Terminología: escorrentía'
  'período|Terminología: periodo'
  '\bTabla\b|Terminología: Cuadro'
  'hidrólogo o hidróloga|Forma neutra'
  'm3/s|m\^3/s|Unidad: m³/s'
  'mm/hr|Unidad: mm/h'
  'km\^2|Unidad: km²'
  '<u>|Formato: no subrayar'
  '<br>|Formato: línea en blanco'
  '<center>|Formato: no centrar con HTML'
  'firebrick|Formato: usar recuadro'
  '^[Dd]onde:|Ecuación: "donde" sin dos puntos'
  'labs\(title|Gráfico: sin título si ya hay fig-cap'
  '```\{r [a-z]|Bloque R: poner opciones en líneas que empiezan con #-pipe'
)

for archivo in "$@"; do
  [ -f "$archivo" ] || { echo "No existe: $archivo"; continue; }
  palabras=$(wc -w < "$archivo")
  citas=$(grep -o '@[A-Za-z][A-Za-z0-9_]*' "$archivo" | grep -v -E '@(fig|tbl|eq|sec)-' | wc -l)
  echo "=================================================="
  echo "$archivo  ($palabras palabras, $citas citas bibliográficas)"
  echo "=================================================="
  for r in "${reglas[@]}"; do
    patron="${r%%|*}"; motivo="${r#*|}"
    # Si el motivo trae otro "|" es parte del patrón
    if [[ "$motivo" == *"|"* ]]; then patron="${r%|*}"; motivo="${r##*|}"; fi
    n=$(grep -c -E -- "$patron" "$archivo")
    if [ "$n" -gt 0 ]; then
      printf '\n[%d] %s   (%s)\n' "$n" "$motivo" "$patron"
      grep -n -E -- "$patron" "$archivo" | head -5 | cut -c1-140 | sed 's/^/    /'
      [ "$n" -gt 5 ] && echo "    ..."
    fi
  done
  # Oraciones largas (aprox.): más de 40 palabras entre puntos, fuera de bloques de código
  largas=$(awk '/^```/{c=!c; next} !c && !/^[#|$]/' "$archivo" | tr '\n' ' ' \
    | sed 's/\$[^$]*\$//g' | tr '.' '\n' | awk 'NF>40' | wc -l)
  printf '\n[%d] Oraciones de más de 40 palabras (aprox.)\n\n' "$largas"
done
