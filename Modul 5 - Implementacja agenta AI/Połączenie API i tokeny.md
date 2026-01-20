
![ChatGPT w przeglądarce vs ChatGPT API](/grafiki/blok1-p6-api-vs-przegladarka-title.png)

<div align="center">

### **ChatGPT w przeglądarce vs ChatGPT API – kluczowe różnice**

</div>

| **Aspekt**          | **ChatGPT w przeglądarce**                               | **ChatGPT API**                                 |
| ------------------- | -------------------------------------------------------- | ----------------------------------------------- |
| **Dostęp**          | Przez chat.openai.com                                    | Przez kod (n8n, Python, Node.js)                |
| **Model kontroli**  | Ograniczony (temperatura, długość)                       | Pełna kontrola parametrów                       |
| **Koszt**           | Abonament: ~$20/miesiąc (Plus) lub darmowy               | Pay-per-use: płacisz za tokeny                  |
| **Limity tokenów**  | Ukryte, zależne od wersji                                | Jawne, konfigurowane (4k, 8k, 128k)             |
| **Funkcje**         | UI, historia konwersacji, DALL-E, przeglądanie internetu | Surowe API, brak UI                             |
| **Integracja**      | Brak                                                     | Pełna integracja z aplikacjami                  |
| **Historia**        | Automatycznie zapisywana                                 | Musisz zarządzać samodzielnie                   |
| **Dane treningowe** | Mogą być używane (można wyłączyć)                        | Nie są używane do treningu                      |
| **Prywatność**      | Standardowa                                              | Większa (dane nie są przechowywane)             |
| **Rate limiting**   | Niewidoczne dla użytkownika                              | Limity żądań/minutę (RPM) i tokeny/minutę (TPM) |

---


<div align="center">

### **Limity tokenów w popularnych modelach**

</div>

**OpenAI GPT:**

| Model | Limit tokenów | Przybliżony ekwiwalent |
|-------|---------------|------------------------|
| GPT-3.5-turbo | 4,096 | ~3,000 słów / 6 stron A4 |
| GPT-3.5-turbo-16k | 16,384 | ~12,000 słów / 24 strony A4 |
| GPT-4 | 8,192 | ~6,000 słów / 12 stron A4 |
| GPT-4-32k | 32,768 | ~24,000 słów / 48 stron A4 |
| GPT-4-turbo | 128,000 | ~96,000 słów / 192 strony A4 |
| GPT-4o | 128,000 | ~96,000 słów / 192 strony A4 |
| **GPT-5** | **128,000** | **~96,000 słów / 192 strony A4** |
| **GPT-5 mini** | **128,000** | **~96,000 słów / 192 strony A4** |
| **GPT-5 nano** | **128,000** | **~96,000 słów / 192 strony A4** |

**Inne modele:**

- **Claude 3 (Anthropic):** do 200,000 tokenów (~150,000 słów)
- **Gemini 1.5 Pro (Google):** do 2,000,000 tokenów (~1,500,000 słów)
- **Llama 3 (Meta):** 8,192 tokenów (~6,000 słów)

**Uwaga:** Limit obejmuje **prompt + odpowiedź**!

**Przykład:**
- Prompt: 1000 tokenów
- Odpowiedź: 500 tokenów
- **Razem: 1500 tokenów zużytych z limitu 4096**

---


<div align="center">

### **Jak działa rozliczanie w API?**

</div>

**Model cenowy: Pay-per-token**

Płacisz za każdy token, który przetworzysz – zarówno w prompcie (input) jak i odpowiedzi (output).

**Ceny OpenAI API (przykładowe, aktualne na listopad 2024):**

| Model | Input (za 1M tokenów) | Output (za 1M tokenów) |
|-------|----------------------|------------------------|
| GPT-3.5-turbo | $0.50 | $1.50 |
| GPT-4 | $30.00 | $60.00 |
| GPT-4-turbo | $10.00 | $30.00 |
| GPT-4o | $5.00 | $15.00 |

**Przykład kalkulacji kosztu:**

Zapytanie:
- Prompt: 500 tokenów (input)
- Odpowiedź: 300 tokenów (output)

**GPT-3.5-turbo:**
- Input: 500 × $0.50 / 1,000,000 = $0.00025
- Output: 300 × $1.50 / 1,000,000 = $0.00045
- **Razem: $0.0007 (około 0.07 centa)**

