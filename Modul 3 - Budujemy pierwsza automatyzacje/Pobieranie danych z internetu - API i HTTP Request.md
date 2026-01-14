# Pobieranie danych z internetu w n8n

Jednym z najważniejszych zastosowań n8n jest pobieranie i przetwarzanie danych z różnych źródeł internetowych. W tej lekcji nauczysz się, jak używać HTTP Request do komunikacji z API oraz jak wydobywać dane ze stron HTML.

---

## Czym jest API?

**API (Application Programming Interface)** to zestaw reguł i protokołów, które pozwalają aplikacjom komunikować się ze sobą. W kontekście pobierania danych z internetu, API działa jak "kelner" między Twoją aplikacją a serwerem:

1. **Twoja aplikacja** (n8n) wysyła zapytanie (request)
2. **API** przetwarza zapytanie i komunikuje się z bazą danych/systemem
3. **API** zwraca odpowiedź (response) w strukturalnym formacie (najczęściej JSON)

### Dlaczego API jest lepsze od zwykłego scrapingu?

**API:**
- Zwraca uporządkowane dane w formacie JSON/XML
- Szybsze i bardziej niezawodne
- Dokumentacja opisuje dostępne endpointy
- Często wymaga klucza API (autoryzacja)
- Legalne i zgodne z regulaminem serwisu

**Web Scraping (HTML Extract):**
- Pobiera surowy HTML strony
- Wymaga parsowania i ekstrakcji danych
- Może się zepsuć przy zmianach w wyglądzie strony
- Wolniejsze
- Używane gdy nie ma dostępnego API

---

## HTTP Request - komunikacja z API

Node **HTTP Request** w n8n to uniwersalne narzędzie do komunikacji z dowolnym API lub stroną internetową.

### Metody HTTP

Najważniejsze metody HTTP używane w komunikacji z API:

**GET** - Pobieranie danych
- Służy do odczytu informacji z serwera
- Nie modyfikuje danych
- Parametry przekazywane w URL
- Przykład: Pobranie listy użytkowników, artykułów, produktów

**POST** - Tworzenie nowych danych
- Wysyła dane do serwera
- Tworzy nowy zasób
- Dane w body request
- Przykład: Utworzenie nowego użytkownika, dodanie komentarza

**PUT** - Aktualizacja istniejących danych
- Aktualizuje cały zasób
- Przykład: Edycja profilu użytkownika

**PATCH** - Częściowa aktualizacja
- Aktualizuje tylko wybrane pola
- Przykład: Zmiana tylko adresu email

**DELETE** - Usuwanie danych
- Usuwa zasób
- Przykład: Usunięcie wpisu, użytkownika

W tej lekcji skupimy się na metodzie **GET**, która jest najczęściej używana do pobierania danych.

---

## Praktyka: HTTP Request GET w n8n

### Przykład 1: Publiczne API bez autoryzacji

Pobierzmy dane z publicznego API - **JSONPlaceholder** (testowe API):

**Krok 1: Dodaj node HTTP Request**
1. W workflow kliknij "+"
2. Znajdź i dodaj **HTTP Request**
3. Kliknij na node aby go skonfigurować

**Krok 2: Konfiguracja**
- **Method:** GET
- **URL:** `https://jsonplaceholder.typicode.com/users`
- **Authentication:** None

**Krok 3: Wykonaj**
- Kliknij "Execute Node"
- Zobaczysz listę 10 użytkowników w formacie JSON

**Co się stało?**
1. n8n wysłał zapytanie GET do API
2. API zwróciło dane 10 użytkowników
3. Dane są dostępne jako JSON do dalszego przetwarzania

### Przykład 2: API z parametrami w URL

Pobierzmy konkretnego użytkownika:

- **URL:** `https://jsonplaceholder.typicode.com/users/1`

Pobierzmy posty konkretnego użytkownika:

- **URL:** `https://jsonplaceholder.typicode.com/posts?userId=1`

**Parametry query (po znaku `?`):**
- `userId=1` - filtruje wyniki
- Można łączyć wieloma: `?userId=1&_limit=5`

### Przykład 3: API wymagające autoryzacji

Wiele API wymaga klucza API w nagłówku (header):

