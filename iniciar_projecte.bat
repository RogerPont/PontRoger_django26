@echo off
title Iniciar Proyecto Django - Roger Pont
cls

rem 1. Crear y activar entorno virtual si no existe
if not exist "%~dp0venv\Scripts\activate.bat" (
    echo [INFO] Creando entorno virtual 'venv'...
    python -m venv venv
    if %ERRORLEVEL% neq 0 (
        echo [ERROR] No se pudo crear el entorno virtual.
        pause
        exit /b
    )
)
call "%~dp0venv\Scripts\activate.bat"
if %ERRORLEVEL% neq 0 (
    echo [ERROR] No se pudo activar el entorno virtual.
    pause
    exit /b
)

rem 2. Instalar dependencias
echo [INFO] Instalando dependencias desde requirements.txt...
pip install -r "%~dp0requirements.txt"
if %ERRORLEVEL% neq 0 (
    echo [CRITICAL] Error al instalar dependencias.
    pause
    exit /b
)

rem 3. Cambiar al directorio del proyecto Django
cd /d "%~dp0my_site"

rem 4. Verificar que Django está instalado
python -c "import django" 2>nul
if %ERRORLEVEL% neq 0 (
    echo [ERROR] Django no está instalado en este entorno.
    pause
    exit /b
)

rem 5. Detectar puerto libre (comenzar en 8000)
set PORT=8000
:CHECK_PORT
netstat -ano | findstr /R ":%PORT% " >nul
if not errorlevel 1 (
    rem Puerto ocupado, probar el siguiente
    set /a PORT+=1
    goto :CHECK_PORT
)

rem 6. Aplicar migraciones y cargar fixtures si la base de datos no existe
if not exist "db.sqlite3" (
    echo [INFO] Aplicando migraciones y cargando datos iniciales...
    python manage.py migrate
    python manage.py loaddata blog/fixtures/initial_data.json
)

rem 7. Iniciar servidor Django en puerto libre
echo [INFO] Iniciando servidor Django en http://127.0.0.1:%PORT%/
start "" cmd /k "python manage.py runserver %PORT%"

rem 8. Esperar unos segundos para que el servidor arranque
timeout /t 5 >nul

rem 9. Abrir navegador al mismo puerto
echo [INFO] Abriendo navegador a http://127.0.0.1:%PORT%/
start http://127.0.0.1:%PORT%/

rem 10. Fin del script
if %ERRORLEVEL% neq 0 (
    echo [ERROR] Hubo un problema al iniciar el servidor.
    pause
)