**GPT-4:**
- Input: 500 × $30 / 1,000,000 = $0.015
- Output: 300 × $60 / 1,000,000 = $0.018
- **Razem: $0.033 (około 3.3 centa)**

**Dla 1000 zapytań:**
- GPT-3.5: ~$0.70
- GPT-4: ~$33

**Wniosek:** GPT-4 jest **~47× droższy** niż GPT-3.5!

---


<div align="center">

### **GPT-5 – najbardziej zaawansowany model OpenAI**

</div>

**GPT-5** to najinteligentniejszy model OpenAI, specjalnie wytrenowany do:

 **Generowania kodu, debugowania i refaktoryzacji**  
 **Ścisłego podążania za instrukcjami**  
 **Długiego kontekstu i wywoływania narzędzi (tool calling)**  
 **Zadań agentowych (agentic tasks)**

**Tokeny w GPT-5:**
- **Limit kontekstu: 128,000 tokenów** (identycznie jak GPT-4o/GPT-4-turbo)
- Dotyczy wszystkich wariantów: `gpt-5`, `gpt-5-mini`, `gpt-5-nano`
- Model używa **reasoning tokens** – wewnętrzny "łańcuch myśli" przed odpowiedzią
- Możliwość przekazywania Chain of Thought (CoT) między turami konwersacji

**Warianty modeli GPT-5:**

| Model | Najlepsze dla | Reasoning effort |
|-------|---------------|------------------|
| `gpt-5` | Złożone rozumowanie, szeroką wiedzę, kod, zadania agentowe | `minimal`, `low`, `medium`, `high` |
| `gpt-5-mini` | Równowaga między kosztem, szybkością i możliwościami | `minimal`, `low`, `medium` |
| `gpt-5-nano` | Zadania o wysokiej przepustowości, proste instrukcje, klasyfikacja | `minimal`, `low` |

---


<div align="center">

### **Podsumowanie**

</div>

| **Aspekt** | **ChatGPT w przeglądarce** | **API** |
|------------|----------------------------|---------|
| **Najlepsze dla** | Użytkowników końcowych, eksploracji | Deweloperów, automatyzacji |
| **Koszt** | $0 lub $20/miesiąc (flat rate) | Pay-per-token (zmienne) |
| **Kontrola** | Ograniczona | Pełna |
| **Zarządzanie tokenami** | Automatyczne | Manualne |
| **Integracja** | Brak | Pełna |

**Kluczowe wnioski:**

1. **Tokeny = pieniądze** – każdy token w API kosztuje
2. **Wybieraj model świadomie** – GPT-4 jest 47× droższy niż GPT-3.5
3. **Optymalizuj prompty** – krótsze = tańsze
4. **Monitoruj zużycie** – unikaj niespodzianek na fakturze
5. **ChatGPT Plus opłacalny dla power users** – 9600+ wiadomości/m za $20
6. **API lepsze dla aplikacji** – pełna kontrola i integracja

**Decyzja:** Przeglądarka dla ludzi, API dla robotów!

---

## Optymalizacja promptu pod kątem kosztów API

Każde wywołanie agenta AI generuje koszty – zwykle płacimy za liczbę **tokenów** (jednostek tekstu) przetwarzanych przez model. Im dłuższy prompt i odpowiedź, tym wyższy koszt.

### Jak zmniejszyć koszty obsługi agenta?

#### 1. **Zwięzłość promptu**

**Źle:**
```
Jesteś asystentem obsługi klienta w firmie zajmującej się sprzedażą elektroniki. Odpowiadasz na pytania klientów dotyczące produktów, zamówień, dostaw, zwrotów, reklamacji i wszelkich innych zagadnień związanych z obsługą klienta. Twoja rola polega na udzielaniu szczegółowych, pomocnych i przystępnych odpowiedzi, które rozwiązują problemy klientów. Zawsze bądź uprzejmy, empatyczny i profesjonalny. Jeśli klient jest niezadowolony, przeproś i zaproponuj rozwiązanie. Jeśli nie znasz odpowiedzi, przekieruj klienta do odpowiedniego działu.
```

**Dobrze:**
```
Jesteś asystentem obsługi klienta w sklepie elektroniki. Odpowiadasz na pytania o produkty, zamówienia, dostawy i zwroty. Ton: uprzejmy i pomocny. Jeśli nie znasz odpowiedzi, przekieruj do właściwego działu.
```

