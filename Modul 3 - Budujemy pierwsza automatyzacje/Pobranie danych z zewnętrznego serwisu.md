![Pobieranie danych z zewnętrznego serwisu](https://obrazy.sadmin.pl/m3_p4-pobranie-danych-zewnetrznych.png)

# Pobieranie danych z zewnętrznego serwisu

Pobieranie danych z zewnętrznych serwisów to jeden z najczęstszych scenariuszy automatyzacji w n8n. Dzięki temu możesz integrować swoje workflow z dowolną usługą internetową, systemem lub aplikacją.

---

### **Jak można pobierać dane z zewnętrznych serwisów?**

#### 1. **Node HTTP Request**
Najbardziej uniwersalny sposób. Pozwala na komunikację z dowolnym API (GET, POST, PUT, DELETE).
- Wybierz metodę (najczęściej GET do pobierania danych)
- Podaj adres URL API
- Dodaj parametry, nagłówki, autoryzację jeśli wymaga tego serwis
- Przetwarzaj odpowiedź (najczęściej w formacie JSON)

**Przykład:**
Pobranie danych o pogodzie z OpenWeatherMap:
- URL: `https://api.openweathermap.org/data/2.5/weather?q=Warsaw&appid=TWÓJ_KLUCZ_API&units=metric`
- Wynik: JSON z informacjami o temperaturze, wilgotności, opisie pogody

#### 2. **Dedykowane node'y integracyjne**
W n8n znajdziesz gotowe node'y do najpopularniejszych serwisów:
- Google Sheets, Gmail, Drive
- Slack, Discord, Teams
- Airtable, Notion, Trello
- Bazy danych (MySQL, PostgreSQL, MongoDB)
- Serwisy e-commerce, CRM, social media

Node'y te mają uproszczoną konfigurację i automatycznie obsługują autoryzację oraz formatowanie danych.

#### 3. **Webhook**
Możesz skonfigurować node Webhook, który odbiera dane wysyłane z zewnętrznego serwisu (np. formularz na stronie, system zgłoszeń, inna aplikacja).
- Ustaw endpoint webhooka w n8n
- Skonfiguruj zewnętrzny serwis, aby wysyłał dane do tego adresu
- Dane pojawią się w workflow i mogą być dalej przetwarzane

#### 4. **Integracja przez OAuth2 lub API Key**
Wiele serwisów wymaga autoryzacji:
- API Key – klucz w nagłówku lub parametrze
- OAuth2 – logowanie przez konto Google, Facebook, Microsoft
- Basic Auth – login i hasło

n8n obsługuje te metody w node'ach HTTP Request oraz dedykowanych integracjach.

---

### **Praktyczny workflow: pobieranie danych z API i zapis do Google Sheets**

1. **HTTP Request** – pobierz dane z API (np. lista użytkowników)
2. **Set** – wyciągnij interesujące Cię pola
3. **Google Sheets** – zapisz dane do arkusza
4. **Slack** – wyślij powiadomienie o nowym wpisie

---

### **Wskazówki praktyczne**
- Sprawdź dokumentację API, z którego chcesz pobierać dane
- Testuj zapytania w node HTTP Request – zobacz, jak wygląda odpowiedź
- Używaj node'ów Set i Function do przetwarzania i filtrowania danych
- Zwracaj uwagę na limity API (rate limits)
- Dbaj o bezpieczeństwo kluczy API i danych

---

**Podsumowanie:**
W n8n możesz pobierać dane z dowolnego serwisu – przez HTTP Request, dedykowane node'y, webhooki czy integracje z autoryzacją. To otwiera ogromne możliwości automatyzacji i integracji w Twoich workflow.