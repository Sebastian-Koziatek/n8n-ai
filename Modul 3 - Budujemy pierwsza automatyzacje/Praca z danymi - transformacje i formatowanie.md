# Praca z danymi - transformacje i formatowanie

W n8n dane przepływają między node'ami jak wiadomości - każdy node odbiera informacje, przetwarza je i przekazuje dalej. Często te dane trzeba przekształcić, oczyścić lub odpowiednio sformatować, zanim trafią do miejsca docelowego.

W tej lekcji nauczysz się, jak przygotowywać dane tak, aby wyglądały dobrze w emailu, komunikatorze czy arkuszu kalkulacyjnym.

---

## Po co przetwarzać dane?

Wyobraź sobie, że pobierasz dane z systemu CRM o nowym kliencie. System zwraca Ci:
- `firstName`: Jan
- `lastName`: Kowalski  
- `emailAddress`: JAN.KOWALSKI@EXAMPLE.COM
- `createdAt`: 2026-01-14T10:30:00Z

Ale chcesz wysłać powitalnego maila, który wygląda profesjonalnie:
- Pełne imię i nazwisko razem: "Jan Kowalski"
- Email małymi literami: "jan.kowalski@example.com"
- Data w polskim formacie: "14.01.2026"

To właśnie jest transformacja danych - przygotowanie ich do użycia.

---

## Node Set - podstawowe przekształcanie

**Node Set** to narzędzie do szybkich zmian w danych. Możesz nim:
- Połączyć kilka pól w jedno (np. imię + nazwisko = pełne imię)
- Zmienić nazwy pól na bardziej zrozumiałe
- Usunąć niepotrzebne informacje
- Przeliczyć wartości (np. dolary na złotówki)

**Przykład użycia:**
Masz dane z formularza: `firstName`, `lastName`, ale w emailu chcesz użyć `fullName`. W node Set po prostu łączysz te dwa pola w jedno.

---

## Node IF - rozdzielanie danych

**Node IF** działa jak rozjazd na drodze - dane mogą pójść w dwie różne strony w zależności od warunków.

**Praktyczny przykład:**
- Jeśli klient zamówił za więcej niż 500 zł  wyślij mu voucher rabatowy
- Jeśli zamówił za mniej  wyślij standardowe podziękowanie

To samo narzędzie możesz użyć do filtrowania - np. wysyłaj powiadomienia tylko o zamówieniach ze statusem "opłacone".

---

## Merge i Split - łączenie i rozdzielanie

**Node Merge** łączy dane z dwóch źródeł - jak sklejanie dwóch tabel w Excelu.

**Przykład:** 
Masz listę klientów i listę ich ostatnich zamówień. Merge połączy je tak, że przy każdym kliencie będziesz miał informację o jego zamówieniu.

**Node Split** robi odwrotnie - jeśli masz jeden duży zbiór danych, może go rozdzielić na mniejsze części.

**Przykład:**
Otrzymujesz listę 10 użytkowników naraz, ale chcesz dla każdego wysłać osobnego maila. Split przekształci jeden zestaw z 10 osobami na 10 osobnych zestawów danych.

---

## Formatowanie email - HTML vs zwykły tekst

### Dlaczego HTML?

Współczesne maile to nie tylko prosty tekst. Większość klientów email (Gmail, Outlook, Apple Mail) obsługuje **format HTML** - czyli te same technologie, które tworzą strony internetowe.

Dzięki temu w emailu możesz mieć:
- **Ładne czcionki i kolory** - nie tylko czarny tekst
- **Przyciski** - kolorowe, wyróżnione, klikalne
- **Tabele** - przejrzyste zestawienia danych
- **Obrazki i logo** - profesjonalny wygląd
- **Linki** - wyróżnione i łatwe do kliknięcia

### Różnica między zwykłym tekstem a HTML

**Email tekstowy:**
```
Witaj Jan!

Dziekujemy za rejestracje.
Twoje dane:
- Email: jan@example.com
- Data: 14.01.2026

Kliknij link aby aktywowac konto:
https://example.com/activate?token=abc123
```

Wygląda prosto, bez żadnych udzików. Działa zawsze, ale nie przykuwa uwagi.

**Ten sam email w HTML:**

Będzie miał:
- Kolorowy nagłówek z Twoim logo
- Ładną czcionkę i odstępy
- Zielony przycisk "Aktywuj konto"
- Dane w czytelnej ramce
- Stopkę z informacjami o firmie

To jak różnica między czarno-białą gazetą a kolorowym magazynem.