**Oszczędność:** ~70 tokenów na każde wywołanie

---

#### 2. **Ograniczenie długości odpowiedzi**

Dodaj w prompcie:
```
Odpowiadaj zwięźle – maksymalnie 3-4 zdania. Jeśli użytkownik potrzebuje więcej informacji, zapyta.
```

**Efekt:** Krótsze odpowiedzi = mniej tokenów = niższe koszty

---

#### 3. **Unikanie powtórzeń w prompcie**

Zamiast:
```
Jeśli klient pyta o zwrot, odpowiedz X.
Jeśli klient pyta o reklamację, odpowiedz Y.
Jeśli klient pyta o wymianę, odpowiedz Z.
```

Użyj:
```
Polityka zwrotów: [krótki opis]. Stosuj ją do pytań o zwrot, reklamację i wymianę.
```

---

#### 4. **Wykorzystanie cache'owania (w ChatGPT API)**

W przypadku powtarzających się fragmentów promptu (np. zasad firmy, listy produktów), wykorzystaj mechanizm **Prompt Caching**, który zmniejsza koszty o 50-90% dla powtarzalnych elementów.

**Więcej informacji:**
- [ChatGPT API – dokumentacja oficjalna](https://platform.openai.com/docs/guides/chat)
- [Pricing – koszty tokenów](https://openai.com/api/pricing/)

---

#### 5. **Wybór modelu**

Nie zawsze potrzebujesz najdroższego modelu. Dla prostych zadań (FAQ, powitania) możesz użyć tańszych modeli:

- **GPT-4** – droższy, ale najbardziej zaawansowany
- **GPT-4o mini** – tańszy, wystarczający dla większości zadań
- **GPT-3.5 Turbo** – najtańszy, dobry dla prostych odpowiedzi

**Strategia:** Używaj droższego modelu tylko tam, gdzie jest naprawdę potrzebny (np. złożone analizy, decyzje biznesowe).

---

#### 6. **Monitorowanie zużycia tokenów**

Regularnie sprawdzaj zużycie tokenów w panelu OpenAI:
- Śledź liczbę tokenów na zapytanie
- Identyfikuj prompty, które generują zbyt długie odpowiedzi
- Optymalizuj te, które generują największe koszty

**Narzędzie:** [OpenAI Usage Dashboard](https://platform.openai.com/usage)

---

### Przykładowe koszty (na podstawie cennika OpenAI)

**GPT-4o:**
- Input: $2.50 za 1M tokenów
- Output: $10.00 za 1M tokenów

**GPT-4o mini:**
- Input: $0.15 za 1M tokenów
- Output: $0.60 za 1M tokenów

**Przykład:**
Jeśli agent obsługuje 10,000 zapytań dziennie, a każde zapytanie to 100 tokenów promptu + 150 tokenów odpowiedzi:

**GPT-4o:**
- Input: 10,000 × 100 = 1M tokenów = $2.50
- Output: 10,000 × 150 = 1.5M tokenów = $15.00
- **Razem dziennie: $17.50 | miesięcznie: ~$525**

**GPT-4o mini:**
- Input: 10,000 × 100 = 1M tokenów = $0.15
- Output: 10,000 × 150 = 1.5M tokenów = $0.90
- **Razem dziennie: $1.05 | miesięcznie: ~$31.50**

**Oszczędność:** ~$494/miesiąc przez wybór tańszego modelu dla prostych zadań!

---

## Podsumowanie – koszty i optymalizacja

**Kluczowe wnioski:**

1. **Tokeny = pieniądze** – każdy token w API kosztuje
2. **Wybieraj model świadomie** – GPT-4 jest droższy niż GPT-4o mini
3. **Optymalizuj prompty** – krótsze = tańsze
4. **Monitoruj zużycie** – unikaj niespodzianek na fakturze
5. **ChatGPT Plus opłacalny dla power users** – 9600+ wiadomości/m za $20
6. **API lepsze dla aplikacji** – pełna kontrola i integracja
7. **Zwięzłość promptu** – może zaoszczędzić setki dolarów miesięcznie
8. **Cache'owanie** – wykorzystuj mechanizmy optymalizacyjne API
