![Przesłanie pobranych danych do komunikatora](/grafiki/m3_p5-przeslanie-danych-komunikator.png)

# Przesłanie pobranych - kanły odbiorcze



Po pobraniu i przetworzeniu danych często chcesz je wysłać do konkretnego miejsca – komunikatora firmowego (Slack, Discord, Teams), arkusza, bazy danych lub e-maila. n8n oferuje dedykowane node'y do najpopularniejszych serwisów.

---

### **Najpopularniejsze komunikatory w n8n**

**1. Slack**
- Wysyłanie wiadomości na kanały
- Wiadomości prywatne
- Aktualizowanie wiadomości
- Reakcje, wątki

**2. Discord**
- Wysyłanie wiadomości na serwery/kanały
- Embedy (bogate wiadomości z grafiką)
- Webhooki

**3. Microsoft Teams**
- Wiadomości do kanałów
- Powiadomienia
- Karty adaptacyjne

**4. Telegram**
- Boty
- Wiadomości do użytkowników/grup
- Inline keyboards

---

### **Przykład 1: Wysyłanie danych na Slacka**

Załóżmy, że pobierasz dane o pogodzie i chcesz wysłać je na kanał Slack.

**Krok 1: Przygotuj dane**
- Użyj node **HTTP Request**, aby pobrać dane o pogodzie
- Przykładowy output:
```json
{
  "city": "Warsaw",
  "temperature": 15.2,
  "description": "cloudy"
}
```

**Krok 2: Dodaj node Slack**
1. Dodaj node: **Slack**
2. Wybierz akcję: **Post Message**
3. Wybierz kanał (np. `#general`)
4. Wpisz wiadomość:
```
Pogoda w {{ $json.city }}:
Temperatura: {{ $json.temperature }}°C
Opis: {{ $json.description }}
```

**Krok 3: Uruchom workflow**
- Slack otrzyma wiadomość:
```
Pogoda w Warsaw:
Temperatura: 15.2°C
Opis: cloudy
```

---

### **Przykład 2: Wysyłanie embeda na Discorda**

Discord obsługuje bogate wiadomości (embedy) z grafiką, kolorami i polami.

**Krok 1: Dodaj node Discord**
1. Dodaj node: **Discord**
2. Wybierz akcję: **Send Message**
3. Podaj Webhook URL (utwórz go w ustawieniach kanału Discord)

**Krok 2: Przygotuj embed**
W polu "Message" wybierz tryb JSON i wpisz:
```json
{
  "embeds": [
    {
      "title": "Nowe zgłoszenie",
      "description": "{{ $json.message }}",
      "color": 3447003,
      "fields": [
        {
          "name": "Autor",
          "value": "{{ $json.name }}",
          "inline": true
        },
        {
          "name": "Email",
          "value": "{{ $json.email }}",
          "inline": true
        }
      ],
      "timestamp": "{{ $now }}"
    }
  ]
}
```

---

### **Przykład 3: Wysyłanie do Microsoft Teams**

**Krok 1: Uzyskaj Webhook URL**
- W Teams przejdź do kanału  Connectors  Incoming Webhook
- Skopiuj URL

**Krok 2: Dodaj node HTTP Request**
1. Metoda: **POST**
2. URL: (wklej webhook URL)
3. Body (JSON):
```json
{
  "@type": "MessageCard",
  "title": "Nowy raport",
  "text": "Dane zostały zaktualizowane: {{ $json.summary }}"
}
```

---

### **Formatowanie wiadomości**

**Markdown w Slack:**
```
*pogrubienie*
_kursywa_
~przekreślenie~
`kod`
```quote```
```

**Mentions w Slack:**
- Użytkownik: `<@USER_ID>`
- Kanał: `<#CHANNEL_ID>`
- Wszyscy: `<!channel>`

**Kolory w Discord embed:**
- Czerwony: 15158332
- Zielony: 3066993
- Niebieski: 3447003

---

### **Obsługa błędów i powiadomień**

Możesz wysyłać powiadomienia o błędach:

**Workflow:**
1. Dodaj node **Error Trigger** (uruchamia się przy błędzie)
2. Połącz z node'm Slack/Discord
3. Wiadomość:
```
⚠️ Błąd w workflow "{{ $workflow.name }}":
{{ $json.error.message }}
```

---

### **Inne miejsc docelowych dla danych**

- **Email** – node Gmail, SendGrid, SMTP
- **Google Sheets** – zapis do arkusza
- **Airtable** – dodawanie rekordów
- **Notion** – tworzenie stron/baz danych
- **Database** – MySQL, PostgreSQL, MongoDB
- **Webhook** – wysyłanie do dowolnego endpointu

---

**Podsumowanie:**
Wysyłanie danych to ostatni, ale kluczowy krok automatyzacji. Dzięki dedykowanym node'om możesz łatwo integrować n8n z komunikatorami, arkuszami, bazami danych i wieloma innymi usługami – wszystko bez konieczności ręcznego przesyłania informacji.