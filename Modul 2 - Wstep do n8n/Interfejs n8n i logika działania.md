
<div align="center">
<img src="/grafiki/m2_p2-interfejs-title.png" alt="Interfejs n8n" width="75%">
</div>

# Interfejs n8n i logika działania


n8n oferuje intuicyjny, graficzny interfejs, który pozwala na łatwe projektowanie automatyzacji bez programowania. Wszystko odbywa się metodą „przeciągnij i upuść”, a każdy element workflow jest widoczny na diagramie.

---

### **Główne elementy interfejsu n8n**

- **Canvas (płótno)** – główna przestrzeń robocza, na której budujesz workflow, dodajesz i łączysz node'y.
- **Node'y (bloki)** – każdy node to pojedyncza akcja, trigger lub operacja na danych. Node'y mają różne typy: integracje z aplikacjami, logika, przetwarzanie danych.
- **Panel właściwości** – po kliknięciu node'a możesz skonfigurować jego ustawienia (np. dane wejściowe, parametry, autoryzację).
- **Menu boczne** – dostęp do listy node'ów, ustawień workflow, historii uruchomień, dokumentacji.
- **Przyciski uruchamiania/testowania** – pozwalają uruchomić workflow, przetestować go na żywo i zobaczyć wyniki.

---

### **Logika działania workflow w n8n**

1. **Trigger** – workflow zaczyna się od triggera, który reaguje na zdarzenie (np. nowy e-mail, webhook, określony czas).
2. **Przepływ danych** – dane przechodzą przez kolejne node'y, gdzie są przetwarzane, filtrowane, modyfikowane.
3. **Akcje** – workflow wykonuje zadania, np. wysyła powiadomienia, zapisuje dane, komunikuje się z API.
4. **Warunki i pętle** – możesz dodawać logikę warunkową (if/else), pętle, rozgałęzienia, aby workflow był bardziej zaawansowany.
5. **Wynik** – na końcu workflow możesz zobaczyć rezultat działania, np. raport, wiadomość, zapisane dane.

---

### **Przykład prostego workflow w n8n**

- **Trigger:** Otrzymanie nowego zgłoszenia przez webhook
- **Node:** Przetwarzanie danych (np. sprawdzenie poprawności)
- **Node:** Dodanie danych do Google Sheets
- **Node:** Wysłanie powiadomienia na Slacku

Każdy krok jest widoczny na diagramie, możesz go testować, modyfikować i rozbudowywać według potrzeb.

---

**Podsumowanie:**
Interfejs n8n jest przejrzysty i elastyczny, a logika działania workflow pozwala na budowanie zarówno prostych, jak i bardzo zaawansowanych automatyzacji – wszystko bez programowania!