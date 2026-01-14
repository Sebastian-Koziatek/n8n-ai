# Przegląd najpopularniejszych node'ów

W n8n masz dostęp do setek node'ów. Na początku może to przytłaczać - od czego zacząć? 

Ta lekcja to Twój przewodnik po **20 najpopularniejszych node'ach**, które wykorzystasz w 90% swoich automatyzacji.

---

## Kategorie node'ów

Node'y możemy podzielić na kilka kategorii według tego, co robią:

**🎯 Triggery** - uruchamiają workflow
**📊 Przetwarzanie danych** - zmieniają, filtrują, sortują
**🔄 Logika** - podejmują decyzje
**📤 Wysyłka** - email, komunikatory, API
**💾 Przechowywanie** - bazy danych, pliki, arkusze
**🤖 AI i zaawansowane** - sztuczna inteligencja, przetwarzanie

---

## 🎯 Triggery - jak uruchomić workflow

### 1. Schedule Trigger ⏰

**Co robi:** Uruchamia workflow w określonym czasie.

**Kiedy używać:**
- Codzienne raporty o 8:00
- Co godzinę sprawdzaj coś
- Raz w tygodniu (każdy poniedziałek)
- Backup danych co noc

**Przykłady:**
- Codzienny newsletter
- Raport sprzedaży w piątki
- Monitoring stron co 15 minut

**Łatwość:** ⭐⭐⭐⭐⭐ (bardzo łatwy)

---

### 2. Webhook 🔗

**Co robi:** Czeka na połączenie z zewnątrz (otrzymanie danych).

**Kiedy używać:**
- Formularz na stronie wysyła dane
- Zewnętrzny system powiadamia o zdarzeniu
- API callback
- Integracje z innymi usługami

**Przykłady:**
- Formularz kontaktowy na stronie
- Stripe powiadamia o płatności
- Zapier/Make wysyła dane do n8n

**Łatwość:** ⭐⭐⭐⭐ (łatwy po zrozumieniu URL)

---

### 3. Email Trigger (IMAP) 📧

**Co robi:** Uruchamia się gdy otrzymasz nowego emaila.

**Kiedy używać:**
- Automatyczna obsługa emaili
- Przetwarzanie zamówień z emaila
- Reakcja na powiadomienia

**Przykłady:**
- Email od klienta → stwórz ticket
- Faktura w emailu → zapisz do Dropbox
- Newsletter od konkurencji → analizuj

**Łatwość:** ⭐⭐⭐ (wymaga konfiguracji IMAP)

---

### 4. Manual Trigger 👆

**Co robi:** Uruchamiasz workflow ręcznie przyciskiem.

**Kiedy używać:**
- Testowanie workflow
- Jednorazowe operacje
- Import danych na żądanie

**Przykłady:**
- Importuj CSV do bazy
- Wygeneruj raport teraz
- Wyślij testowego emaila

**Łatwość:** ⭐⭐⭐⭐⭐ (najłatwiejszy)

---

## 📊 Przetwarzanie danych

### 5. Set (Edit Fields) ✏️

**Co robi:** Zmienia, dodaje lub usuwa pola w danych.

**Kiedy używać:**
- Łączenie pól (imię + nazwisko)
- Zmiana nazw pól
- Dodawanie nowych wartości
- Czyszczenie niepotrzebnych danych

**Przykłady:**
- `firstName` + `lastName` = `fullName`
- Zmień `emailAddress` na `email`
- Dodaj obecną datę do danych
- Przeformatuj cenę

**Łatwość:** ⭐⭐⭐⭐ (intuicyjny)

---

### 6. Code (JavaScript/Python) 💻

**Co robi:** Pozwala pisać własny kod do przetwarzania danych.

**Kiedy używać:**
- Skomplikowane przekształcenia
- Obliczenia matematyczne
- Gdy inne node'y nie wystarczają
- Niestandardowa logika

