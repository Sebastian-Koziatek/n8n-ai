# Analiza działania i struktury danych

![Analiza danych w n8n](../grafiki/m3_p3-analiza-danych-title.png)

Kluczem do efektywnego tworzenia automatyzacji w n8n jest zrozumienie, jak dane przepływają między node'ami i jak je analizować. n8n oferuje wbudowane narzędzia do debugowania i inspekcji danych.

---

### **Jak wyglądają dane w n8n?**

Dane w n8n przechodzą w formacie **JSON** (JavaScript Object Notation). Każdy node:
- Przyjmuje dane wejściowe (input)
- Przetwarza je
- Zwraca dane wyjściowe (output)

**Przykład struktury danych:**
```json
{
  "name": "Anna Kowalska",
  "email": "anna@example.com",
  "age": 28,
  "active": true,
  "tags": ["vip", "newsletter"]
}
```

---

### **Inspekcja danych w node'dzie**

Po uruchomieniu workflow możesz zobaczyć dane w każdym node'dzie:

1. Kliknij na node, który chcesz zbadać
2. W prawym panelu zobaczysz:
   - **Input**: dane wejściowe z poprzedniego node'a
   - **Output**: dane wyjściowe, które node przekazuje dalej
3. Możesz rozwinąć obiekty JSON i zobaczyć szczegółową strukturę

---

### **Dostęp do danych w wyrażeniach**

W n8n możesz odwoływać się do danych za pomocą wyrażeń:

**Składnia:**
- `{{ $json.pole }}` – odwołanie do pola z obecnego node'a
- `{{ $node["Nazwa Node"].json.pole }}` – odwołanie do danych z konkretnego node'a
- `{{ $item(0).$json.pole }}` – odwołanie do pierwszego elementu (jeśli dane są w tablicy)

**Przykłady:**
```javascript
// Pobierz imię
{{ $json.name }}

// Pobierz pierwszy tag
{{ $json.tags[0] }}

// Połącz dane
{{ $json.name }} - {{ $json.email }}

// Odwołanie do innego node'a
{{ $node["HTTP Request"].json.temperature }}
```

---

### **Node'y do przetwarzania danych**

**1. Set (ustawianie wartości)**
- Tworzenie nowych pól
- Modyfikacja istniejących danych
- Usuwanie niepotrzebnych pól

**2. Filter (filtrowanie)**
- Przepuszczenie tylko tych danych, które spełniają warunek
- Przykład: tylko użytkownicy starsi niż 18 lat

**3. Split In Batches (dzielenie na partie)**
- Podział dużych zbiorów danych na mniejsze grupy
- Przydatne przy limitach API

**4. Merge (łączenie danych)**
- Połączenie danych z różnych źródeł
- Np. dane użytkownika + dane zamówień

**5. Function (kod JavaScript)**
- Zaawansowane przetwarzanie przez własny kod
- Przykład: złożone obliczenia, formatowanie

---

### **Przykład praktyczny: analiza odpowiedzi API**

Załóżmy, że pobierasz dane użytkowników z API:

**Odpowiedź API:**
```json
{
  "users": [
    {"id": 1, "name": "Jan", "status": "active"},
    {"id": 2, "name": "Anna", "status": "inactive"},
    {"id": 3, "name": "Piotr", "status": "active"}
  ]
}
```

**Zadanie:** Wyciągnij tylko aktywnych użytkowników

**Workflow:**

1. **HTTP Request** – pobierz dane
2. **Function** – wyciągnij tablicę users:
```javascript
return items[0].json.users.map(user => ({json: user}));
```
3. **Filter** – filtruj po status:
   - Warunek: `{{ $json.status }}` equals `active`
4. **Set** – przygotuj finalną listę

---

### **Debugowanie workflow**

**Uruchamianie krok po kroku:**
- Kliknij na konkretny node i użyj "Execute Node"
- Zobacz output i sprawdź, czy dane są poprawne

**Logowanie danych:**
- Dodaj node **Function** z kodem:
```javascript
console.log($json);
return items;
```
- Logi zobaczysz w konsoli serwera n8n

**Użyj node'a "No Operation (do nothing)":**
- Dodaj go na końcu, aby zobaczyć finalne dane bez wykonywania akcji

---

### **Najczęstsze problemy**

**Problem 1: "Cannot read property of undefined"**
- Sprawdź, czy pole faktycznie istnieje w danych
- Użyj operatora `?.` dla bezpiecznego dostępu: `{{ $json.user?.name }}`

**Problem 2: Tablica zamiast obiektu**
- Jeśli dane są w tablicy, użyj `$json[0].pole`

**Problem 3: Brak danych w node'dzie**
- Upewnij się, że poprzedni node zwrócił dane
- Sprawdź, czy workflow został uruchomiony w całości

---

**Podsumowanie:**
Analiza danych to fundament pracy z n8n. Dzięki inspekcji output'ów, wyrażeniom i node'om do przetwarzania możesz precyzyjnie kontrolować przepływ i transformację danych w swoich automatyzacjach.