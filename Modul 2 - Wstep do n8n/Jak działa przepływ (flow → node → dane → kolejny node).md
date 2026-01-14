
<div align="center">
<img src="/grafiki/m2_p3-flow-title.png" alt="Flow w n8n" width="75%">
</div>

W n8n każdy workflow to sekwencja połączonych ze sobą node'ów, przez które przepływają dane. Zrozumienie tego mechanizmu jest kluczowe dla tworzenia efektywnych automatyzacji.

---

### **Podstawowa logika przepływu**

Workflow w n8n działa w sposób sekwencyjny:

1. **Trigger uruchamia workflow** – pierwszym elementem jest zawsze trigger (np. webhook, harmonogram, nowy e-mail)
2. **Dane trafiają do pierwszego node'a** – trigger przekazuje dane wejściowe (input) do następnego node'a
3. **Node przetwarza dane** – każdy node wykonuje swoją funkcję: pobiera, modyfikuje, filtruje lub wysyła dane
4. **Dane płyną do kolejnego node'a** – wyjście (output) jednego node'a staje się wejściem (input) następnego
5. **Workflow kończy się** – gdy wszystkie node'y wykonają swoje zadania lub gdy nie ma już kolejnych kroków

---

### **Jak wyglądają dane między node'ami?**

Dane w n8n przechodzą w formacie **JSON**. Każdy node może:
- Odczytać dane z poprzedniego kroku
- Przetworzyć je (np. wyfiltrować, połączyć, przekształcić)
- Przekazać je dalej do kolejnego node'a

**Przykład:**
```json
{
  "name": "Jan Kowalski",
  "email": "jan@example.com",
  "status": "aktywny"
}
```

Taki obiekt może być przekazywany między node'ami i każdy z nich może operować na tych danych.

---

### **Praktyczny przykład przepływu**

Załóżmy workflow, który:
1. Odbiera zgłoszenie z formularza (webhook)
2. Zapisuje dane do Google Sheets
3. Wysyła powiadomienie na Slacku

**Przepływ danych:**

**Node 1: Webhook (trigger)**
- Odbiera dane z formularza
- Output: `{ "name": "Anna", "message": "Problem z logowaniem" }`

**Node 2: Google Sheets**
- Input: dane z webhooka
- Akcja: dodaje wiersz do arkusza
- Output: potwierdzenie zapisu

**Node 3: Slack**
- Input: dane z webhooka i potwierdzenie z Google Sheets
- Akcja: wysyła wiadomość "Nowe zgłoszenie od Anna: Problem z logowaniem"
- Output: potwierdzenie wysłania

---

### **Kluczowe zasady przepływu danych**

- **Każdy node widzi dane z poprzedniego kroku** – możesz odwołać się do nich za pomocą wyrażeń `{{ $json.nazwa_pola }}`
- **Dane mogą się rozgałęziać** – jeden node może przekazać dane do wielu następnych node'ów (np. różne ścieżki w zależności od warunku)
- **Można filtrować i transformować dane** – node'y typu "Set", "Function", "Filter" pozwalają modyfikować strukturę i zawartość danych
- **Testowanie jest kluczowe** – n8n pozwala uruchomić workflow krok po kroku i zobaczyć, jakie dane przepływają przez każdy node

---

### **Rozgałęzienia i warunki**

Przepływ nie musi być liniowy. Możesz użyć node'a **IF** do rozgałęzienia:

```
Webhook  IF (sprawdź status)
           ├─ Jeśli "pilne"  Slack + Email
           └─ Jeśli "normalne"  Google Sheets
```

---

**Podsumowanie:**
Przepływ w n8n to sekwencja połączonych node'ów, przez które dane przechodzą od triggera aż do końcowego działania. Każdy node przetwarza dane i przekazuje je dalej, co pozwala na budowanie zarówno prostych, jak i bardzo złożonych automatyzacji.