@echo off
:: ============================================
:: UNINSTALL REDIS 6384 SERVICE
:: Jalankan sebagai Administrator!
:: ============================================

cd /d %~dp0

echo ============================================
echo   UNINSTALL REDIS 6384 SERVICE
echo ============================================
echo.

:: Stop service dulu
echo [INFO] Menghentikan service Redis6384...
net stop Redis6384 2>nul

:: Uninstall service
echo [INFO] Menghapus service Redis6384...
redis-server --service-uninstall --service-name Redis6384

if %errorlevel% equ 0 (
    echo.
    echo [OK] Service Redis6384 berhasil dihapus.
) else (
    echo.
    echo [INFO] Service mungkin sudah tidak ada.
)

echo.
pause
