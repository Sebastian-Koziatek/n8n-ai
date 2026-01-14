# Tryby działania workflow - Active i Inactive

<div align="center">
<img src="https://obrazy.sadmin.pl/active_inactive.png" width="75%">
</div>

---

Każdy workflow w n8n może być w dwóch stanach: **aktywny** (active) lub **nieaktywny** (inactive). To jak włącznik światła - albo działa, albo nie.

---

## Co to znaczy "Active"?

Gdy workflow jest **aktywny**, oznacza to że jest "na posterunku" - czeka na trigger i automatycznie wykonuje swoje zadanie bez Twojej interwencji.

**Przykład:**
Stworzyłeś workflow, który codziennie o 8:00 rano pobiera dane o pogodzie i wysyła je na Slacka. Gdy jest aktywny:
- Każdego dnia o 8:00 automatycznie się uruchamia
- Nie musisz nic robić
- Działa w tle
- Wykonuje się nawet jak masz zamknięty komputer (bo działa na serwerze n8n)

---

## Co to znaczy "Inactive"?

Gdy workflow jest **nieaktywny**, to jest jak wyłączony. Nic się nie dzieje automatycznie.

**Ale możesz go uruchomić ręcznie!**

Przycisk "Execute Workflow" (lub "Test Workflow") pozwala przetestować workflow bez aktywacji. To przydatne gdy:
- Dopiero tworzysz workflow i testujesz czy działa
- Chcesz uruchomić coś jednorazowo
- Sprawdzasz czy po zmianach wszystko działa poprawnie

---

## Kiedy workflow musi być Active?

Workflow **musi być aktywny** gdy:

**1. Ma trigger czasowy (Schedule)**
- Codziennie, co godzinę, w każdy poniedziałek
- Musi czekać na odpowiedni moment

**2. Ma trigger Webhook**
- Czeka na połączenie z zewnątrz
- Ktoś wysyła dane do Twojego workflow
- Musi być gotowy przyjąć te dane 24/7

**3. Ma trigger zdarzeniowy**
- Nowy email w skrzynce
- Nowy plik w folderze
- Nowa wiadomość na Slacku
- Zmiana w bazie danych

**Ogólna zasada:** Jeśli workflow ma działać automatycznie bez Ciebie - musi być active.

---

## Kiedy może być Inactive?

Workflow może pozostać nieaktywny gdy:

**1. Jest w budowie**
- Dopiero go tworzysz
- Testujesz poszczególne node'y
- Sprawdzasz czy dane przepływają poprawnie

**2. Jest do użytku manualnego**
- Używasz go tylko od czasu do czasu
- Uruchamiasz ręcznie przyciskiem
- Np. jednorazowy import danych

**3. Jest tymczasowo wyłączony**
- Robisz zmiany
- Debugujesz problem
- Czekasz na coś (np. aktualizację API)

**4. Jest szablonem/backup**
- Masz kopię workflow "na wszelki wypadek"
- Używasz go jako wzór do nowych workflow

---

## Jak aktywować workflow?

To bardzo proste:

**W prawym górnym rogu interfejsu n8n znajdziesz przełącznik:**
- **Inactive** (szary/czerwony) - workflow wyłączony
- **Active** (zielony) - workflow włączony

Kliknij raz, żeby przełączyć stan.

**Ważne:** Przed aktywacją upewnij się, że:
- Workflow działa poprawnie (przetestuj go!)
- Wszystkie credentials (hasła, klucze API) są ustawione
- Rozumiesz co workflow robi (żeby nie było niespodzianek)

---

## Co się dzieje po aktywacji?

**1. Trigger zaczyna działać**
- Schedule czeka na odpowiednią godzinę
- Webhook otrzymuje URL i czeka na połączenia
- Email trigger sprawdza skrzynkę

**2. Workflow pojawia się na liście aktywnych**
- W menu "Executions" zobaczysz historię uruchomień
- Możesz monitorować czy działa poprawnie

**3. n8n zapisuje każde wykonanie**
- Kiedy się uruchomił
- Czy zakończył się sukcesem czy błędem
- Jakie dane przepłynęły
- Ile czasu zajęło

---

## Manual vs Automatic execution

**Manual (ręczny):**
- Klikasz przycisk "Execute Workflow" lub "Test Workflow"
- Workflow uruchamia się natychmiast
- Działa na danych testowych lub aktualnych
- Nie musisz aktywować workflow
- Przydatne do testowania

**Automatic (automatyczny):**
- Workflow jest Active
- Uruchamia się sam w odpowiednim momencie
- Działa bez Twojej obecności
- Wymaga aktywacji
- Tak działają produkcyjne automatyzacje

---

## Execution history - historia uruchomień

Gdy workflow jest aktywny i uruchamia się automatycznie, n8n zapisuje każde wykonanie w historii.

**Co możesz zobaczyć:**
- **Data i godzina** - kiedy workflow się uruchomił
- **Status** - sukces (zielony) czy błąd (czerwony)
- **Czas trwania** - ile sekund zajęło wykonanie
- **Dane** - jakie informacje przepłynęły przez workflow
- **Błędy** - co poszło nie tak (jeśli był problem)

