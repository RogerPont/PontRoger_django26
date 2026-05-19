@echo off
title Iniciar Projecte Django - Roger Pont
cls

echo ==============================================================
echo             ROGERPONT DEVBLOG - SISTEMA DJANGO
echo ==============================================================
echo [INFO] S'esta comprovant l'entorn i engegant el projecte...
echo [INFO] S'obrira el navegador a http://127.0.0.1:8000/
echo ==============================================================
echo.

rem Canviar a la carpeta del projecte
cd /d "%~dp0my_site"

rem Obrir el navegador
start http://127.0.0.1:8000/

rem Executar el servidor
python3 manage.py runserver

if %ERRORLEVEL% neq 0 (
    echo.
    echo [ERROR] Error en arrencar amb python3.
    echo [INFO] Intentant arrencar amb la comanda "python"...
    echo.
    python manage.py runserver
)

pause