### Struktura email HTML

Email HTML ma trzy części:

**1. Nagłówek (Header)**
Zazwyczaj z logo firmy, tytułem. Często w kolorze firmowym. To pierwsze, co widzi odbiorca.

**2. Treść (Content)**
Główna wiadomość - powitanie, informacje, dane. Tutaj przekazujesz najważniejszą treść.

**3. Stopka (Footer)**
Informacje o firmie, dane kontaktowe, link do wypisania się z newslettera. Mniejsza czcionka, mniej wyróżniona.

### Ważne: zachowanie formatowania

Klienci email nie działają jak przeglądarki - są bardziej wymagający. Dlatego:

**Inline CSS** - style muszą być wpisane bezpośrednio w tagi HTML, nie w osobnym pliku
```
<div style="color: red; font-size: 16px;">
```

**Szerokość 600px** - to standard. Większość ekranów email pokazuje maile w takiej szerokości. Na telefonie automatycznie się dopasuje.

**Testuj!** - Gmail pokazuje email inaczej niż Outlook. Zawsze sprawdź na różnych urządzeniach.

---

## Email - plain text jako bezpiecznik

Nie wszyscy odbiorcy mają włączone HTML. Niektóre firmy blokują HTML ze względów bezpieczeństwa. Dlatego zawsze **dodaj wersję tekstową** (plain text) jako backup.

Jeśli HTML się nie wyświetli, odbiorca zobaczy wersję tekstową. To jak napisy w filmie - nie zawsze potrzebne, ale jak trzeba, to są.

---

## Formatowanie w komunikatorach

Każdy komunikator ma swoje zasady formatowania. To jak różne języki - wszędzie mówisz "cześć", ale inaczej to brzmi.

### Slack - własny Markdown

Slack ma swoją składnię:

**Pogrubienie:**
`*tekst*` wyświetli się jako **tekst**

**Kursywa:**
`_tekst_` wyświetli się jako _tekst_

**Link:**
`<https://example.com|Kliknij tutaj>` - link z własnym tekstem

**Emoji:**
`:smile:` zamieni się na 
`:fire:` zamieni się na 

Slack nie obsługuje pełnego HTML, więc używasz tych prostych znaczników.

### Discord - klasyczny Markdown

Discord używa standardowego Markdown (tego samego co np. GitHub):

**Pogrubienie:**
`**tekst**`  **tekst**

**Kursywa:**
`*tekst*`  _tekst_

**Link:**
`[Kliknij tutaj](https://example.com)`

### Telegram - HTML Light

Telegram akceptuje podstawowe tagi HTML:

`<b>pogrubienie</b>`  **pogrubienie**
`<i>kursywa</i>`  _kursywa_
`<a href="link">tekst</a>`  link z tekstem

Nie możesz tutaj wstawiać skomplikowanych tabel czy stylizacji, ale podstawy działają.

### Messenger/WhatsApp - tylko tekst

WhatsApp i Facebook Messenger **nie obsługują** żadnego formatowania. Wysyłasz zwykły tekst z emoji. Kropka.

---

## Różnice w wyglądzie formatów

### Tabele - dlaczego są trudne?

W Excelu czy Google Sheets tworzenie tabeli to sekunda. W emailu HTML to już sztuka.

**W arkuszu:**
Klikasz, wpisujesz, gotowe. Wszystko się ładnie układa.

**W emailu HTML:**
Musisz zdefiniować każdą komórkę, nadać jej szerokość, kolor, obramowanie. Jeden błąd i tabela się rozjeżdża w Outlooku.