**Krok 1: Dodaj Header**
W node HTTP Request:
- Kliknij "Add Option" → "Headers"
- Dodaj parametr:
  - **Name:** `Authorization`
  - **Value:** `Bearer YOUR_API_KEY`

lub

- **Name:** `X-API-Key`
- **Value:** `YOUR_API_KEY`

**Uwaga:** Format autoryzacji zależy od API - sprawdź dokumentację!

### Przykład 4: OpenWeatherMap API

Pobierzmy pogodę z prawdziwego API:

**Krok 1: Zdobądź darmowy klucz API**
- Przejdź na: [https://openweathermap.org/api](https://openweathermap.org/api)
- Zarejestruj się (darmowe konto)
- Uzyskaj API Key

**Krok 2: HTTP Request w n8n**
- **Method:** GET
- **URL:** `https://api.openweathermap.org/data/2.5/weather?q=Warsaw&appid=YOUR_API_KEY&units=metric`

Parametry w URL:
- `q=Warsaw` - miasto
- `appid=YOUR_API_KEY` - twój klucz API
- `units=metric` - jednostki metryczne (Celsius)

**Wynik:** Otrzymasz dane o pogodzie w Warszawie w formacie JSON.

### Przykład 5: REST Countries API

Informacje o krajach:

- **URL:** `https://restcountries.com/v3.1/name/poland`

Zwraca szczegółowe informacje o Polsce: walutę, stolicę, populację, flagi itp.

---

## Przetwarzanie odpowiedzi JSON

Dane z API zwracane są w formacie JSON. W n8n możesz do nich odwołać się używając wyrażeń:

**Przykład JSON:**
```json
{
  "id": 1,
  "name": "John Doe",
  "email": "john@example.com",
  "address": {
    "city": "Warsaw",
    "street": "Main Street"
  }
}
```

**Wyrażenia w n8n:**
- `{{ $json.name }}` → "John Doe"
- `{{ $json.email }}` → "john@example.com"
- `{{ $json.address.city }}` → "Warsaw"

**Dla tablic (array):**
```json
[
  { "id": 1, "name": "John" },
  { "id": 2, "name": "Jane" }
]
```

- `{{ $json[0].name }}` → "John"
- `{{ $json[1].name }}` → "Jane"

---

## HTML Extract - pobieranie danych ze stron HTML

Czasami API nie jest dostępne i musisz pobrać dane bezpośrednio ze strony HTML. Node **HTML Extract** pozwala wyciągać konkretne informacje ze stron internetowych.

### Jak działa HTML Extract?

1. **Pobierasz stronę HTML** (używając HTTP Request)
2. **Wybierasz elementy** za pomocą selektorów CSS
3. **Wyciągasz tekst, atrybuty lub HTML** z tych elementów

### Selektory CSS - podstawy

Selektory CSS wskazują, które elementy na stronie chcesz wyciągnąć:

- **Tag:** `div`, `p`, `h1`, `a`, `img`
- **Klasa:** `.class-name` (elementy z class="class-name")
- **ID:** `#element-id` (element z id="element-id")
- **Atrybut:** `[href]`, `[data-id="123"]`
- **Hierarchia:** `div > p` (bezpośrednie dziecko), `div p` (potomek)
- **Kombinacje:** `div.article > h1.title`

### Praktyka: HTML Extract w n8n

**Przykład 1: Scraping tytułów artykułów**

**Krok 1: HTTP Request**
- **Method:** GET
- **URL:** `https://example.com/blog`
- **Response Format:** Text (ważne!)

**Krok 2: HTML Extract**
1. Dodaj node **HTML Extract**
2. Połącz z HTTP Request
3. Konfiguracja:

**Source Data:**
- Key: `html` (lub jak nazywa się pole z HTML)

**Extraction Values:**
- **Key:** `titles` (nazwa dla wyników)
- **CSS Selector:** `h2.post-title` (zależy od strony)
- **Return Value:** Text
- **Return Array:** Yes (jeśli jest wiele elementów)

**Wynik:** Otrzymasz tablicę wszystkich tytułów artykułów.

### Przykład 2: Scraping linków

**CSS Selector:** `a[href]`
**Return Value:** Attribute → `href`

Wyciąga wszystkie adresy URL z linków na stronie.

### Przykład 3: Scraping cen produktów

Załóżmy, że sklep ma produkty w HTML:
```html
<div class="product">
  <h3 class="name">Laptop Dell</h3>
  <span class="price">2999 PLN</span>
</div>
```

**Extraction Values:**
1. Nazwa produktu:
   - Key: `name`
   - CSS Selector: `.product .name`
   - Return Value: Text

2. Cena:
   - Key: `price`
   - CSS Selector: `.product .price`
   - Return Value: Text

### Przykład 4: Scraping obrazków

**CSS Selector:** `img.product-image`
**Return Value:** Attribute → `src`

Wyciąga URLe obrazków.

---

## Workflow: API + HTML Extract razem

**Scenariusz:** Pobierz artykuły z bloga i wyślij powiadomienie na Slacka

**Node 1: Schedule Trigger**
- Codziennie o 9:00

**Node 2: HTTP Request (API)**
- Pobierz listę artykułów z API (jeśli dostępne)
- LUB HTTP Request (HTML) + HTML Extract

**Node 3: Filter** (opcjonalnie)
- Filtruj tylko nowe artykuły

**Node 4: Slack**
- Wyślij tytuł i link do każdego artykułu

---

## Headers i opcje zaawansowane

### Najczęściej używane Headers

**Content-Type** - format danych w body:
- `application/json` - JSON
- `application/x-www-form-urlencoded` - form data
- `text/html` - HTML

**Accept** - jaki format chcesz otrzymać:
- `application/json`
- `text/html`

**User-Agent** - identyfikacja "przeglądarki":
```
Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36
```

Przydatne przy scrapingu - niektóre strony blokują requesty bez User-Agent.

### Timeout

Domyślnie n8n czeka 300 sekund (5 minut) na odpowiedź. Można zmienić:
- **Timeout:** 10000 (10 sekund)

### Response Format

- **JSON** - automatyczne parsowanie JSON
- **Text** - surowy tekst (do HTML Extract)
- **File** - zapisz jako plik

---

## Dobre praktyki

**Sprawdź dokumentację API:**
- Przeczytaj docs API przed użyciem
- Sprawdź limity (rate limits)
- Zrozum strukturę odpowiedzi

**Obsłuż błędy:**
- Dodaj node **IF** do sprawdzania statusu HTTP (200 = OK)
- Obsłuż 404, 500, 401 itp.

**Nie spamuj requestami:**
- Dodaj opóźnienia (node **Wait**)
- Szanuj rate limits API
- Dla scrapingu: 1-2 sekundy między requestami

**Używaj credentials:**
- Klucze API trzymaj w n8n Credentials (nie w URL!)
- Bezpiecznie i łatwo do zarządzania

**Testuj na małych zestawach:**
- Zanim uruchomisz workflow na 1000 elementów, przetestuj na 5

**Cache dla statycznych danych:**
- Jeśli dane rzadko się zmieniają, cachuj je

---

## Przydatne publiczne API do testów

**JSONPlaceholder** (fake data):
- [https://jsonplaceholder.typicode.com](https://jsonplaceholder.typicode.com)
- Users, posts, comments, photos

**REST Countries** (dane o krajach):
- [https://restcountries.com](https://restcountries.com)

**OpenWeatherMap** (pogoda):
- [https://openweathermap.org/api](https://openweathermap.org/api)

**CoinGecko** (kryptowaluty):
- [https://www.coingecko.com/en/api](https://www.coingecko.com/en/api)

**GitHub API** (repozytoria, issues):
- [https://api.github.com](https://api.github.com)

**News API** (wiadomości):
- [https://newsapi.org](https://newsapi.org)

**Cat Facts API** (losowe fakty o kotach):
- [https://catfact.ninja/fact](https://catfact.ninja/fact)

---

## Podsumowanie

Nauczyłeś się:
- Czym jest API i jak działa komunikacja HTTP
- Jak używać HTTP Request z metodą GET
- Jak autoryzować się w API (headers, API keys)
- Jak przetwarzać odpowiedzi JSON
- Jak używać HTML Extract do scrapingu stron
- Jak używać selektorów CSS
- Dobre praktyki i bezpieczeństwo

W kolejnych warsztatach wykorzystasz tę wiedzę do budowania zaawansowanych automatyzacji z integracjami zewnętrznych serwisów!
