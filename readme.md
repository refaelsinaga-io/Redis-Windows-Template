# Redis Windows Template

Template konfigurasi Redis untuk Windows dengan Windows Service.

Repository: https://github.com/refaelsinaga-io/Redis-Windows-Template

---

## Instalasi Redis di Windows

### Download Redis

Download Redis untuk Windows dari:
- https://github.com/tporadowski/redis/releases

### Pilihan Format Install

#### 1. ZIP (Recommended untuk Production)

**Download:** `Redis-x64-5.0.14.1.zip`

**Langkah:**
1. Extract ke folder, contoh:
   ```
   D:\Redis\
   ├── redis-server.exe
   ├── redis-cli.exe
   └── ... (file lainnya)
   ```

2. Tambahkan ke System PATH:
   - Buka **System Properties** → **Environment Variables**
   - Edit **Path** → Add `D:\Redis`
   - Atau via CMD (Run as Admin):
     ```cmd
     setx PATH "%PATH%;D:\Redis" /M
     ```

3. Buka CMD baru, test:
   ```cmd
   redis-server --version
   redis-cli --version
   ```

**Kelebihan ZIP:**
- Tidak install service default 6379 yang tidak dipakai
- Lebih bersih, hanya jalankan service yang kamu mau
- Bisa taruh di folder custom

#### 2. MSI (Installer)

**Download:** `Redis-x64-5.0.14.1.msi`

**Langkah:**
1. Double-click file MSI
2. Next → Next → Install
3. Selesai

**Hasil:**
- Install ke `C:\Program Files\Redis`
- Otomatis ditambahkan ke PATH
- Otomatis install service default (port 6379)

**Catatan:**
- Service default 6379 akan otomatis jalan
- Jika tidak dipakai, bisa di-disable:
  ```cmd
  sc stop Redis
  sc config Redis start= disabled
  ```

### Rekomendasi

| Kebutuhan | Pilihan |
|-----------|---------|
| Production server | ZIP |
| Development/testing | MSI atau ZIP |
| Multiple Redis instances | ZIP |

### Verifikasi Instalasi

Buka CMD baru:
```cmd
redis-server --version
```

Output contoh:
```
Redis server v=5.0.14.1 sha=ec77f72d:0 malloc=jemalloc-5.2.1-redis bits=64 build=5627b8177c9289c
```

Jika muncul error "not recognized", pastikan PATH sudah benar dan buka CMD baru.

---

## Konfigurasi

### Port
```
port GANTI_PORT
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
Redis-Windows-Template/
├── redis.conf.example     # Template konfigurasi (GANTI_PORT, GANTI_PASSWORD)
├── install-service.bat    # Install Windows Service (Run as Admin)
├── uninstall-service.bat  # Hapus Windows Service (Run as Admin)
├── start-service.bat      # Start service manual
├── stop-service.bat       # Stop service manual
├── check-redis.bat        # Cek status Redis
├── readme.md              # Dokumentasi ini
├── .gitignore             # Ignore redis.conf, data/, logs/
├── data/                  # Data persistence (auto-generated)
└── logs/                  # Log files (auto-generated)
```

---

## Deploy ke Server

### 1. Clone Repository

```cmd
git clone https://github.com/refaelsinaga-io/Redis-Windows-Template.git
cd Redis-Windows-Template
```

### 2. Buat Config dari Template

```cmd
copy redis.conf.example redis.conf
```

### 3. Edit redis.conf

Ganti semua placeholder:
```
port GANTI_PORT           → port 6384
requirepass GANTI_PASSWORD → requirepass PasswordKuat123!

pidfile ./data/redis_GANTI_PORT.pid      → pidfile ./data/redis_6384.pid
dbfilename dump_GANTI_PORT.rdb           → dbfilename dump_6384.rdb
appendfilename "appendonly_GANTI_PORT.aof" → appendfilename "appendonly_6384.aof"
```

### 4. Update BAT Files

Edit password di file-file berikut:
- `install-service.bat` - ganti `GANTI_PASSWORD`
- `check-redis.bat` - ganti `GANTI_PASSWORD`

### 5. Buat Folder

```cmd
mkdir data
mkdir logs
```

### 6. Install Service

Klik kanan `install-service.bat` → **Run as Administrator**

### 7. Verifikasi

```cmd
redis-cli -p 6384 -a PasswordKuat123! ping
```

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

## Troubleshooting

### Redis tidak mau start
1. Cek apakah port sudah dipakai:
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
