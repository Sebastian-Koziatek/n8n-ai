
![Popularne nody](../grafiki/m2_p5-popularne-nody-title.png)


![Popularne node'y w n8n](../grafiki/m2_p6-popularne-nody-title.png)

W n8n znajdziesz setki node'ów do integracji z różnymi usługami. Poniżej przedstawiam top 10 najpopularniejszych node'ów, ze szczególnym uwzględnieniem ekosystemu Google.

---

### **1. Google Sheets**
- Odczyt danych (Get Rows)
- Dodawanie nowych wierszy (Append Row)
- Aktualizacja i usuwanie danych
- Przykład: automatyczne zapisywanie zgłoszeń z formularza do arkusza

### **2. Google Drive**
- Pobieranie plików
- Przesyłanie nowych dokumentów
- Tworzenie folderów
- Przykład: automatyczne archiwizowanie załączników z maila

### **3. Google Calendar**
- Tworzenie wydarzeń
- Odczyt i aktualizacja spotkań
- Przykład: automatyczne dodawanie spotkań na podstawie zgłoszeń

### **4. Google Gmail**
- Wysyłanie e-maili
- Odczyt wiadomości
- Przesyłanie załączników
- Przykład: automatyczne powiadomienia o nowych zgłoszeniach

### **5. Google Contacts**
- Dodawanie i aktualizacja kontaktów
- Odczyt listy kontaktów
- Przykład: synchronizacja kontaktów z CRM

### **6. Google Cloud Storage**
- Przesyłanie i pobieranie plików
- Zarządzanie bucketami
- Przykład: backup plików z workflow

### **7. Google Tasks**
- Tworzenie i aktualizacja zadań
- Odczyt listy zadań
- Przykład: automatyczne generowanie zadań na podstawie zgłoszeń

### **8. Google Analytics**
- Pobieranie statystyk
- Analiza ruchu na stronie
- Przykład: raportowanie wyników kampanii marketingowych


### **9. HTTP Request**
- Najbardziej uniwersalny node w n8n – pozwala na komunikację z dowolnym API (GET, POST, PUT, DELETE)
- Umożliwia pobieranie, wysyłanie, aktualizowanie i usuwanie danych w zewnętrznych serwisach
- Przykład: pobieranie danych o pogodzie, wysyłanie zgłoszeń do CRM, integracja z niestandardowymi usługami

### **10. Slack**
- Wysyłanie wiadomości na kanały i do użytkowników
- Powiadomienia o nowych zgłoszeniach, raportach, błędach
- Przykład: automatyczne informowanie zespołu o nowych zadaniach, przesyłanie raportów, alerty systemowe

---

### **Przykładowy workflow z node'ami Google**

1. **Trigger:** Webhook odbiera zgłoszenie z formularza
2. **Google Sheets:** Zapisuje dane zgłoszenia
3. **Google Drive:** Archiwizuje załącznik
4. **Google Calendar:** Dodaje spotkanie
5. **Google Gmail:** Wysyła potwierdzenie do klienta

---

**Podsumowanie:**
Node'y Google w n8n pozwalają na pełną automatyzację pracy z dokumentami, pocztą, kalendarzem, plikami i danymi. Dzięki nim możesz zbudować workflow, który zintegruje wszystkie kluczowe usługi Google w jednym miejscu – bez programowania.