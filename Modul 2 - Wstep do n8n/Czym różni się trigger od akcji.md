
![](/grafiki/m2_p1-trigger-vs-akcja-title.png)

W n8n (i innych narzędziach automatyzacji) przepływ pracy składa się z różnych bloków, które pełnią określone funkcje. Najważniejsze z nich to **trigger** i **akcja**.

---

### **Trigger – co to jest?**

Trigger to element, który uruchamia cały workflow. Jest punktem startowym automatyzacji – reaguje na określone zdarzenie lub warunek.

**Przykłady triggerów:**
- Otrzymanie nowego e-maila
- Dodanie nowego wiersza do arkusza Google Sheets
- Otrzymanie webhooka (np. z formularza na stronie)
- Określony czas (np. codziennie o 8:00)

W n8n trigger to pierwszy node w workflow, który „wybudza” automatyzację do działania.

---

### **Akcja – co to jest?**

Akcja to zadanie, które jest wykonywane po uruchomieniu workflow przez trigger. Może być ich wiele w jednym przepływie – każda akcja realizuje konkretną funkcję.

**Przykłady akcji:**
- Wysłanie powiadomienia na Slacku
- Dodanie rekordu do bazy danych
- Przetworzenie pliku i zapisanie go na Dysku Google
- Wysłanie e-maila z podsumowaniem

W n8n akcje to kolejne node'y, które wykonują zadania po wyzwoleniu przez trigger.

---

### **Przykład praktyczny**

Załóżmy, że chcesz:
- Po otrzymaniu nowego zgłoszenia z formularza (trigger: webhook)
- Dodać dane do arkusza Google Sheets (akcja)
- Wysłać powiadomienie do zespołu na Slacku (akcja)

Workflow w n8n:
1. **Trigger:** Webhook odbiera zgłoszenie
2. **Akcja:** Dodaj dane do Google Sheets
3. **Akcja:** Wyślij wiadomość na Slacku

---

**Podsumowanie:**
- **Trigger** uruchamia workflow, reaguje na zdarzenie
- **Akcja** wykonuje konkretne zadanie po wyzwoleniu przez trigger
- Dzięki temu możesz budować automatyzacje, które reagują na różne sytuacje i realizują dowolne działania!