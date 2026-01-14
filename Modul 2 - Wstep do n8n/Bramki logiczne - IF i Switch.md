# Bramki logiczne - IF i Switch

<div align="center">
<img src="/grafiki/bramki-logiczne.png" alt="Bramki logiczne" width="75%">
</div>

Bramki logiczne to node'y, które pozwalają Twojemu workflow podejmować decyzje. Zamiast robić zawsze to samo, workflow może reagować różnie w zależności od danych.

To jak rozjazd na drodze - w zależności od warunków, dane idą w różne strony.

---

## Po co bramki logiczne?

Wyobraź sobie workflow, który odbiera zgłoszenia z formularza kontaktowego. Chcesz:
- **Pilne zgłoszenia**  natychmiast wysłać SMS do szefa
- **Standardowe**  dodać do kolejki, email do zespołu
- **Spam**  zignorować

Bez bramek logicznych musiałbyś mieć 3 osobne workflow. Z bramkami - jeden workflow, który sam decyduje co zrobić.

---

## Node IF - podstawowa bramka

**Node IF** to najprostsza bramka. Sprawdza jeden lub więcej warunków i dzieli przepływ na **dwie ścieżki**:
- **TRUE** (prawda) - gdy warunek jest spełniony
- **FALSE** (fałsz) - gdy warunek nie jest spełniony

### Jak to działa?

Podobnie jak w życiu:
- **JEŚLI** temperatura jest poniżej 0°C **TO** załóż kurtkę **W PRZECIWNYM RAZIE** wystarczy bluza

W n8n:
- **JEŚLI** wiek >= 18 **TO** wyślij na ścieżkę TRUE **W PRZECIWNYM RAZIE** wyślij na FALSE

---

## Przykłady użycia IF

### Przykład 1: Filtrowanie według wartości zamówienia

**Scenariusz:** Otrzymujesz zamówienia. Drogie zamówienia (>500 zł) wymagają potwierdzenia.

**Konfiguracja IF:**
- Warunek: `{{ $json.orderValue }}` > 500

**Ścieżka TRUE:**
- Wyślij email do managera z prośbą o potwierdzenie

**Ścieżka FALSE:**
- Automatycznie zaakceptuj i przetwórz zamówienie

---

### Przykład 2: Sprawdzanie domen email

**Scenariusz:** Rejestracje z firmowych emaili (@company.com) trafiają do innej listy niż prywatne.

**Konfiguracja IF:**
- Warunek: `{{ $json.email }}` zawiera "@company.com"

**Ścieżka TRUE:**
- Dodaj do listy "Klienci korporacyjni"
- Wyślij email z ofertą B2B

**Ścieżka FALSE:**
- Dodaj do listy "Klienci indywidualni"
- Wyślij standardowy email powitalny

---

### Przykład 3: Godziny pracy

**Scenariusz:** Zgłoszenia w godzinach pracy  natychmiastowa obsługa. Po godzinach  kolejka na jutro.

**Konfiguracja IF:**
- Warunek: `{{ $now.hour() }}` >= 8 AND `{{ $now.hour() }}` < 17

**Ścieżka TRUE (8:00-17:00):**
- Wyślij powiadomienie do zespołu na Slacka
- Utwórz ticket z priorytetem HIGH

**Ścieżka FALSE (po godzinach):**
- Dodaj do kolejki
- Wyślij auto-reply "Odezwiemy się jutro"

---

## Wiele warunków w IF

Node IF może sprawdzać **wiele warunków naraz**:

**AND (i)** - wszystkie muszą być prawdziwe
- Wiek >= 18 **AND** kraj = "Polska"
- Oba warunki muszą być spełnione

**OR (lub)** - wystarczy jeden prawdziwy
- Status = "Premium" **OR** zamówienie > 1000 zł
- Wystarczy że jeden z warunków jest spełniony

---

## Node Switch - wiele ścieżek

**Node Switch** to zaawansowana wersja IF. Zamiast dwóch ścieżek (true/false) możesz mieć **wiele różnych ścieżek**.

To jak dystrybutor w budynku - listonosz sprawdza numer mieszkania i wrzuca list do odpowiedniej skrzynki.

### Kiedy używać Switch zamiast IF?

**IF - gdy masz 2 opcje:**
- Tak lub nie
- Duże lub małe
- Aktywny lub nieaktywny

