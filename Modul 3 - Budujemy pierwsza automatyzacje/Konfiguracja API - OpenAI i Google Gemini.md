# Konfiguracja API - OpenAI i Google Gemini

Aby korzystać z modeli AI w n8n, potrzebujesz kluczy API (API Keys) od dostawców usług. W tej lekcji nauczysz się, jak uzyskać dostęp do OpenAI API i Google Gemini API.

---

## OpenAI API

OpenAI to firma stojąca za ChatGPT i modelami GPT-4. Ich API pozwala na integrację zaawansowanych modeli językowych w automatyzacjach.

### Jak uzyskać klucz API OpenAI?

1. **Przejdź na stronę OpenAI Platform:**
   [https://platform.openai.com](https://platform.openai.com)

2. **Zarejestruj się / Zaloguj:**
   - Utwórz konto lub zaloguj się na istniejące
   - Potrzebny jest numer telefonu do weryfikacji

3. **Przejdź do sekcji API Keys:**
   [https://platform.openai.com/api-keys](https://platform.openai.com/api-keys)

4. **Utwórz nowy klucz:**
   - Kliknij "Create new secret key"
   - Nadaj mu nazwę (np. "n8n-automation")
   - **Ważne:** Skopiuj klucz natychmiast - nie będziesz mógł go ponownie zobaczyć!

5. **Dodaj środki na konto:**
   - Przejdź do [Billing](https://platform.openai.com/account/billing)
   - Dodaj metodę płatności
   - Ustaw limity wydatków (zalecane na początek: $5-10)

### Dostępne modele OpenAI

#### GPT-4 Turbo (najnowszy, zalecany)
- **Model:** `gpt-4-turbo` lub `gpt-4-turbo-preview`
- **Kontekst:** 128,000 tokenów
- **Cena:**
  - Input: $0.01 / 1K tokenów
  - Output: $0.03 / 1K tokenów
- **Najlepszy do:** Złożone zadania, analiza, długie dokumenty

#### GPT-4
- **Model:** `gpt-4`
- **Kontekst:** 8,192 tokenów
- **Cena:**
  - Input: $0.03 / 1K tokenów
  - Output: $0.06 / 1K tokenów
- **Najlepszy do:** Zaawansowane rozumowanie, precyzyjne odpowiedzi

#### GPT-3.5 Turbo (najbardziej ekonomiczny)
- **Model:** `gpt-3.5-turbo`
- **Kontekst:** 16,385 tokenów
- **Cena:**
  - Input: $0.0005 / 1K tokenów
  - Output: $0.0015 / 1K tokenów
- **Najlepszy do:** Proste zadania, wysoka szybkość, niski koszt

#### GPT-3.5 Turbo 16K
- **Model:** `gpt-3.5-turbo-16k`
- **Kontekst:** 16,385 tokenów
- **Cena:**
  - Input: $0.003 / 1K tokenów
  - Output: $0.004 / 1K tokenów
- **Najlepszy do:** Dłuższe dokumenty przy niskim koszcie

### Modele specjalistyczne

**GPT-4 Vision** (`gpt-4-vision-preview`)
- Analiza obrazów
- Cena: $0.01 / 1K tokenów (input) + koszty obrazu

**Text Embedding** (`text-embedding-3-small`, `text-embedding-3-large`)
- Tworzenie embeddingów do wyszukiwania semantycznego
- Cena: $0.00002 - $0.00013 / 1K tokenów

**Whisper** (API)
- Transkrypcja audio
- Cena: $0.006 / minutę

**DALL-E 3**
- Generowanie obrazów
- Cena: $0.04 - $0.12 za obraz (zależnie od rozdzielczości)

### Limity i monitoring

**Free tier:**
- $5 darmowych kredytów na 3 miesiące (dla nowych użytkowników)

**Rate limits:**
- Zależne od tier konta (Tier 1-5)
- Tier 1: 500 RPM (requests per minute)
- Tier 5: 10,000 RPM

**Monitoring kosztów:**
- Dashboard: [https://platform.openai.com/usage](https://platform.openai.com/usage)
- Ustaw alerty dla budżetu
- Sprawdzaj usage regularnie

---

## Google Gemini API

Google Gemini to multimodalny model AI od Google, konkurent GPT-4. Oferuje bezpłatny tier z hojnymi limitami.

### Jak uzyskać klucz API Google Gemini?

1. **Przejdź na stronę Google AI Studio:**
   [https://ai.google.dev](https://ai.google.dev)
   lub
   [https://makersuite.google.com/app/apikey](https://makersuite.google.com/app/apikey)

2. **Zaloguj się kontem Google**

3. **Utwórz klucz API:**
   - Kliknij "Get API key"
   - Wybierz projekt GCP lub utwórz nowy
   - Skopiuj wygenerowany klucz

4. **Gotowe!**
   - Nie wymaga karty kredytowej dla darmowego tier
   - Możesz od razu zacząć testować

### Dostępne modele Google Gemini

#### Gemini 1.5 Pro (najnowszy, zalecany)
- **Model:** `gemini-1.5-pro`
- **Kontekst:** 1,000,000 tokenów (!)
- **Cena (Pay-as-you-go):**
  - Input < 128K: $0.00125 / 1K tokenów
  - Input > 128K: $0.0025 / 1K tokenów
  - Output: $0.00375 / 1K tokenów
- **Darmowy tier:** 50 zapytań/dzień
- **Najlepszy do:** Bardzo długie dokumenty, analiza dużych danych, multimodalne zadania

#### Gemini 1.5 Flash (szybki i ekonomiczny)
- **Model:** `gemini-1.5-flash`
- **Kontekst:** 1,000,000 tokenów
- **Cena (Pay-as-you-go):**
  - Input < 128K: $0.000075 / 1K tokenów
  - Input > 128K: $0.00015 / 1K tokenów
  - Output: $0.00030 / 1K tokenów
- **Darmowy tier:** 1500 zapytań/dzień
- **Najlepszy do:** Szybkie operacje, duża liczba zapytań, real-time

#### Gemini 1.0 Pro
- **Model:** `gemini-1.0-pro`
- **Kontekst:** 32,760 tokenów
- **Cena:** $0.00025 / 1K tokenów (input i output)
- **Darmowy tier:** 60 zapytań/minutę
- **Najlepszy do:** Standardowe zadania NLP

#### Gemini Pro Vision (multimodalny)
- **Model:** `gemini-pro-vision`
- **Kontekst:** Text + Images
- **Cena:** $0.0025 / 1K tokenów (input), $0.00375 / 1K tokenów (output)
- **Najlepszy do:** Analiza obrazów, OCR, visual reasoning

### Modele embeddings

**Text Embedding**
- **Model:** `text-embedding-004`
- **Wymiary:** 768
- **Cena:** $0.00001 / 1K tokenów
- **Darmowy tier:** 1500 zapytań/dzień

### Limity darmowego tier Gemini

**Gemini 1.5 Pro:**
- 50 zapytań dziennie (RPD - Requests Per Day)
- 2 zapytania na minutę (RPM)

**Gemini 1.5 Flash:**
- 1500 zapytań dziennie
- 15 zapytań na minutę

**Gemini 1.0 Pro:**
- 60 zapytań na minutę
- Brak limitu dziennego

**Uwaga:** Limity mogą się zmieniać - sprawdź aktualne na: [https://ai.google.dev/pricing](https://ai.google.dev/pricing)

### Monitoring kosztów Google Gemini

- Dashboard: [https://console.cloud.google.com/apis/api/generativelanguage.googleapis.com](https://console.cloud.google.com/apis/api/generativelanguage.googleapis.com)
- Google Cloud Console > Billing
- Ustaw budżet i alerty

---

## Porównanie OpenAI vs Google Gemini

| Kryterium | OpenAI | Google Gemini |
|-----------|--------|---------------|
| **Darmowy tier** | $5 przez 3 miesiące (nowe konta) | Hojny darmowy tier bez karty |
| **Najlepszy model** | GPT-4 Turbo | Gemini 1.5 Pro |
| **Kontekst max** | 128K tokenów | 1M tokenów (!) |
| **Cena za 1K tokenów** | $0.01 (input) | $0.00125 (input) |
| **Multimodal** | Tak (Vision) | Tak (native) |
| **Rate limits** | Tier-based | Dość hojne |
| **Łatwość startu** | Wymaga billing | Bez karty kredytowej |

---

## Konfiguracja w n8n

### OpenAI w n8n:

1. W workflow dodaj node: **OpenAI**
2. Kliknij na Credential
3. Wybierz "Create New"
4. Wklej API Key z OpenAI Platform
5. Zapisz

### Google Gemini w n8n:

**Opcja 1: Google Gemini node (jeśli dostępny)**
1. Dodaj node **Google Gemini** / **Google PaLM**
2. Skonfiguruj credentials z API Key

**Opcja 2: HTTP Request (uniwersalna metoda)**
1. Dodaj node **HTTP Request**
2. Method: POST
3. URL: `https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-pro:generateContent?key=YOUR_API_KEY`
4. Body (JSON):
```json
{
  "contents": [{
    "parts": [{
      "text": "Twoje zapytanie tutaj"
    }]
  }]
}
```

---

## Bezpieczeństwo kluczy API

**Nigdy nie udostępniaj swoich kluczy API publicznie!**

Dobre praktyki:
- Przechowuj klucze w n8n Credentials (są szyfrowane)
- Używaj environment variables
- Regularnie rotuj klucze
- Ustaw limity wydatków
- Monitoruj usage
- Twórz osobne klucze dla różnych projektów
- Usuń nieużywane klucze

---

## Estymacja kosztów

### Przykład - ChatBot ze 100 konwersacji dziennie:

**Założenia:**
- Średnio 500 tokenów input + 300 tokenów output na konwersację
- 100 konwersacji/dzień = 3000/miesiąc

**Koszt z GPT-3.5 Turbo:**
- Input: 3000 × 500 × $0.0005 / 1000 = $0.75
- Output: 3000 × 300 × $0.0015 / 1000 = $1.35
- **Razem: ~$2.10/miesiąc**

**Koszt z Gemini 1.5 Flash:**
- Input: 3000 × 500 × $0.000075 / 1000 = $0.11
- Output: 3000 × 300 × $0.00030 / 1000 = $0.27
- **Razem: ~$0.38/miesiąc**

**Darmowy tier Gemini:** Wystarczy dla małych projektów!

---

## Linki przydatne

**OpenAI:**
- Platform: [https://platform.openai.com](https://platform.openai.com)
- Dokumentacja: [https://platform.openai.com/docs](https://platform.openai.com/docs)
- Pricing: [https://openai.com/pricing](https://openai.com/pricing)
- Playground: [https://platform.openai.com/playground](https://platform.openai.com/playground)

**Google Gemini:**
- AI Studio: [https://ai.google.dev](https://ai.google.dev)
- Dokumentacja: [https://ai.google.dev/docs](https://ai.google.dev/docs)
- Pricing: [https://ai.google.dev/pricing](https://ai.google.dev/pricing)
- Cookbook: [https://github.com/google-gemini/cookbook](https://github.com/google-gemini/cookbook)

---

## Podsumowanie

Teraz masz dostęp do dwóch najpotężniejszych platform AI:
- **OpenAI** - doskonała jakość, sprawdzony model GPT-4
- **Google Gemini** - ogromny kontekst, hojny darmowy tier

W kolejnych warsztatach użyjemy tych API do budowania inteligentnych automatyzacji!
