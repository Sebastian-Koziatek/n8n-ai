![n8n – automatyzacja dla każdego](/grafiki/m1_p4-n8n-title.png)

n8n to nowoczesne, otwarte narzędzie do automatyzacji procesów i integracji aplikacji, które pozwala tworzyć zaawansowane przepływy pracy bez programowania.

---

### **Czym jest n8n?**

- To platforma typu no-code/low-code, która umożliwia łączenie różnych aplikacji, usług i systemów w automatyczne przepływy (workflows).
- Pozwala na integrację z ponad 300 aplikacjami (np. Gmail, Slack, Google Sheets, Discord, Twitter, API REST).
- Umożliwia budowanie logiki warunkowej, przetwarzanie danych, obsługę pętli i wiele więcej – wszystko w intuicyjnym, graficznym edytorze.
- Jest dostępna jako aplikacja webowa, którą możesz uruchomić lokalnie, na serwerze lub w chmurze.

---

### **Jak uruchomić n8n?**

1. **Lokalnie na komputerze**
   - Wymagania: Node.js (zalecana wersja 18+), npm lub yarn.
   - Instalacja:
     ```bash
     npm install n8n -g
     n8n start
     ```
   - Po uruchomieniu edytor dostępny jest pod adresem http://localhost:5678

2. **W kontenerze Docker**
   - Najprostszy sposób na uruchomienie n8n na serwerze lub VPS:
     ```bash
     docker run -it --rm -p 5678:5678 n8nio/n8n
     ```
   - Możesz też skorzystać z gotowych plików docker-compose.

3. **W chmurze (n8n.cloud)**
   - Dostępna jest wersja SaaS – nie wymaga instalacji, wystarczy założyć konto na stronie https://n8n.io

---

### **Licencja n8n**

- n8n jest dostępne na licencji [Fair Code](https://faircode.io/), która pozwala na darmowe użycie do celów niekomercyjnych i testowych.
- Wersja open-source jest dostępna na GitHubie: https://github.com/n8n-io/n8n
- W przypadku wdrożeń komercyjnych (np. w firmie, dla klientów) wymagane jest wykupienie licencji lub korzystanie z n8n.cloud.

---

### **Dlaczego warto wybrać n8n?**

- Bardzo duża elastyczność i możliwość rozbudowy przepływów.
- Otwartość – możesz samodzielnie hostować i modyfikować narzędzie.
- Integracje z popularnymi aplikacjami i API.
- Aktywna społeczność i bogata dokumentacja.
- Możliwość automatyzacji zadań, które w innych narzędziach są płatne lub ograniczone.

---

### **Przykładowe zastosowania n8n**

- Automatyczne pobieranie danych z różnych źródeł i generowanie raportów.
- Wysyłanie powiadomień do zespołu na Slacku po pojawieniu się nowego zgłoszenia.
- Integracja systemów CRM, e-mail, social media i narzędzi marketingowych.
- Przetwarzanie plików, synchronizacja danych, obsługa webhooków.

---

### **Automatyzacja w praktyce – jak działa n8n?**

n8n pozwala tworzyć automatyczne przepływy pracy (workflows), które łączą różne aplikacje i usługi bez potrzeby programowania. Każdy workflow składa się z tzw. "node'ów" – bloków, które wykonują konkretne zadania (np. pobierają dane, wysyłają e-mail, przetwarzają pliki, komunikują się z API).

**Jak wygląda proces automatyzacji w n8n?**

1. **Wybierasz trigger** – czyli zdarzenie, które uruchamia workflow (np. nowy e-mail, webhook, określony czas).
2. **Dodajesz kolejne kroki** – np. pobranie danych z Google Sheets, przetworzenie ich, wysłanie powiadomienia na Slacku.
3. **Łączysz node'y w graficznym edytorze** – wszystko odbywa się metodą "przeciągnij i upuść".
4. **Testujesz i uruchamiasz automatyzację** – możesz obserwować przebieg procesu i analizować wyniki.

---

### **Przykład workflow w n8n**

Załóżmy, że chcesz:
- Automatycznie pobierać nowe zgłoszenia z formularza Google Forms,
- Zapisywać je w arkuszu Google Sheets,
- Wysyłać powiadomienie do zespołu na Slacku.

W n8n:
- Ustawiasz trigger: nowy wpis w Google Forms (np. przez webhook lub integrację z Google Sheets).
- Dodajesz node: zapis danych do Google Sheets.
- Dodajesz node: wysłanie wiadomości na Slacku.
- Łączysz wszystko w jeden workflow i uruchamiasz.

---

### **n8n a inne narzędzia**

- n8n daje większą elastyczność niż typowe platformy no-code, bo pozwala na rozbudowaną logikę, pętle, warunki, obsługę API i własne skrypty.
- Możesz hostować n8n samodzielnie, co daje pełną kontrolę nad danymi i kosztami.
- Wersja open-source jest darmowa do użytku niekomercyjnego, a licencja Fair Code pozwala na testy i naukę bez opłat.

---

**Podsumowanie:**
n8n to narzędzie, które pozwala każdemu – bez programowania – zautomatyzować pracę, połączyć różne systemy i tworzyć własne rozwiązania integracyjne. Dzięki otwartości, elastyczności i bogatej dokumentacji, n8n jest świetnym wyborem zarówno dla początkujących, jak i zaawansowanych użytkowników.
