@echo off
rem Genera el libro en un solo archivo HTML y lo abre en el navegador.
rem Uso: doble clic sobre este archivo, que debe estar en la carpeta del libro.
rem Necesita R y Quarto instalados. Tarda unos 5 minutos.
chcp 65001 >nul
cd /d "%~dp0"

rem Busca Rscript en el PATH; si no esta, usa la version de R instalada en Archivos de programa
set "RSCRIPT=Rscript"
where Rscript >nul 2>nul
if errorlevel 1 (
  for /d %%d in ("%ProgramFiles%\R\R-*") do set "RSCRIPT=%%d\bin\Rscript.exe"
)

echo Generando el libro. Espere unos minutos...
"%RSCRIPT%" -e "source('herramientas/publicar.R'); libro_un_archivo()"
if errorlevel 1 (
  echo.
  echo Hubo un error al generar el libro. Revise los mensajes de arriba.
  pause
  exit /b 1
)

start "" "salidas\Hidrologia_Aplicada.html"
