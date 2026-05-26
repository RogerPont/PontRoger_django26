@echo off
title Iniciar Projecte Django - Roger Pont
cls

rem 1. Crear i activar l'entorn virtual si no existeix
if not exist "%~dp0venv\Scripts\activate.bat" (
    echo [INFO] Creant l'entorn virtual 'venv'...
    python -m venv venv
    if %ERRORLEVEL% neq 0 (
        pause
        exit /b
    )
)
call "%~dp0venv\Scripts\activate.bat"
if %ERRORLEVEL% neq 0 (
    pause
    exit /b
)

rem 2. Instal·lar dependències
echo [INFO] Instal·lant dependències des de requirements.txt...
pip install -r "%~dp0requirements.txt"
if %ERRORLEVEL% neq 0 (
    echo [CRITICAL] Error en instal·lar les dependències.
    pause
    exit /b
)

rem 3. Canviar al directori del projecte Django
cd /d "%~dp0my_site"

rem 4. Verificar que Django està instal·lat
python -c "import django" 2>nul
if %ERRORLEVEL% neq 0 (
    echo [ERROR] Django no està instal·lat en aquest entorn.
    pause
    exit /b
)

rem 5. Detectar port lliure (començar en 8000)
set PORT=8000
:CHECK_PORT
netstat -ano | findstr /R ":%PORT% " >nul
if not errorlevel 1 (
    rem Port ocupat, provar el següent
    set /a PORT+=1
    goto :CHECK_PORT
)

rem 6. Aplicar migracions i carregar fixtures si la base de dades no existeix
if not exist "db.sqlite3" (
    echo [INFO] Aplicant migracions i carregant dades inicials...
    python manage.py migrate
    python manage.py loaddata blog/fixtures/initial_data.json
)

rem 7. Recollir fitxers estàtics (necessari amb DEBUG=False)
echo [INFO] Recollint fitxers estàtics...
python manage.py collectstatic --noinput
if %ERRORLEVEL% neq 0 (
    echo [ERROR] Error en recollir fitxers estàtics.
    pause
    exit /b
)

rem 8. Iniciar servidor Django en port lliure
echo [INFO] Iniciant servidor Django a http://127.0.0.1:%PORT%/
start "" cmd /k "python manage.py runserver %PORT%"

rem 9. Esperar uns segons perquè el servidor arrenqui
timeout /t 5 >nul

rem 10. Obrir el navegador al mateix port
echo [INFO] Obrint el navegador a http://127.0.0.1:%PORT%/
start http://127.0.0.1:%PORT%/

rem 11. Fi del script
if %ERRORLEVEL% neq 0 (
    echo [ERROR] Hi ha hagut un problema en iniciar el servidor.
    pause
)
