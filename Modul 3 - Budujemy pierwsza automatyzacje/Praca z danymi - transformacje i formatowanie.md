# Praca z danymi - transformacje i formatowanie

W n8n dane przepływają między node'ami i często wymagają przekształcenia, filtrowania lub formatowania. W tej lekcji nauczysz się, jak manipulować danymi, aby dostosować je do wymagań następnych kroków w workflow.

---

## Struktura danych w n8n

Dane w n8n przepływają jako **obiekty JSON**. Każdy node otrzymuje dane z poprzedniego node'a i przekazuje je dalej.

### Podstawowa struktura

Każdy item (element danych) w n8n ma strukturę:

```json
{
  "json": {
    "name": "Jan Kowalski",
    "email": "jan@example.com",
    "age": 30
  },
  "binary": {}
}
```

- **json** - główne dane w formacie JSON
- **binary** - dane binarne (pliki, obrazy)

### Dostęp do danych

W expressions używasz:
- `{{ $json.name }}` - wartość pola "name"
- `{{ $json.email }}` - wartość pola "email"
- `{{ $json.address.city }}` - zagnieżdżone pola

---

## Node Set - transformacja danych

**Set node** to podstawowe narzędzie do przekształcania danych. Pozwala:
- Zmienić nazwy pól
- Dodać nowe pola
- Usunąć niepotrzebne pola
- Przekształcić wartości
- Połączyć dane z różnych źródeł

### Praktyka: Set node

**Scenariusz:** Masz dane użytkownika i chcesz przygotować je do wysłania emailem.

**Dane wejściowe:**
```json
{
  "firstName": "Jan",
  "lastName": "Kowalski",
  "emailAddress": "jan@example.com",
  "createdAt": "2026-01-14T10:30:00Z"
}
```

**Konfiguracja Set node:**

1. **Keep Only Set Fields** - zachowaj tylko wybrane pola
2. Dodaj pola:

**Pole 1:**
- Name: `fullName`
- Value: `{{ $json.firstName }} {{ $json.lastName }}`

**Pole 2:**
- Name: `email`
- Value: `{{ $json.emailAddress }}`

**Pole 3:**
- Name: `registrationDate`
- Value: `{{ $json.createdAt.split('T')[0] }}`

**Wynik:**
```json
{
  "fullName": "Jan Kowalski",
  "email": "jan@example.com",
  "registrationDate": "2026-01-14"
}

```

### Operacje na danych w Set

**Łączenie tekstu:**
```javascript
{{ $json.firstName + " " + $json.lastName }}
```

**Formatowanie liczb:**
```javascript
{{ $json.price.toFixed(2) }} PLN
```

**Data i czas:**
```javascript
{{ $now.format('DD.MM.YYYY') }}
{{ $json.createdAt.toDateTime().toFormat('yyyy-MM-dd HH:mm') }}
```

**Warunki (ternary operator):**
```javascript
{{ $json.age >= 18 ? "Pełnoletni" : "Niepełnoletni" }}
```

---

## Node Code - zaawansowane transformacje

Gdy Set node nie wystarcza, użyj **Code node** do pisania JavaScript.

### Przykład 1: Formatowanie danych

```javascript
// Pobierz dane z poprzedniego node'a
const items = $input.all();

// Przekształć dane
const transformed = items.map(item => {
  return {
    json: {
      fullName: `${item.json.firstName} ${item.json.lastName}`.toUpperCase(),
      email: item.json.email.toLowerCase(),
      age: item.json.age,
      status: item.json.age >= 18 ? 'adult' : 'minor',
      registeredOn: new Date(item.json.createdAt).toLocaleDateString('pl-PL')
    }
  };
});

return transformed;
```

### Przykład 2: Filtrowanie danych

```javascript
const items = $input.all();

// Filtruj tylko użytkowników powyżej 18 lat
const adults = items.filter(item => item.json.age >= 18);

return adults;
```

### Przykład 3: Grupowanie danych

