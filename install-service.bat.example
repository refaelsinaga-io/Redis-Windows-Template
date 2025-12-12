@echo off
:: ============================================
:: INSTALL REDIS 6384 SEBAGAI WINDOWS SERVICE
:: Jalankan sebagai Administrator!
:: ============================================

cd /d %~dp0

echo ============================================
echo   INSTALL REDIS 6384 SERVICE
echo ============================================
echo.

:: Cek apakah service sudah ada
sc query Redis6384 >nul 2>&1
if %errorlevel% equ 0 (
    echo [INFO] Service Redis6384 sudah terpasang.
    echo.
    goto :start_service
)

:: Install service
echo [INFO] Memasang service Redis6384...
redis-server --service-install "%~dp0redis.conf" --service-name Redis6384 --loglevel notice

if %errorlevel% neq 0 (
    echo.
    echo [ERROR] Gagal install service!
    echo Pastikan jalankan sebagai Administrator.
    echo.
    pause
    exit /b 1
)

:: Set auto start
sc config Redis6384 start= auto
echo [OK] Service Redis6384 berhasil dipasang.
echo.

:start_service
:: Start service
echo [INFO] Memulai service Redis6384...
net start Redis6384 2>nul

:: Verifikasi
timeout /t 2 >nul
redis-cli -p 6384 -a GANTI_PASSWORD ping >nul 2>&1
if %errorlevel% equ 0 (
    echo.
    echo ============================================
    echo [OK] Redis6384 sudah berjalan!
    echo     - Port: 6384
    echo     - Auto start saat Windows boot
    echo ============================================
) else (
    echo [WARNING] Service mungkin perlu waktu untuk start.
)

echo.
pause