**Gdzie to znaleźć:**
Menu główne  **Executions**  lista wszystkich uruchomień

**Po co to?**
- Sprawdzisz czy workflow działa regularnie
- Zobaczysz czy są błędy
- Debug - znajdziesz gdzie jest problem
- Audyt - kto, co i kiedy

---

## Active workflow - dobre praktyki

**1. Nazywaj workflow sensownie**
-  "Workflow 1", "Test", "Nowy"
-  "Codzienne raporty sprzedaży", "Webhook Stripe - nowe płatności"

**2. Dodaj opis**
- W ustawieniach workflow możesz dodać notes
- Opisz co robi, kiedy się uruchamia, kto jest odpowiedzialny

**3. Testuj przed aktywacją**
- Uruchom kilka razy ręcznie
- Sprawdź czy dane są poprawne
- Zobacz czy wszystkie powiadomienia działają

**4. Monitoruj pierwsze dni**
- Po aktywacji regularnie sprawdzaj Executions
- Upewnij się że workflow uruchamia się zgodnie z planem
- Szukaj błędów

**5. Dodaj error workflow**
- Możesz utworzyć osobny workflow do obsługi błędów
- Gdy coś pójdzie nie tak, dostaniesz powiadomienie
- n8n ma wbudowaną funkcję "Error Workflow"

---

## Przykłady użycia

### Przykład 1: Codzienny raport pogody

**Workflow:**
1. Schedule Trigger - codziennie 7:00
2. HTTP Request - pobierz pogodę z API
3. Format danych
4. Slack - wyślij wiadomość

**Stan:** **ACTIVE** 
**Dlaczego?** Ma działać automatycznie każdego dnia.

---

### Przykład 2: Import danych z CSV

**Workflow:**
1. Manual Trigger (Read Binary File)
2. Wczytaj CSV
3. Przetworz dane
4. Zapisz do Google Sheets

**Stan:** **INACTIVE** 
**Dlaczego?** Używasz go tylko gdy masz nowy plik CSV. Uruchamiasz ręcznie.

---

### Przykład 3: Webhook do odbierania formularzy

**Workflow:**
1. Webhook Trigger
2. Walidacja danych
3. Zapisz do bazy
4. Wyślij email potwierdzający

**Stan:** **ACTIVE** 
**Dlaczego?** Musi być dostępny 24/7 żeby przyjmować formularze ze strony.

---

### Przykład 4: Newsletter raz w tygodniu

**Workflow:**
1. Schedule Trigger - każdy piątek 10:00
2. Pobierz artykuły z bloga
3. Wygeneruj HTML email
4. Wyślij do subskrybentów

**Stan:** **ACTIVE** 
**Dlaczego?** Ma działać automatycznie w piątki.

---

## Troubleshooting - częste problemy

### Problem: "Workflow nie uruchamia się automatycznie"

**Sprawdź:**
-  Czy workflow jest ACTIVE?
-  Czy trigger jest poprawnie skonfigurowany?
-  Czy czas w Schedule jest poprawny (strefa czasowa)?
-  Czy n8n działa (serwer uruchomiony)?

### Problem: "Webhook nie działa"

**Sprawdź:**
-  Czy workflow jest ACTIVE?
-  Czy URL webhooka jest poprawny?
-  Czy webhook jest typu Production (nie Test)?
-  Czy wysyłasz dane we właściwym formacie?

### Problem: "Workflow wykonuje się, ale są błędy"

**Sprawdź:**
- Historia wykonań (Executions)
- Kliknij na błędne wykonanie
- Zobacz w którym node'dzie wystąpił błąd
- Przeczytaj komunikat błędu
- Napraw problem i przetestuj ręcznie

### Problem: "Chcę zatrzymać workflow tymczasowo"

**Rozwiązanie:**
Po prostu ustaw na INACTIVE. Możesz go później ponownie aktywować.

---

## Kiedy deaktywować workflow?

**1. Robisz zmiany**
- Edytujesz node'y
- Zmieniasz logikę
- Testujesz nowe funkcje
 Wyłącz na czas zmian, włącz po testach

**2. Workflow już nie jest potrzebny**
- Kampania się skończyła
- Projekt zamknięty
- Dane już nie są aktualne
 Wyłącz lub usuń

**3. Jest problem, którego nie możesz szybko naprawić**
- Zewnętrzne API nie działa
- Brakuje Ci informacji
- Czekasz na wsparcie
 Wyłącz czasowo

**4. Wakacje/urlop**
- Jeśli workflow wymaga Twojej interwencji w razie problemów
- A nie ma kto go obsłużyć
 Rozważ wyłączenie

---

## Podsumowanie

**Active workflow:**
- Działa automatycznie
- Wymaga trigger (Schedule, Webhook, Event)
- Zapisuje historię wykonań
- Zawsze dostępny

**Inactive workflow:**
- Nie działa automatycznie
- Możesz uruchomić ręcznie do testów
- Nie zajmuje zasobów
- Bezpieczny do edycji

**Złota zasada:**
Jeśli workflow ma działać sam - musi być Active.
Jeśli uruchamiasz go ręcznie - może być Inactive.

Zawsze testuj przed aktywacją!