```javascript
const items = $input.all();

// Grupuj użytkowników po mieście
const grouped = items.reduce((acc, item) => {
  const city = item.json.city;
  if (!acc[city]) {
    acc[city] = [];
  }
  acc[city].push(item.json);
  return acc;
}, {});

// Zwróć jako array
return [{
  json: grouped
}];
```

---

## Node IF - logika warunkowa

**IF node** pozwala na rozdzielenie przepływu danych na podstawie warunków.

### Przykład: Filtrowanie według wieku

**Konfiguracja:**
- **Conditions:** `{{ $json.age }}` >= 18

**Wynik:**
- **True** - osoby pełnoletnie idą jedną ścieżką
- **False** - niepełnoletnie drugą

### Zaawansowane warunki

**Sprawdzenie czy email zawiera domenę:**
```javascript
{{ $json.email.includes("@gmail.com") }}
```

**Sprawdzenie czy wartość jest pusta:**
```javascript
{{ $json.phone !== "" && $json.phone !== null }}
```

**Multiple conditions:**
```javascript
{{ $json.age >= 18 && $json.country === "Poland" }}
```

---

## Formatowanie danych do wysyłki

### Email - HTML format

Większość nowoczesnych klientów email obsługuje HTML. To pozwala na:
- Formatowanie tekstu (pogrubienie, kolory, czcionki)
- Dodawanie linków i przycisków
- Strukturyzowanie treści (tabele, listy)
- Obrazki i banery
- Responsywność (dopasowanie do mobile)

### Prosty email HTML w n8n

**Node: Send Email (lub Gmail/Outlook)**

**Subject:**
```
Witaj {{ $json.firstName }}!
```

**Message (HTML):**
```html
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <style>
    body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; }
    .container { max-width: 600px; margin: 0 auto; padding: 20px; }
    .header { background: #4CAF50; color: white; padding: 20px; text-align: center; }
    .content { padding: 20px; background: #f9f9f9; }
    .button { background: #4CAF50; color: white; padding: 12px 24px; text-decoration: none; border-radius: 5px; display: inline-block; margin: 10px 0; }
    .footer { text-align: center; padding: 20px; font-size: 12px; color: #666; }
  </style>
</head>
<body>
  <div class="container">
    <div class="header">
      <h1>Witamy w naszym serwisie!</h1>
    </div>
    
    <div class="content">
      <h2>Cześć {{ $json.firstName }}!</h2>
      <p>Dziękujemy za rejestrację. Twoje konto zostało utworzone pomyślnie.</p>
      
      <p><strong>Twoje dane:</strong></p>
      <ul>
        <li>Email: {{ $json.email }}</li>
        <li>Data rejestracji: {{ $json.registrationDate }}</li>
      </ul>
      
      <p>Kliknij poniższy przycisk, aby aktywować konto:</p>
      <a href="https://example.com/activate?token={{ $json.token }}" class="button">
        Aktywuj konto
      </a>
      
      <p>Jeśli przycisk nie działa, skopiuj poniższy link:</p>
      <p>https://example.com/activate?token={{ $json.token }}</p>
    </div>
    
    <div class="footer">
      <p>© 2026 Twoja Firma. Wszelkie prawa zastrzeżone.</p>
      <p>Nie odpowiadaj na tego maila.</p>
    </div>
  </div>
</body>
</html>
```

### Zachowanie formatowania

**Ważne zasady:**
- Używaj inline CSS (style w tagu) dla lepszej kompatybilności
- Testuj na różnych klientach email (Gmail, Outlook, Apple Mail)
- Zachowaj max szerokość 600px (standard dla mobile)
- Dodaj alt text dla obrazków
- Zawsze dodaj wersję plain text jako fallback

### Email plain text (fallback)

Niektórzy użytkownicy blokują HTML. Zawsze dodaj wersję tekstową:

```
Witaj {{ $json.firstName }}!

Dziękujemy za rejestrację. Twoje konto zostało utworzone pomyślnie.

Twoje dane:
- Email: {{ $json.email }}
- Data rejestracji: {{ $json.registrationDate }}

Aby aktywować konto, odwiedź:
https://example.com/activate?token={{ $json.token }}

---
© 2026 Twoja Firma
```