**Switch - gdy masz 3+ opcji:**
- Status zamówienia: Nowe / W realizacji / Wysłane / Dostarczone / Anulowane
- Priorytet: Niski / Średni / Wysoki / Krytyczny
- Kategoria produktu: Elektronika / Odzież / Jedzenie / Sport / Inne

---

## Przykłady użycia Switch

### Przykład 1: Status zamówienia

**Scenariusz:** W zależności od statusu zamówienia, wykonujesz różne akcje.

**Konfiguracja Switch:**
Sprawdzaj pole: `{{ $json.orderStatus }}`

**Ścieżka 1: "new"**
- Wyślij email potwierdzający
- Dodaj do kolejki produkcji

**Ścieżka 2: "processing"**
- Wyślij powiadomienie "Przygotowujemy zamówienie"

**Ścieżka 3: "shipped"**
- Wyślij numer przesyłki
- Zapisz datę wysyłki

**Ścieżka 4: "delivered"**
- Poproś o opinię
- Zaproponuj następny zakup

**Ścieżka domyślna (fallback):**
- Cokolwiek innego  loguj błąd

---

### Przykład 2: Priorytetyzacja zgłoszeń

**Scenariusz:** Zgłoszenia klientów mają różne priorytety.

**Konfiguracja Switch:**
Sprawdzaj pole: `{{ $json.priority }}`

**Ścieżka "critical":**
- SMS do managera
- Slack z @mention całego zespołu
- Email z czerwonym flagiem
- Ticket z SLA 1 godzina

**Ścieżka "high":**
- Slack do zespołu support
- Email do odpowiedzialnego
- Ticket z SLA 4 godziny

**Ścieżka "normal":**
- Dodaj do kolejki
- Email potwierdzający
- Standardowy SLA 24h

**Ścieżka "low":**
- Kolejka niskiego priorytetu
- Auto-reply
- SLA 48h

---

### Przykład 3: Routing według kraju

**Scenariusz:** Klienci z różnych krajów obsługiwani przez różne zespoły.

**Konfiguracja Switch:**
Sprawdzaj pole: `{{ $json.country }}`

**Ścieżka "Poland":**
- Wyślij do zespołu PL
- Email po polsku
- Zapisz do bazy PL

**Ścieżka "Germany":**
- Wyślij do zespołu DE
- Email po niemiecku
- Zapisz do bazy DE

**Ścieżka "UK":**
- Wyślij do zespołu UK
- Email po angielsku
- Zapisz do bazy UK

**Ścieżka domyślna:**
- Wyślij do zespołu International
- Email po angielsku

---

## Różnica między IF a Switch

| Funkcja | IF | Switch |
|---------|----|----|
| Liczba ścieżek | 2 (True/False) | 3+ (dowolnie wiele) |
| Typ warunku | Porównanie (>, <, =) | Dopasowanie wartości |
| Kiedy używać | Proste decyzje tak/nie | Wiele różnych przypadków |
| Przykład | Wiek >= 18 | Status: new/processing/shipped |

**Prościej:**
- IF = "Czy jest X?"  Tak lub Nie
- Switch = "Jaki jest X?"  A, B, C, D lub coś innego

---

## Łączenie bramek

Możesz łączyć IF i Switch, tworząc bardziej skomplikowane drzewa decyzyjne.

### Przykład: System obsługi klienta

```
1. IF: Czy klient jest Premium?
   
   TRUE  Switch: Jaki priorytet zgłoszenia?
           - Critical  Natychmiastowa obsługa
           - High  Priorytet w kolejce
           - Normal  Standardowa kolejka
   
   FALSE  IF: Czy wartość zamówień > 1000 zł?
            TRUE  Średni priorytet
            FALSE  Niska kolejka
```

---

## Filter vs IF - jaka różnica?

**Node Filter:**
- **Usuwa** dane, które nie spełniają warunku
- Dalej idą **tylko** te, które przeszły
- Jak sito - przepuszcza tylko wybrane

**Node IF:**
- **Rozdziela** dane na dwie ścieżki
- **Obie ścieżki** dostają dane
- Jak rozjazd - każda strona może coś innego zrobić

**Przykład:**

**Z Filter:**
- Masz 100 zamówień
- Filter: tylko zamówienia > 500 zł
- Dalej idzie 20 zamówień (reszta znikła)

