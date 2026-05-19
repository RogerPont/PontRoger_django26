@echo off
title Iniciar Projecte Django - Roger Pont
cls

echo ==============================================================
echo             ROGERPONT DEVBLOG - SISTEMA DJANGO
echo ==============================================================
echo [INFO] S'esta comprovant l'entorn i engegant el projecte...
echo ==============================================================
echo.

rem 1. Detecció i activació de l'entorn virtual (venv o .venv)
if exist "%~dp0venv\Scripts\activate.bat" (
    echo [INFO] S'ha detectat un entorn virtual local (venv). Activant-lo...
    call "%~dp0venv\Scripts\activate.bat"
) else if exist "%~dp0.venv\Scripts\activate.bat" (
    echo [INFO] S'ha detectat un entorn virtual local (.venv). Activant-lo...
    call "%~dp0.venv\Scripts\activate.bat"
) else (
    echo [WARNING] No s'ha trobat cap entorn virtual a "venv\" o ".venv\".
    echo [WARNING] S'utilitzara l'interpret global de Python.
)
echo.

rem 2. Canviar a la carpeta del projecte Django
cd /d "%~dp0my_site"

rem 3. Comprovació d'instal·lació de dependències bàsiques
python -c "import django" 2>nul
if %ERRORLEVEL% neq 0 (
    echo [ERROR] Django no esta instal.lat en aquest entorn!
    echo [INFO] S'estan instal.lant les dependencies des de requirements.txt...
    echo.
    pip install -r "%~dp0requirements.txt"
    if %ERRORLEVEL% neq 0 (
        echo [CRITICAL] No s'han pogut instal.lar les dependencies. 
        echo [CRITICAL] Assegura't de tenir connexio a internet i Python configurat.
        pause
        exit /b
    )
)

rem 4. Inicialització de la Base de Dades (si no existeix)
if not exist "db.sqlite3" (
    echo [INFO] No s'ha detectat la base de dades sqlite. 
    echo [INFO] Inicialitzant estructura de taules i aplicant migracions...
    python manage.py migrate
    echo.
    echo [INFO] Carregant dades inicials (fixtures)...
    python manage.py loaddata blog/fixtures/initial_data.json
    echo.
)

rem 5. Obrir el navegador web al frontend del blog
echo [INFO] S'obrira el navegador a http://127.0.0.1:8000/
start http://127.0.0.1:8000/

rem 6. Executar el servidor de desenvolupament de Django
echo [INFO] S'esta iniciant el servidor de desenvolupament...
python manage.py runserver

if %ERRORLEVEL% neq 0 (
    echo.
    echo [ERROR] Hi ha hagut un problema en tancar o executar el servidor.
    pause
)