---

## Formatowanie dla komunikatorów

### Slack - Markdown

Slack używa własnej składni Markdown:

```
*Nowy użytkownik zarejestrowany!*

👤 *Imię:* {{ $json.firstName }} {{ $json.lastName }}
📧 *Email:* {{ $json.email }}
📅 *Data:* {{ $json.registrationDate }}

<https://admin.example.com/users/{{ $json.userId }}|Zobacz profil>
```

**Formatowanie:**
- `*pogrubienie*` - pogrubiony tekst
- `_kursywa_` - kursywa
- `~przekreślenie~` - przekreślenie
- `` `kod` `` - inline code
- `\n` - nowa linia
- `>` - cytat (quote block)
- Emoji: `:smile:`, `:fire:`, `:check:`

### Discord - Markdown

```
**Nowa rejestracja!**

**Użytkownik:** {{ $json.firstName }} {{ $json.lastName }}
**Email:** {{ $json.email }}
**Data:** {{ $json.registrationDate }}

[Zobacz profil](https://admin.example.com/users/{{ $json.userId }})
```

### Telegram - HTML

Telegram obsługuje HTML:

```html
<b>Nowa rejestracja!</b>

<b>Użytkownik:</b> {{ $json.firstName }} {{ $json.lastName }}
<b>Email:</b> {{ $json.email }}
<b>Data:</b> {{ $json.registrationDate }}

<a href="https://admin.example.com/users/{{ $json.userId }}">Zobacz profil</a>
```

---

## Tabele w email HTML

Wysyłanie danych tabelarycznych:

```html
<table style="width: 100%; border-collapse: collapse;">
  <thead>
    <tr style="background: #4CAF50; color: white;">
      <th style="padding: 10px; text-align: left;">Produkt</th>
      <th style="padding: 10px; text-align: right;">Cena</th>
      <th style="padding: 10px; text-align: right;">Ilość</th>
    </tr>
  </thead>
  <tbody>
    <tr style="border-bottom: 1px solid #ddd;">
      <td style="padding: 10px;">{{ $json.productName }}</td>
      <td style="padding: 10px; text-align: right;">{{ $json.price }} PLN</td>
      <td style="padding: 10px; text-align: right;">{{ $json.quantity }}</td>
    </tr>
  </tbody>
</table>
```

### Pętla przez wiele produktów w Code node

```javascript
const items = $input.all();

let rows = items.map(item => `
  <tr style="border-bottom: 1px solid #ddd;">
    <td style="padding: 10px;">${item.json.productName}</td>
    <td style="padding: 10px; text-align: right;">${item.json.price} PLN</td>
    <td style="padding: 10px; text-align: right;">${item.json.quantity}</td>
  </tr>
`).join('');

const html = `
<table style="width: 100%; border-collapse: collapse;">
  <thead>
    <tr style="background: #4CAF50; color: white;">
      <th style="padding: 10px; text-align: left;">Produkt</th>
      <th style="padding: 10px; text-align: right;">Cena</th>
      <th style="padding: 10px; text-align: right;">Ilość</th>
    </tr>
  </thead>
  <tbody>
    ${rows}
  </tbody>
</table>
`;

return [{ json: { html: html } }];
```

---

## Merge i Split - łączenie danych

### Node Merge

Łączy dane z dwóch źródeł:

**Mode 1: Append** - dodaje dane jeden pod drugim
**Mode 2: Merge By Key** - łączy po kluczu (jak JOIN w SQL)

**Przykład Merge By Key:**
- Dane 1: Użytkownicy (id, name, email)
- Dane 2: Zamówienia (userId, product, price)
- Key: `id` = `userId`
- Wynik: Użytkownicy z ich zamówieniami

### Node Split

Dzieli jeden item na wiele:

**Split Out:** JSON Array
- Jeśli masz array w jednym item, split rozdzieli go na wiele items

**Przykład:**
```json
{
  "users": [
    { "name": "Jan", "email": "jan@example.com" },
    { "name": "Anna", "email": "anna@example.com" }
  ]
}
```

