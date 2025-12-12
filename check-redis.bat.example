@echo off
:: ============================================
:: CHECK REDIS STATUS
:: ============================================

cd /d %~dp0

echo ============================================
echo        REDIS STATUS - PORT 6384
echo ============================================
echo.

:: Cek koneksi ke Redis
redis-cli -p 6384 -a GANTI_PASSWORD ping >nul 2>&1
if %errorlevel%==0 (
    echo [OK] Redis RUNNING di port 6384
    echo.
    echo --- INFO SERVER ---
    redis-cli -p 6384 -a GANTI_PASSWORD info server 2>nul | findstr /i "redis_version uptime_in_seconds tcp_port"
    echo.
    echo --- INFO MEMORY ---
    redis-cli -p 6384 -a GANTI_PASSWORD info memory 2>nul | findstr /i "used_memory_human maxmemory_human"
    echo.
    echo --- INFO CLIENTS ---
    redis-cli -p 6384 -a GANTI_PASSWORD info clients 2>nul | findstr /i "connected_clients"
    echo.
    echo --- INFO KEYSPACE ---
    redis-cli -p 6384 -a GANTI_PASSWORD info keyspace 2>nul
) else (
    echo [X] Redis TIDAK BERJALAN di port 6384
)

echo.
echo ============================================
pause
