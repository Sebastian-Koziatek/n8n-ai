# n8n - Instalacja i uruchomienie

## Czym jest n8n?

**n8n** (rozwijane jako "node to node") to otwarte narzędzie do automatyzacji przepływów pracy i integracji aplikacji. W przeciwieństwie do wielu komercyjnych rozwiązań, n8n daje pełną kontrolę nad tym, gdzie i jak działają Twoje automatyzacje.

### Kluczowe cechy n8n:

**Open Source**
- Kod źródłowy jest otwarty i dostępny dla każdego
- Możliwość modyfikacji i dostosowania do własnych potrzeb
- Brak ukrytych kosztów licencyjnych

**Self-hosted**
- Możliwość instalacji na własnym serwerze lub w chmurze
- Pełna kontrola nad danymi i bezpieczeństwem
- Niezależność od zewnętrznych dostawców

**Fair-code**
- Model licencji pozwalający na korzystanie, modyfikację i dystrybucję
- Możliwość komercyjnego użycia
- Społeczność aktywnie wspiera rozwój projektu

**Elastyczność**
- Ponad 400 gotowych integracji
- Możliwość tworzenia własnych node'ów
- Wsparcie dla JavaScript do zaawansowanych transformacji danych

---

## Jak uruchomić n8n?

n8n można uruchomić na kilka sposobów w zależności od potrzeb i umiejętności technicznych.

### Metoda 1: Docker (zalecana)

Docker to najszybszy i najłatwiejszy sposób na uruchomienie n8n. Wymaga zainstalowanego Docker Desktop lub Docker Engine.

#### Podstawowe uruchomienie:

```bash
docker run -it --rm \
  --name n8n \
  -p 5678:5678 \
  n8nio/n8n
```

Po uruchomieniu n8n będzie dostępne pod adresem: `http://localhost:5678`

#### Uruchomienie z wolumenem (zapisywanie danych):

```bash
docker run -it --rm \
  --name n8n \
  -p 5678:5678 \
  -v ~/.n8n:/home/node/.n8n \
  n8nio/n8n
```

To polecenie:
- Mapuje port 5678 z kontenera na host
- Zapisuje dane w katalogu `~/.n8n` na Twoim komputerze
- Dane będą zachowane nawet po zamknięciu kontenera

#### Uruchomienie z docker-compose (produkcja):

Utwórz plik `docker-compose.yml`:

```yaml
version: '3.8'

services:
  n8n:
    image: n8nio/n8n:latest
    container_name: n8n
    restart: unless-stopped
    ports:
      - "5678:5678"
    environment:
      - N8N_BASIC_AUTH_ACTIVE=true
      - N8N_BASIC_AUTH_USER=admin
      - N8N_BASIC_AUTH_PASSWORD=changeme
      - N8N_HOST=localhost
      - N8N_PORT=5678
      - N8N_PROTOCOL=http
      - WEBHOOK_URL=http://localhost:5678/
    volumes:
      - ~/.n8n:/home/node/.n8n
```

Uruchom komendą:

```bash
docker-compose up -d
```

**Ważne:** Pamiętaj o zmianie domyślnego hasła!

---

### Metoda 2: npm (Node.js)

Jeśli masz zainstalowany Node.js (wersja 18.10 lub nowsza), możesz zainstalować n8n globalnie:

```bash
npm install n8n -g
```

Następnie uruchom:

```bash
n8n start
```

---

### Metoda 3: npx (bez instalacji)

Możesz uruchomić n8n bez instalacji używając npx:

```bash
npx n8n
```

Ta metoda jest dobra do testowania, ale nie jest zalecana do dłuższego użytkowania.

---

## Pierwsze uruchomienie

Po uruchomieniu n8n po raz pierwszy:

1. **Otwórz przeglądarkę** i przejdź do `http://localhost:5678`

2. **Utwórz konto** - zostaniesz poproszony o utworzenie pierwszego użytkownika:
   - Email
   - Hasło
   - Imię i nazwisko (opcjonalne)

3. **Interfejs główny** - po zalogowaniu zobaczysz:
   - Listę workflow (początkowo pustą)
   - Przycisk "Create new workflow"
   - Menu nawigacyjne

4. **Stwórz pierwszy workflow**:
   - Kliknij "Create new workflow"
   - Zobaczysz pusty canvas do budowania automatyzacji
   - W prawym panelu znajdziesz listę dostępnych node'ów

---

## Konfiguracja podstawowa

### Zmienne środowiskowe

n8n można skonfigurować za pomocą zmiennych środowiskowych:

**Autentykacja:**
```bash
N8N_BASIC_AUTH_ACTIVE=true
N8N_BASIC_AUTH_USER=admin
N8N_BASIC_AUTH_PASSWORD=securepassword
```

**Webhook URL:**
```bash
WEBHOOK_URL=https://twoja-domena.pl/
```

**Timezone:**
```bash
GENERIC_TIMEZONE=Europe/Warsaw
```

**Baza danych (opcjonalnie PostgreSQL zamiast SQLite):**
```bash
DB_TYPE=postgresdb
DB_POSTGRESDB_HOST=postgres
DB_POSTGRESDB_PORT=5432
DB_POSTGRESDB_DATABASE=n8n
DB_POSTGRESDB_USER=n8n
DB_POSTGRESDB_PASSWORD=n8n
```

---

## Bezpieczeństwo

### Dla środowiska lokalnego (development):
- Dostęp tylko z localhost
- Brak konieczności HTTPS
- Podstawowa autentykacja wystarczy

### Dla środowiska produkcyjnego:
- **Zawsze używaj HTTPS** (certyfikat SSL/TLS)
- **Silne hasła** do autentykacji
- **Firewall** blokujący niepotrzebny ruch
- **Regularne aktualizacje** n8n do najnowszej wersji
- **Backup danych** (folder `.n8n` lub baza danych)

---

## Aktualizacja n8n

### Docker:
```bash
docker pull n8nio/n8n:latest
docker stop n8n
docker rm n8n
docker run # ... (ponownie uruchom z tymi samymi parametrami)
```

### npm:
```bash
npm update -g n8n
```

---

## Gdzie przechowywane są dane?

- **Docker:** `/home/node/.n8n` w kontenerze (mapowany na `~/.n8n` na hoście)
- **npm/npx:** `~/.n8n` w katalogu domowym użytkownika

Struktura katalogu `.n8n`:
```
.n8n/
├── config          # Konfiguracja
├── database.sqlite # Baza danych (jeśli nie używasz PostgreSQL)
├── nodes/          # Custom node'y
└── static/         # Pliki statyczne
```

---

## Troubleshooting

### n8n nie startuje:
- Sprawdź czy port 5678 nie jest zajęty: `netstat -tuln | grep 5678`
- Sprawdź logi: `docker logs n8n`

### Nie mogę połączyć się przez przeglądarkę:
- Upewnij się, że firewall nie blokuje portu 5678
- Sprawdź czy kontener działa: `docker ps`

### Problemy z zapisywaniem workflow:
- Sprawdź uprawnienia do katalogu `.n8n`
- Sprawdź czy dysk nie jest pełny

---

## Podsumowanie

n8n to potężne narzędzie do automatyzacji, które możesz uruchomić na swoim komputerze lub serwerze w kilka minut. Dzięki otwartemu kodowi i możliwości self-hostingu, masz pełną kontrolę nad swoimi danymi i automatyzacjami.

W kolejnych lekcjach poznasz interfejs n8n, nauczysz się tworzyć pierwsze workflow i zintegrujesz różne usługi w zaawansowane automatyzacje.