**Przykłady:**
- Oblicz VAT i netto z brutto
- Formatuj dane do specyficznego JSON
- Pętla przez produkty i sumowanie

**Łatwość:** ⭐⭐ (wymaga znajomości programowania)

---

### 7. Merge 🔀

**Co robi:** Łączy dane z dwóch różnych źródeł.

**Kiedy używać:**
- Masz dane w dwóch miejscach i chcesz je połączyć
- Jak JOIN w SQL
- Wzbogacanie danych

**Przykłady:**
- Użytkownicy z CRM + zamówienia z e-commerce
- Dane z API + dane z arkusza
- Połącz po email lub ID

**Łatwość:** ⭐⭐⭐ (trzeba zrozumieć klucze)

---

### 8. Split Out 📑

**Co robi:** Dzieli jeden rekord na wiele (array → pojedyncze elementy).

**Kiedy używać:**
- Masz listę i chcesz przetworzyć każdy element osobno
- API zwraca 10 produktów, chcesz wysłać 10 osobnych emaili

**Przykłady:**
- Lista 5 użytkowników → 5 osobnych node'ów
- Array produktów → każdy produkt osobno
- Rozpakuj zagnieżdżone dane

**Łatwość:** ⭐⭐⭐⭐ (prosty)

---

## 🔄 Logika i kontrola

### 9. IF 🚦

**Co robi:** Rozdziela dane na 2 ścieżki (true/false) na podstawie warunku.

**Kiedy używać:**
- Decyzje tak/nie
- Filtrowanie z dwoma ścieżkami
- Różne akcje dla różnych danych

**Przykłady:**
- Zamówienie > 500 zł → manager | < 500 zł → auto-accept
- Email zawiera @firma.com → lista B2B | inny → B2C
- Godziny pracy → obsłuż teraz | po godzinach → jutro

**Łatwość:** ⭐⭐⭐⭐ (logiczny)

---

### 10. Switch 🎚️

**Co robi:** Rozdziela dane na wiele ścieżek w zależności od wartości.

**Kiedy używać:**
- Masz 3+ różnych przypadków
- Status, kategoria, priorytet

**Przykłady:**
- Status zamówienia: new/processing/shipped/delivered
- Kraj: PL/DE/UK/FR → różne zespoły
- Priorytet: low/medium/high/critical

**Łatwość:** ⭐⭐⭐ (prostszy niż wiele IF)

---

### 11. Filter 🔍

**Co robi:** Przepuszcza tylko dane spełniające warunek (reszta znika).

**Kiedy używać:**
- Chcesz tylko określone dane
- Jak filtr w Excelu
- Usuń niepotrzebne rekordy

**Przykłady:**
- Tylko aktywni użytkownicy
- Tylko zamówienia z ostatnich 7 dni
- Tylko emaile zawierające "urgent"

**Łatwość:** ⭐⭐⭐⭐ (prosty)

---

### 12. Loop Over Items 🔁

**Co robi:** Wykonuje część workflow dla każdego elementu osobno.

**Kiedy używać:**
- Musisz poczekać między operacjami
- Rate limiting w API
- Sekwencyjne przetwarzanie

**Przykłady:**
- Wyślij email z przerwą 2 sekundy między każdym
- API pozwala na 1 request/sekundę
- Przetwarzaj po kolei, nie wszystko naraz

**Łatwość:** ⭐⭐ (może być zagmatwany)

---

## 📤 Komunikacja i integracje

### 13. HTTP Request 🌐

**Co robi:** Wysyła zapytanie do API (pobiera lub wysyła dane).

**Kiedy używać:**
- Pobieranie danych z API
- Wysyłanie danych do zewnętrznego serwisu
- Integracje z systemami bez gotowego node'a

**Przykłady:**
- Pobierz pogodę z OpenWeatherMap
- Wyślij dane do własnego API
- Sprawdź status strony (HTTP GET)

**Łatwość:** ⭐⭐⭐ (wymaga podstawowej znajomości API)

---

### 14. Gmail 📬

