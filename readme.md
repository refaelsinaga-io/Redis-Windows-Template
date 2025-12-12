# Redis Instance - Port 6384

Dokumentasi konfigurasi Redis pada port 6384.

> **Instalasi Redis:** Lihat [INSTALL.md](INSTALL.md)

---

## Konfigurasi

### Port
```
port 6384
```

### Password
```
requirepass GANTI_PASSWORD
```

### Memory Limit
```
maxmemory 256mb
maxmemory-policy allkeys-lru
```

---

## Struktur Folder

```
redis_6384/
├── redis.conf             # File konfigurasi Redis
├── install-service.bat    # Install Windows Service (Run as Admin)
├── uninstall-service.bat  # Hapus Windows Service (Run as Admin)
├── start-service.bat      # Start service manual
├── stop-service.bat       # Stop service manual
├── check-redis.bat        # Cek status Redis
├── readme.md              # Dokumentasi ini
├── data/                  # Data persistence
│   ├── dump_6384.rdb          # RDB snapshot
│   ├── appendonly_6384.aof    # AOF file
│   └── redis_6384.pid         # PID file
└── logs/                  # Log files
```

---

## Install Windows Service (Recommended)

### Install Service (sekali saja)
1. Klik kanan `install-service.bat`
2. Pilih **Run as Administrator**
3. Redis akan otomatis jalan saat Windows boot

### Uninstall Service
1. Klik kanan `uninstall-service.bat`
2. Pilih **Run as Administrator**

---

## Penggunaan BAT Files

| File | Fungsi | Cara Pakai |
|------|--------|------------|
| `install-service.bat` | Install Redis sebagai Windows Service | Run as Administrator |
| `uninstall-service.bat` | Hapus service | Run as Administrator |
| `start-service.bat` | Start service manual | Double-click |
| `stop-service.bat` | Stop service manual | Double-click |
| `check-redis.bat` | Cek status Redis | Double-click |

---

## Koneksi Manual via CLI

```bash
# Koneksi ke Redis
redis-cli -p 6384

# Dengan password
redis-cli -p 6384 -a GANTI_PASSWORD

# Test koneksi
redis-cli -p 6384 -a GANTI_PASSWORD ping
```

---

## Koneksi dari Aplikasi

### Connection String
```
redis://default:GANTI_PASSWORD@127.0.0.1:6384
```

### NestJS (.env)
```env
REDIS_HOST=127.0.0.1
REDIS_PORT=6384
REDIS_PASSWORD=GANTI_PASSWORD
```

### Laravel (.env)
```env
REDIS_HOST=127.0.0.1
REDIS_PASSWORD=GANTI_PASSWORD
REDIS_PORT=6384
REDIS_CLIENT=predis
```

### Node.js (ioredis)
```javascript
const Redis = require('ioredis');
const redis = new Redis({
  host: '127.0.0.1',
  port: 6384,
  password: 'GANTI_PASSWORD'
});
```

### Python
```python
import redis
r = redis.Redis(host='127.0.0.1', port=6384, password='GANTI_PASSWORD')
```

---

## Deploy ke Production Server

### Cara 1: Clone dari Git

1. **Clone repository:**
   ```cmd
   git clone https://github.com/refaelsinaga-io/Redis-Windows-Template.git
   cd Redis-Windows-Template
   ```

2. **Copy template config:**
   ```cmd
   copy redis.conf.example redis.conf
   ```

3. **Edit `redis.conf`** - ganti placeholder:
   ```
   port GANTI_PORT           → port 6384
   requirepass GANTI_PASSWORD → requirepass PasswordKuat123!
   ```

   Ganti juga semua `GANTI_PORT` di nama file (pidfile, dbfilename, appendfilename)

4. **Buat folder:**
   ```cmd
   mkdir data
   mkdir logs
   ```

5. **Update password di `check-redis.bat`** (sesuaikan port dan password)

6. **Install service:**
   - Klik kanan `install-service.bat` → Run as Administrator

7. **Verifikasi:**
   ```cmd
   redis-cli -p 6384 -a PasswordKuat123! ping
   ```

---

### Cara 2: Copy Manual

### File yang perlu dibawa:
```
redis_6384/
├── redis.conf.example     # Template config
├── install-service.bat    # WAJIB
├── uninstall-service.bat  # Optional
├── start-service.bat      # Optional
├── stop-service.bat       # Optional
├── check-redis.bat        # Optional
└── readme.md              # Optional
```

### File yang TIDAK perlu dibawa:
- `redis.conf` - berisi password, buat dari template
- `data/` - akan dibuat otomatis oleh Redis
- `logs/` - akan dibuat otomatis

### Langkah Deploy:

1. **Copy folder** ke server

2. **Copy template config:**
   ```cmd
   copy redis.conf.example redis.conf
   ```

3. **Edit `redis.conf`** - ganti placeholder:
   ```
   port GANTI_PORT           → port 6384
   requirepass GANTI_PASSWORD → requirepass PasswordKuat123!
   ```

4. **Buat folder:**
   ```cmd
   mkdir data
   mkdir logs
   ```

5. **Update password di `check-redis.bat`**

6. **Install service:**
   - Klik kanan `install-service.bat` → Run as Administrator

7. **Verifikasi:**
   ```cmd
   redis-cli -p 6384 -a PasswordKuat123! ping
   ```

---

## Troubleshooting

### Redis tidak mau start
1. Cek apakah port 6384 sudah dipakai:
   ```
   netstat -an | findstr 6384
   ```
2. Cek status service:
   ```
   sc query Redis6384
   ```

### Lupa password
Password ada di `redis.conf`:
```
requirepass GANTI_PASSWORD
```

### Memory penuh
Redis dikonfigurasi dengan `maxmemory 256mb` dan policy `allkeys-lru` (Least Recently Used keys akan dihapus otomatis).

### Service Commands
```bash
# Cek status service
sc query Redis6384

# Start service
net start Redis6384

# Stop service
net stop Redis6384
```
