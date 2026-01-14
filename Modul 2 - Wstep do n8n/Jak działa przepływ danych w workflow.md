# Jak działa przepływ danych w workflow

<div align="center">
<img src="/grafiki/workflow.png" alt="Przepływ danych w workflow" width="75%">
</div>

W n8n automatyzacje buduje się jak układankę - łącząc ze sobą różne node'y. Dane przepływają przez nie jak woda przez rurę - z jednego node'a do drugiego, zmieniając się po drodze.

Zrozumienie tego przepływu to klucz do tworzenia skutecznych automatyzacji.

---

## Podstawowa zasada: od lewej do prawej

W n8n workflow zawsze działa **od lewej do prawej**. 

Wyobraź sobie to jak linię produkcyjną w fabryce:
- **Lewa strona** - surowce wchodzą (trigger)
- **Środek** - przetwarzanie (node'y robią swoją robotę)
- **Prawa strona** - gotowy produkt wychodzi (email, baza danych, komunikator)

---

## Anatomia przepływu

### 1. Trigger - punkt startowy

Każdy workflow musi się od czegoś zacząć. To jest rola **triggera**:

**Trigger to jak przycisk "start":**
- Schedule: "Uruchom o 8:00"
- Webhook: "Uruchom gdy ktoś wyśle dane"
- Email: "Uruchom gdy dostanę maila"
- Manual: "Uruchom gdy kliknę przycisk"

**Bez triggera workflow nie ruszy.**

---

### 2. Node - punkt przetwarzania

Po triggerze dane trafiają do **node'ów**. Każdy node to jedno zadanie:

**Node jest jak stacja na linii produkcyjnej:**
- Jeden node pobiera dane z API
- Drugi je filtruje
- Trzeci formatuje
- Czwarty wysyła emaila

**Każdy node robi swoją małą część większego zadania.**

---

### 3. Połączenia - droga danych

**Strzałki między node'ami** to droga, którą płyną dane.

**Dane płyną tylko w jedną stronę** - od triggera w prawo. Nie możesz wysłać danych "wstecz".

**Ważne:** Dane z poprzedniego node'a są dostępne w następnym. Każdy kolejny node "widzi" co zrobił poprzedni.

---

## Format danych - JSON

Dane w n8n przechodzą w formacie **JSON** - to taki uniwersalny język danych.

### Jak wygląda JSON?

```json
{
  "imie": "Anna",
  "email": "anna@example.com",
  "wiek": 28
}
```

To jest jeden **item** (element danych). Node może przetwarzać:
- Jeden item (jedna osoba)
- Wiele items (lista osób)

---

## Jak dane przepływają - krok po kroku

### Przykład: Formularz kontaktowy

**Workflow:**
1. **Webhook** - odbiera dane z formularza
2. **Set** - czyści i formatuje dane
3. **IF** - sprawdza czy pilne
4. **Gmail** - wysyła email

**Co się dzieje z danymi:**

**Krok 1: Webhook otrzymuje:**
```json
{
  "name": "Jan Kowalski",
  "email": "JAN@EXAMPLE.COM",
  "message": "Pilne zapytanie!",
  "urgent": "yes"
}
```

**Krok 2: Set czyści dane:**
- Zmienia email na małe litery
- Łączy imię i nazwisko
```json
{
  "fullName": "Jan Kowalski",
  "email": "jan@example.com",
  "message": "Pilne zapytanie!",
  "isUrgent": true
}
```

**Krok 3: IF sprawdza:**
- Czy `isUrgent` = true?
- TAK → idzie ścieżką TRUE
- NIE → idzie ścieżką FALSE

**Krok 4: Gmail wysyła:**
- Używa danych z poprzednich kroków
- Wstawia `fullName` i `email` do treści maila

---

## Expressions - odwoływanie się do danych

W każdym node możesz użyć danych z poprzednich kroków używając **expressions** (wyrażeń).

### Podstawowa składnia

**Podwójne nawiasy klamrowe:**
```
{{ $json.nazwa_pola }}
```

### Przykłady

**Odczytaj imię:**
```
{{ $json.name }}
```

**Odczytaj email:**
```
{{ $json.email }}
```

**Połącz dwa pola:**
```
Witaj {{ $json.firstName }} {{ $json.lastName }}!
```

**Zagnieżdżone dane:**
```
{{ $json.address.city }}
{{ $json.user.profile.age }}
```

---

## Wiele items - przetwarzanie listy

Często node otrzymuje nie jeden, ale **wiele items** naraz.

### Przykład: Lista użytkowników

Trigger zwraca 3 osoby:

**Item 1:**
```json
{ "name": "Anna", "email": "anna@example.com" }
```

**Item 2:**
```json
{ "name": "Jan", "email": "jan@example.com" }
```

**Item 3:**
```json
{ "name": "Ola", "email": "ola@example.com" }
```

**Co się dzieje dalej?**

Domyślnie **każdy następny node przetwarza wszystkie items naraz**.

**Ale możesz:**
- **Filter** - wybrać tylko niektóre (np. tylko Anna)
- **Loop** - przetwarzać po kolei z przerwami
- **Split** - rozdzielić jeden item na wiele

---

## Przepływ rozgałęziony - wiele ścieżek

Node'y mogą rozdzielać przepływ na kilka ścieżek.

### IF - dwie ścieżki

```
Webhook → IF → TRUE → Slack (pilne)
              ↓
            FALSE → Email (normalne)
```

Dane idą tylko jedną ścieżką (albo TRUE, albo FALSE), nie obiema.

### Switch - wiele ścieżek

```
Webhook → Switch → Status "new" → Utwórz ticket
                  ↓
                Status "processing" → Aktualizuj status
                  ↓
                Status "done" → Wyślij podziękowanie
```

Każdy status idzie swoją drogą.

---

## Łączenie ścieżek - Merge

Jeśli masz dwie różne ścieżki i chcesz je połączyć, użyj **Merge node**.

```
API 1 → Pobierz użytkowników
                               ↘
                                 Merge → Połącz dane → Zapisz
                               ↗
API 2 → Pobierz zamówienia
```

Merge czeka aż obie ścieżki dostarczą dane, potem je łączy.

---

## Debugowanie przepływu - jak sprawdzić co się dzieje?

### 1. Execute Node (test pojedynczego node'a)

Kliknij na node → "Execute Node"
- Uruchamia tylko ten jeden node
- Zobaczysz co dostaje i co zwraca

### 2. Output panel (panel wyjściowy)

Po uruchomieniu workflow:
- Kliknij na dowolny node
- Po prawej stronie zobaczysz dane, które przez niego przeszły
- Sprawdź INPUT (co dostał) i OUTPUT (co zwrócił)

### 3. Executions history (historia uruchomień)

Menu → Executions
- Zobacz wszystkie uruchomienia workflow
- Sprawdź które zakończyły się sukcesem, które błędem
- Kliknij na wykonanie → zobacz szczegóły

---

## Praktyczne przykłady przepływu

### Przykład 1: Codzienne raporty

```
Schedule (8:00) 
  → HTTP Request (pobierz dane sprzedaży)
    → Set (przelicz sumy)
      → Gmail (wyślij raport do szefa)
```

**Przepływ danych:**
1. Schedule uruchamia o 8:00 (bez danych wejściowych)
2. HTTP Request dostaje pusty input, zwraca listę zamówień
3. Set dostaje zamówienia, oblicza sumy, zwraca podsumowanie
4. Gmail dostaje podsumowanie, wysyła email

### Przykład 2: Webhook + walidacja

```
Webhook (otrzymaj dane)
  → IF (czy email poprawny?)
    → TRUE → Google Sheets (zapisz)
              → Slack (powiadom zespół)
    → FALSE → HTTP Response (zwróć błąd)
```

**Przepływ danych:**
1. Webhook otrzymuje dane z formularza
2. IF sprawdza pole email
3. Jeśli poprawny - dane idą do Sheets i Slacka
4. Jeśli błędny - zwraca błąd do formularza

### Przykład 3: Przetwarzanie listy

```
HTTP Request (pobierz 100 produktów)
  → Filter (tylko produkty w promocji)
    → Set (dodaj nową cenę)
      → Loop (wysyłaj po 1 emailu co 2 sekundy)
        → Gmail (email do klienta o promocji)
```

**Przepływ danych:**
1. HTTP zwraca 100 produktów (100 items)
2. Filter zostawia 20 w promocji (20 items)
3. Set dodaje cenę promocyjną do każdego (20 items)
4. Loop przetwarza je pojedynczo z przerwą
5. Gmail wysyła 20 osobnych emaili

---

## Dobre praktyki przepływu

**1. Nie rób za długich workflow**
- Jeśli masz więcej niż 15 node'ów, rozważ podział
- Używaj Execute Workflow do wywoływania innych workflow

**2. Testuj po kolei**
- Dodaj node, przetestuj
- Dodaj kolejny, przetestuj
- Nie buduj całego workflow na raz

**3. Nazywaj node'y**
- Zamiast "HTTP Request" nazwij "Pobierz zamówienia z API"
- Zamiast "IF" nazwij "Sprawdź czy pilne"
- Będziesz wiedział co robi który node

**4. Używaj Sticky Notes**
- Dodawaj notatki do workflow
- "Tu pobieramy dane", "Tu sprawdzamy status"
- Pomoże Ci (i innym) zrozumieć co się dzieje

**5. Loguj ważne momenty**
- Przed długą operacją - zapisz dane do loga
- Po ważnej decyzji - zanotuj którą ścieżką poszło
- Ułatwi debugowanie

---

## Najczęstsze problemy

**Problem: "Node nie ma danych"**
- Sprawdź czy poprzedni node zwrócił dane
- Kliknij na poprzedni node → zobacz OUTPUT
- Może zwrócił pustą listę?

**Problem: "Expression nie działa"**
- Sprawdź czy nazwa pola jest poprawna
- `{{ $json.email }}` nie `{{ $json.Email }}`
- Wielkość liter ma znaczenie!

**Problem: "Workflow się nie uruchamia"**
- Czy jest ACTIVE?
- Czy trigger jest poprawnie skonfigurowany?
- Czy n8n działa (serwer uruchomiony)?

**Problem: "Dane się gubią"**
- Sprawdź czy Filter nie usunął wszystkich items
- Może IF poszło nie tą ścieżką co myślałeś?
- Sprawdź historię wykonań

---

## Podsumowanie

**Przepływ w n8n to:**
1. **Trigger** uruchamia workflow
2. **Dane płyną** od lewej do prawej
3. **Każdy node** przetwarza dane i przekazuje dalej
4. **Expressions** pozwalają odwoływać się do danych
5. **Rozgałęzienia** kierują dane różnymi ścieżkami
6. **Wszystko widoczne** w output panel

**Zapamiętaj:**
- Dane zawsze idą do przodu (od lewej do prawej)
- Każdy node widzi dane z poprzedniego kroku
- Testuj często, debuguj regularnie
- Nazywaj wszystko sensownie

Teraz rozumiesz jak płyną dane przez n8n. Czas zbudować swój pierwszy workflow!