**Co robi:** Wysyła emaile przez Gmail.

**Kiedy używać:**
- Powiadomienia email
- Potwierdzenia
- Raporty
- Newslettery (małe listy)

**Przykłady:**
- Wyślij potwierdzenie zamówienia
- Raport codzienny do zespołu
- Alert o błędzie

**Łatwość:** ⭐⭐⭐⭐ (łatwy po połączeniu konta)

---

### 15. Slack 💬

**Co robi:** Wysyła wiadomości na Slacka.

**Kiedy używać:**
- Powiadomienia dla zespołu
- Alerty
- Statusy workflow
- Monitoring

**Przykłady:**
- Nowe zamówienie → powiadomienie na #sales
- Błąd w workflow → @mention dev team
- Codzienne podsumowanie → #general

**Łatwość:** ⭐⭐⭐⭐ (łatwy)

---

### 16. Telegram 🤖

**Co robi:** Wysyła wiadomości na Telegram (boty, kanały).

**Kiedy używać:**
- Osobiste powiadomienia
- Boty dla klientów
- Alerty mobilne

**Przykłady:**
- Bot obsługi klienta
- Alerty na telefon
- Powiadomienia o zamówieniach

**Łatwość:** ⭐⭐⭐ (wymaga stworzenia bota)

---

## 💾 Przechowywanie danych

### 17. Google Sheets 📊

**Co robi:** Odczytuje i zapisuje dane w arkuszach Google.

**Kiedy używać:**
- Prosta baza danych
- Raporty w arkuszu
- Współdzielenie danych z zespołem

**Przykłady:**
- Zapisz zamówienia do arkusza
- Wczytaj listę produktów
- Loguj każde wykonanie workflow
- Dashboard w Sheets

**Łatwość:** ⭐⭐⭐⭐ (bardzo popularny, łatwy)

---

### 18. Google Drive 📁

**Co robi:** Zapisuje, pobiera i zarządza plikami na Drive.

**Kiedy używać:**
- Backup plików
- Przechowywanie raportów PDF
- Upload z workflow

**Przykłady:**
- Wygeneruj PDF i zapisz na Drive
- Pobierz plik z Drive do przetworzenia
- Archiwizuj faktury

**Łatwość:** ⭐⭐⭐⭐ (intuicyjny)

---

### 19. MySQL / PostgreSQL / MongoDB 🗄️

**Co robi:** Łączy się z bazą danych i wykonuje zapytania.

**Kiedy używać:**
- Masz własną bazę danych
- Potrzebujesz relacyjnych danych
- Zaawansowane zapytania

**Przykłady:**
- Pobierz użytkowników z bazy
- Zapisz zamówienie do DB
- Update statusu

**Łatwość:** ⭐⭐ (wymaga znajomości SQL)

---

## 🤖 AI i zaawansowane

### 20. OpenAI / Google Gemini 🧠

**Co robi:** Integracja z modelami AI (ChatGPT, Gemini).

**Kiedy używać:**
- Generowanie tekstu
- Analiza treści
- Odpowiadanie na pytania
- Tłumaczenia
- Streszczenia

**Przykłady:**
- Bot obsługi klienta
- Automatyczne odpowiedzi na emaile
- Generowanie opisów produktów
- Analiza sentymentu opinii

**Łatwość:** ⭐⭐⭐ (łatwy interfejs, ale wymaga API key)

---

## Dodatkowe popularne node'y

### 21. Wait ⏸️
Czeka określony czas przed dalszym wykonaniem (np. odczekaj 5 minut).

### 22. RSS Feed Reader 📰
Pobiera nowe artykuły z RSS/Atom feed.

### 23. HTML Extract 🕷️
Wyciąga dane ze stron HTML (web scraping).

### 24. Discord 🎮
Wysyła wiadomości na Discorda.

### 25. Airtable 🗂️
Praca z bazami Airtable (jak Sheets + DB).

### 26. Notion 📝
Integracja z Notion - tworzenie i edycja stron.