**Z IF:**
- Masz 100 zamówień
- IF: zamówienia > 500 zł?
- TRUE: 20 zamówień  wysłij do managera
- FALSE: 80 zamówień  standardowa obsługa
- **Wszystkie 100 jest obsłużonych**, tylko różnie

---

## Warunki - jak je pisać?

### Podstawowe operatory

**Równość:**
- `{{ $json.status }}` równa się "active"
- `{{ $json.age }}` równa się 25

**Porównania liczb:**
- `{{ $json.price }}` > 100 (większe niż)
- `{{ $json.quantity }}` < 10 (mniejsze niż)
- `{{ $json.score }}` >= 50 (większe lub równe)

**Zawieranie tekstu:**
- `{{ $json.email }}` zawiera "@gmail.com"
- `{{ $json.description }}` zawiera "urgent"

**Puste wartości:**
- `{{ $json.phone }}` jest puste
- `{{ $json.notes }}` nie jest puste

**Prawda/Fałsz:**
- `{{ $json.isActive }}` równa się true
- `{{ $json.isPremium }}` równa się false

---

## Dobre praktyki

**1. Zawsze obsłuż obie ścieżki**
Nawet jeśli FALSE nic nie robi, dodaj tam node Sticky Note z komentarzem "Ignorujemy" - dla przejrzystości.

**2. Używaj czytelnych nazw**
Nazwij node IF opisowo:
-  "IF"
-  "IF: Sprawdź czy Premium"
-  "IF: Filtruj według wartości"

**3. Testuj brzegowe przypadki**
- Co jeśli wartość jest dokładnie 500? (nie >500, nie <500)
- Co jeśli pole jest puste?
- Co jeśli dane są w innym formacie?

**4. Switch - zawsze dodaj fallback**
"Default" ścieżka dla przypadków, których nie przewidziałeś.

**5. Nie rób za głębokich zagnieżdżeń**
IF  IF  IF  IF = trudny do czytania
Lepiej użyć Switch lub podzielić na mniejsze workflow.

---

## Częste błędy

### Błąd 1: Zapomnienie o wielkości liter

```
Warunek: status = "Active"
Dane: status = "active"
Wynik: FALSE (bo "Active" ≠ "active")
```

**Rozwiązanie:** Konwertuj do lowercase przed porównaniem lub używaj opcji "ignore case"

### Błąd 2: Porównywanie tekstu z liczbą

```
Warunek: age > 18
Dane: age = "25" (tekst, nie liczba)
Wynik: Błąd lub nieprzewidywalne zachowanie
```

**Rozwiązanie:** Upewnij się że typy danych się zgadzają

### Błąd 3: Nieobsłużone NULL/empty

```
Warunek: email zawiera "@"
Dane: email = null
Wynik: Błąd
```

**Rozwiązanie:** Najpierw sprawdź czy pole nie jest puste

---

## Praktyczny przykład: System powiadomień

**Workflow: Nowe zamówienie e-commerce**

**1. Webhook** - otrzymaj dane o zamówieniu

**2. IF: Czy klient jest nowy?**
- TRUE  Wyślij email powitalny + kod rabatowy
- FALSE  Kontynuuj

**3. Switch: Wartość zamówienia**
- < 100 zł  Email standardowy
- 100-500 zł  Email + SMS
- > 500 zł  Email + SMS + telefon od managera

**4. IF: Czy jest w magazynie?**
- TRUE  Rozpocznij pakowanie
- FALSE  Email "Towar w drodze, wyślemy za 2 dni"

**5. IF: Czy dostawa express?**
- TRUE  Powiadomienie do kuriera priorytetowego
- FALSE  Standardowy kurier

Jeden workflow, wiele ścieżek - wszystko zależy od danych!

---

## Podsumowanie

**IF (jeśli):**
- 2 ścieżki: True i False
- Proste decyzje tak/nie
- Warunki: porównania, zawieranie, prawda/fałsz

**Switch (przełącznik):**
- Wiele ścieżek (3, 5, 10...)
- Dopasowanie wartości
- Lepszy gdy masz wiele opcji

**Kiedy używać:**
- IF: "Czy klient jest Premium?"  Tak/Nie
- Switch: "Jaki jest status?"  New/Processing/Shipped/Delivered

**Zasada:**
Bramki logiczne sprawiają, że Twoje workflow są **inteligentne** - reagują na różne sytuacje zamiast robić zawsze to samo.