**W Slacku:**
Nie ma tabel. Możesz użyć "code block" (potrójny backtick ` ``` `), żeby tekst wyglądał tabelarycznie, ale to nie prawdziwa tabela.

**Rozwiązanie:**
W n8n możesz użyć node Code, żeby automatycznie wygenerować tabelę HTML z Twoich danych. Nie musisz tego robić ręcznie.

### Listy i wypunktowania

**Email HTML:** Możesz mieć kolorowe punktorki, numerowanie, zagnieżdżone listy
**Slack/Discord:** Zwykłe gwiazdki lub myślniki na początku linii
**Telegram:** Tylko tekst z emoji jako "punktorki"

### Obrazki

**Email HTML:** Możesz wstawiać obrazki, logo, banery. Pamiętaj tylko, że muszą być hostowane online (link do obrazka), nie załączone.

**Slack/Discord:** Obrazki wstawiają się automatycznie po podaniu linku.

**Telegram:** Obrazki i pliki osobno od tekstu (nie możesz wpleść obrazka w środek tekstu jak w emailu).

---

## Praktyczny przykład: newsletter

Wyobraź sobie, że codziennie wysyłasz newsletter z 3 nowymi artykułami z bloga.

### Co musisz zrobić?

**1. Pobrać artykuły** (HTTP Request do API bloga)

**2. Przefiltrować** (tylko dzisiejsze artykuły)

**3. Przekształcić dane:**
- Tytuł każdego artykułu
- Krótki opis
- Link do pełnej wersji

**4. Sformatować do email HTML:**
- Nagłówek: "Dziś w naszym blogu"
- Dla każdego artykułu: ładna ramka z tytułem, opisem i przyciskiem "Czytaj więcej"
- Stopka: informacje o firmie, link do wypisania się

**5. Wysłać** (Gmail/SendGrid/Mailchimp)

W n8n możesz to wszystko zautomatyzować - raz ustawisz, a potem działa samo każdego dnia.

---

## Zachowanie struktury danych

Często przesyłasz dane z jednego systemu do drugiego. Ważne, żeby zachować ich strukturę.

**Przykład:**
Pobierasz zamówienie z WooCommerce i chcesz je zapisać w Google Sheets.

WooCommerce daje Ci:
- Numer zamówienia
- Imię i nazwisko klienta
- Lista produktów (może być 1 produkt lub 10)
- Cena całkowita
- Data zamówienia

Google Sheets oczekuje jednego wiersza z danymi. Ale co z tą listą produktów?

**Rozwiązanie 1:** Zapisz produkty jako tekst rozdzielony przecinkami
**Rozwiązanie 2:** Użyj node Split i stwórz osobny wiersz dla każdego produktu
**Rozwiązanie 3:** Zapisz tylko nazwę pierwszego produktu + liczbę wszystkich

Wybór zależy od tego, jak chcesz później analizować dane.

---

## Dobre praktyki

### Dla email:

**Zawsze testuj** - wyślij sobie testowego maila i sprawdź na telefonie i komputerze

**Dodaj plain text** - nie każdy ma włączony HTML

**Nie przesadzaj z kolorami** - zbyt kolorowy email wygląda jak spam

**Dodaj link do wypisania się** - to wymóg prawny w większości krajów

**Logo i obrazki muszą być online** - nie załączaj ich, tylko podaj link

### Dla komunikatorów:

**Krótko i zwięźle** - nikt nie chce czytać romansu na Slacku

**Używaj emoji** - pomagają w czytelności i dodają emocji

**Testuj formatowanie** - przed wysłaniem sprawdź czy działa

**Nie używaj HTML w Slacku** - nie zadziała

### Ogólne:

**Myśl o odbiorcy** - czy to dla niego czytelne?

**Pilnuj danych osobowych** - nie wysyłaj wszystkich danych wszędzie

**Loguj błędy** - jeśli coś nie działa, chcesz wiedzieć co i kiedy

---

## Najczęstsze problemy

**Email wygląda źle w Outlooku**
To częsty problem. Outlook używa starej wersji silnika HTML (Word!). Rozwiązanie: używaj prostych struktur i inline CSS.

**Dane nie wyświetlają się**
Sprawdź czy nazwa pola jest poprawna. W n8n wielkość liter ma znaczenie: `email` to nie to samo co `Email`.

**Formatowanie znika**
Slack i Discord mają własne zasady. Nie użyjesz tam pełnego HTML. Musisz ich składni Markdown.

**Tabela się rozjeżdża**
Zawsze definiuj szerokość kolumn w procentach lub pikselach. Nie pozwalaj przeglądarce zgadywać.

**Emoji nie działają**
W Slacku: `:emoji_name:`
W innych: używaj prawdziwych emoji  (kopiuj-wklej)

---

## Podsumowanie

Formatowanie danych to nie tylko technikalia - to sposób na to, żeby Twoja automatyzacja była **przyjazna dla ludzi**.

Nikt nie chce czytać surowych danych z API. Ludzie chcą ładnych, czytelnych wiadomości.

n8n daje Ci narzędzia:
- **Set** do prostych zmian
- **IF** do rozdzielania
- **Merge/Split** do łączenia i dzielenia
- **Code** do zaawansowanych przekształceń (gdy je potrzebujesz)

Pamiętaj: email to HTML, komunikatory mają swoje zasady, a dane muszą być odpowiednio przygotowane. Testuj, sprawdzaj i poprawiaj.