### 27. SSH 🖥️
Wykonuje komendy na serwerach przez SSH.

### 28. FTP 📂
Upload/download plików przez FTP/SFTP.

### 29. Execute Workflow 🔄
Uruchamia inny workflow z tego workflow.

### 30. Item Lists 📋
Operacje na listach (sortowanie, filtrowanie, limit).

---

## Jak wybierać node'y?

**Zadaj sobie pytania:**

**1. Co chcę osiągnąć?**
- Wysłać email? → Gmail / Send Email
- Zapisać dane? → Google Sheets / DB
- Pobrać dane? → HTTP Request / API
- Przetwarzać tekst AI? → OpenAI

**2. Skąd pochodzą dane?**
- Z formularza? → Webhook
- Z emaila? → Email Trigger
- Z API? → HTTP Request
- Regularnie? → Schedule

**3. Co mam zrobić z danymi?**
- Zmienić format? → Set
- Filtrować? → Filter / IF
- Połączyć? → Merge
- Rozdzielić? → Split

---

## Kombinacje - co z czym?

### Przykład 1: Codzienne raporty
```
Schedule → HTTP Request → Set → Google Sheets → Gmail
```
Co 24h → Pobierz dane → Formatuj → Zapisz → Wyślij email

### Przykład 2: Formularz kontaktowy
```
Webhook → IF → Slack + Gmail
```
Otrzymaj dane → Sprawdź czy urgent → Powiadomienia

### Przykład 3: AI Chatbot
```
Telegram Trigger → OpenAI → Telegram
```
Wiadomość od użytkownika → AI odpowiada → Wyślij odpowiedź

### Przykład 4: E-commerce automation
```
Webhook (Stripe) → Google Sheets → Switch → Gmail / Slack
```
Płatność → Zapisz → Sprawdź wartość → Odpowiednie powiadomienia

---

## Jak znaleźć node którego potrzebujesz?

**W interfejsie n8n:**

1. Kliknij "+" żeby dodać node
2. W wyszukiwarce wpisz co chcesz:
   - "email" → pokaże Gmail, Outlook, Send Email
   - "database" → MySQL, PostgreSQL, MongoDB
   - "sheets" → Google Sheets, Excel
   - "ai" → OpenAI, Gemini, AI Agent

3. Możesz też szukać po firmie:
   - "google" → wszystkie integracje Google
   - "microsoft" → Teams, Outlook, OneDrive
   - "slack" → wszystko związane ze Slackiem

**Dokumentacja:**
docs.n8n.io → pełna lista wszystkich node'ów z przykładami

---

## Dobre praktyki

**1. Zacznij od prostych**
Nie musisz od razu używać Code node czy zaawansowanych baz. Większość można zrobić z Set, IF i HTTP Request.

**2. Używaj tego co znasz**
Jeśli już używasz Google Sheets - użyj ich jako bazy. Jeśli masz Slacka - wyślij tam powiadomienia. Nie komplikuj.

**3. Czytaj opisy node'ów**
Każdy node ma opis i przykłady w n8n. Kliknij na node i zobacz co może robić.

**4. Testuj pojedynczo**
Dodaj node, skonfiguruj, uruchom "Execute Node" - zobacz czy działa. Potem dodaj kolejny.

**5. Nazywaj node'y**
Zamiast "HTTP Request", nazwij "Pobierz pogodę" - będziesz wiedział co robi.

---

## Podsumowanie - Top 5 dla początkujących

Jeśli dopiero zaczynasz, skup się na tych 5:

**1. Schedule lub Webhook** - uruchomienie workflow
**2. HTTP Request** - pobieranie danych z internetu
**3. Set** - przetwarzanie i formatowanie
**4. IF** - decyzje i logika
**5. Gmail lub Slack** - wysyłanie wyników

Z tymi 5 node'ami możesz już zbudować większość podstawowych automatyzacji!

Reszta przyjdzie z czasem, w miarę potrzeb.