Po Split Out → `users` będzie 2 items (Jan, Anna)

---

## Node Filter - filtrowanie danych

Usuwa items, które nie spełniają warunku.

**Przykład 1: Tylko aktywni użytkownicy**
- Condition: `{{ $json.status }}` equals `active`

**Przykład 2: Tylko duże zamówienia**
- Condition: `{{ $json.orderValue }}` > 1000

**Przykład 3: Email z określonej domeny**
- Condition: `{{ $json.email.endsWith("@company.com") }}`

---

## Praktyczny workflow: Newsletter z formatowaniem

**Scenariusz:** Codziennie wysyłaj newsletter z nowymi artykułami

**Node 1: Schedule Trigger**
- Codziennie o 8:00

**Node 2: HTTP Request**
- Pobierz artykuły z API

**Node 3: Filter**
- Tylko artykuły z dzisiaj
- `{{ $json.publishedAt.split('T')[0] }}` equals `{{ $today.format('yyyy-MM-dd') }}`

**Node 4: Code - Generuj HTML**
```javascript
const articles = $input.all();

const articlesList = articles.map(item => `
  <div style="margin-bottom: 30px; padding: 20px; background: #f5f5f5; border-left: 4px solid #4CAF50;">
    <h3 style="margin: 0 0 10px 0;">
      <a href="${item.json.url}" style="color: #333; text-decoration: none;">
        ${item.json.title}
      </a>
    </h3>
    <p style="color: #666; margin: 0 0 10px 0;">
      ${item.json.description}
    </p>
    <a href="${item.json.url}" style="color: #4CAF50; text-decoration: none; font-weight: bold;">
      Czytaj więcej →
    </a>
  </div>
`).join('');

const html = `
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <style>
    body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; }
    .container { max-width: 600px; margin: 0 auto; padding: 20px; }
  </style>
</head>
<body>
  <div class="container">
    <h1 style="color: #4CAF50;">Dziś w naszym blogu</h1>
    <p>Witaj! Oto najnowsze artykuły z naszego bloga:</p>
    ${articlesList}
    <hr style="margin: 30px 0; border: none; border-top: 1px solid #ddd;">
    <p style="font-size: 12px; color: #666; text-align: center;">
      © 2026 Twoja Firma | <a href="https://example.com/unsubscribe">Wypisz się</a>
    </p>
  </div>
</body>
</html>
`;

return [{
  json: {
    html: html,
    articlesCount: articles.length
  }
}];
```

**Node 5: Gmail/Send Email**
- To: lista subskrybentów
- Subject: `Dziś w blogu: {{ $json.articlesCount }} nowych artykułów`
- Body: `{{ $json.html }}`
- Format: HTML

---

## Dobre praktyki formatowania

**Email HTML:**
- Używaj inline CSS
- Max szerokość 600px
- Testuj na różnych klientach
- Zawsze dodaj plain text fallback
- Dodaj link "Wypisz się"
- Responsive design (media queries)

**Komunikatory:**
- Używaj natywnego formatowania (Markdown dla Slacka)
- Dodaj emoji dla lepszej czytelności
- Krótkie, zwięzłe wiadomości
- Linki zawsze z opisem

**Ogólne:**
- Escapuj HTML jeśli dane pochodzą od użytkowników
- Validuj dane przed wysłaniem
- Loguj błędy formatowania
- Testuj na prawdziwych danych

---

## Debugowanie formatowania

**Problem: Email wygląda źle**
1. Sprawdź HTML w Code node (Output)
2. Testuj w różnych klientach email
3. Używaj inline CSS
4. Sprawdź encoding (UTF-8)

**Problem: Dane nie wyświetlają się**
1. Sprawdź czy expression jest poprawny
2. Console.log w Code node
3. Użyj node Edit Fields do podglądu

**Problem: Formatowanie znika**
1. Slack/Discord - używaj ich składni Markdown
2. Email - inline CSS zamiast external
3. Sprawdź czy dane nie są escapowane