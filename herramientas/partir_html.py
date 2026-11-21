"""
partir_html.py
---------------------------------------------------------------------------
Parte el HTML de un solo archivo (salidas/Hidrologia_Aplicada.html) en piezas
que coinciden con los capítulos, para copiarlo a otra computadora por partes.

Cada capítulo queda en su propia pieza (los de más de 8 MB, en trozos de 8 MB).
Al cambiar un capítulo solo cambian su pieza y la del encabezado, así que las
demás no hace falta volver a copiarlas.

Uso:
    python3 herramientas/partir_html.py salidas/Hidrologia_Aplicada.html carpeta_partes

Deja en carpeta_partes las piezas (Hidrologia_Aplicada.p000, .p001, ...),
unir_y_abrir.bat (las une en Windows y abre el libro, sin borrarlas) y
partes.huella (huella de cada pieza). Escribe en pantalla las piezas que
cambiaron desde la corrida anterior: son las únicas que hay que copiar.

La huella no cambia si solo cambia el orden de los atributos dentro de una
etiqueta HTML, porque Quarto no siempre los escribe en el mismo orden.
"""
import hashlib
import re
import sys
from pathlib import Path

MAX = 8 * 1024 * 1024


def huella(pieza: bytes) -> str:
    segmentos = pieza.split(b">")
    canon = []
    for s in segmentos:
        p = s.rfind(b"<")
        if p >= 0:
            tokens = sorted(re.split(rb"\s+", s[p:]))
            s = s[:p] + b" ".join(tokens)
        canon.append(s)
    return hashlib.md5(b">".join(canon)).hexdigest()


def partir(html: str, carpeta: str) -> list:
    datos = Path(html).read_bytes()
    destino = Path(carpeta)
    destino.mkdir(parents=True, exist_ok=True)

    inicios = [m.start() for m in re.finditer(rb'<section id="[^"]*" class="level1', datos)]
    cortes = sorted(set([0] + inicios + [len(datos)]))
    piezas = []
    for a, b in zip(cortes[:-1], cortes[1:]):
        for s in range(a, b, MAX):
            piezas.append(datos[s:min(s + MAX, b)])

    archivo_huellas = destino / "partes.huella"
    previas = {}
    if archivo_huellas.exists():
        for linea in archivo_huellas.read_text().splitlines():
            h, nombre = linea.split()
            previas[nombre] = h

    for viejo in destino.glob("Hidrologia_Aplicada.p[0-9][0-9][0-9]"):
        viejo.unlink()
    nombres, cambiadas, lineas = [], [], []
    for k, pieza in enumerate(piezas):
        nombre = f"Hidrologia_Aplicada.p{k:03d}"
        h = huella(pieza)
        nombres.append(nombre)
        lineas.append(f"{h} {nombre}")
        (destino / nombre).write_bytes(pieza)
        if previas.get(nombre) != h:
            cambiadas.append(nombre)
    archivo_huellas.write_text("\n".join(lineas) + "\n")

    bat = [
        "@echo off",
        'cd /d "%~dp0"',
        "if exist Hidrologia_Aplicada.html del Hidrologia_Aplicada.html",
        "copy /b " + "+".join(nombres) + " Hidrologia_Aplicada.html >nul",
        "if exist Hidrologia_Aplicada.html (",
        '  start "" Hidrologia_Aplicada.html',
        ") else (",
        "  echo No se pudo unir el archivo.",
        "  pause",
        ")",
    ]
    (destino / "unir_y_abrir.bat").write_bytes(("\r\n".join(bat) + "\r\n").encode("ascii"))

    print(f"{len(nombres)} piezas; cambiaron {len(cambiadas)}:")
    print("\n".join(cambiadas))
    return cambiadas


if __name__ == "__main__":
    if len(sys.argv) < 3:
        sys.exit("Uso: python3 herramientas/partir_html.py <html> <carpeta>")
    partir(sys.argv[1], sys.argv[2])
