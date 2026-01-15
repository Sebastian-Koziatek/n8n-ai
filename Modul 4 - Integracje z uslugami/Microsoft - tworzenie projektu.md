# Integracja n8n z Microsoft 365 (OAuth2 – Microsoft Graph)

Poniższa instrukcja opisuje **kompletną, działającą konfigurację** integracji n8n z Microsoft 365 (Outlook / Microsoft Graph) dla **aplikacji single-tenant** w Microsoft Entra ID.

Instrukcja jest oparta na realnym procesie debugowania i zawiera wyłącznie kroki wymagane do poprawnego działania.

---

## Krok 1. Zarejestruj aplikację w Microsoft Entra ID (Azure AD)

1. Wejdź do portalu: https://entra.microsoft.com
2. **Entra ID → App registrations → New registration**.
3. **Nazwa**: np. `n8n-m365`.
4. **Supported account types**: Konta tylko w tym katalogu organizacyjnym.
5. **Indentyfikator URL przekieorwanie**: Internet => `https://<twoj-n8n>/rest/oauth2-credential/callback`.
6. Zapisz.

![Rejestracja aplikacji](/grafiki/microsoft-rejestracja.png)

![Rejestracja aplikacji - krok 2](/grafiki/microsoft-rejestracja-2.png)

---

## Krok 2. Skopiuj identyfikatory aplikacji

W **Przeglądzie aplikacji** skopiuj:

* **Identyfikator aplikacji** → używany jako `Client ID`

![Tenant ID](/grafiki/microsoft-tenant-id.png)

> ⚠️ **Object ID NIE jest używany w OAuth2**

---

## Krok 3. Utwórz Client Secret (klucz tajny klienta)

1. **Certificates & secrets → Client secrets → New client secret**
2. Dodaj sekret
3. **Zapisz pole „Wartość"**

Przykład:

```
Wqf8Q~iMFIPPNqfalTLvLaie19OasOShSdxqgaat
```

![Client Secret](/grafiki/microsoft-client-secret.png)

> 💡 **Ta wartość będzie potrzebna jako Client Secret w konfiguracji n8n.**

> ⚠️ **Nigdy nie używaj „Identyfikatora wpisu tajnego"**

---

## Krok 4. Uprawnienia API (Microsoft Graph)

1. **API permissions → Add permission → Microsoft Graph**
2. Wybierz **Delegated permissions**
3. Dodaj minimalny zestaw:

   * `User.Read`
   * `Mail.Read`
4. Kliknij **Grant admin consent**

---

## Krok 5. Nadaj uprawnienia interfejsu API

1. W menu aplikacji przejdź do **API permissions** (Uprawnienia interfejsu API)
2. Kliknij **Add a permission** (Dodaj uprawnienie)
3. Wybierz **Microsoft Graph**
4. Wybierz **Delegated permissions** (Uprawnienia delegowane)

![Wybór uprawnień API](/grafiki/microsoft-api-permissions-1.png)

5. Dodaj wymagane uprawnienia do aplikacji:
   * `User.Read`
   * `Mail.Read`
   * `Mail.Send` (opcjonalnie, jeśli potrzebne wysyłanie wiadomości)

![Dodawanie uprawnień](/grafiki/microsoft-api-permissions-2.png)

6. Kliknij **Add permissions**
7. Kliknij **Grant admin consent for [nazwa organizacji]** aby zatwierdzić uprawnienia

---

## Krok 6. Konfiguracja credentiala w n8n

> Używamy **OAuth2 API (Generic)**, aby wymusić tenant-specific endpoint

### 6.1 Dodaj credential

* **Credentials → Add credential → OAuth2 API**

### 6.2 Wypełnij pola

**Authorization URL**

```
https://login.microsoftonline.com/<TENANT_ID>/oauth2/v2.0/authorize
```

**Access Token URL**

```
https://login.microsoftonline.com/<TENANT_ID>/oauth2/v2.0/token
```

**Client ID**

```
<Application (client) ID>
```

**Client Secret**

```
<WARTOŚĆ sekretu>
```

**Scope**

```
openid profile email offline_access Mail.Read
```

Pozostałe pola:

* Authentication: `Header`
* Grant Type: `Authorization Code`

---

## Krok 7. Autoryzacja

1. Kliknij **Connect my account**
2. Zaloguj się kontem z tej samej dzierżawy
3. Zatwierdź zgody

Po poprawnym zakończeniu:

* Credential w n8n ma status **Connected**

---

## Najczęstsze błędy i ich przyczyny

### AADSTS700016 – Application not found

* Client ID ≠ Application (client) ID
* Zły Tenant ID

### AADSTS50194 – common endpoint

* Aplikacja single-tenant + `/common`
* Rozwiązanie: **tenant-specific URL**

### AADSTS7000215 – Invalid client secret

* Wklejono **Secret ID** zamiast **Value**
* Rozwiązanie: wygeneruj nowy secret

### Insufficient parameters for OAuth2 callback

* OAuth przerwany po stronie Microsoft
* Zawsze efekt wcześniejszego błędu

---

## Minimalna konfiguracja produkcyjna (checklista)

* [x] Aplikacja single-tenant
* [x] Redirect URI zgodny 1:1 z n8n
* [x] Delegated permissions
* [x] Tenant-specific OAuth endpoint
* [x] Client Secret = VALUE

---

## Uwagi produkcyjne

* Zaplanuj rotację Client Secret
* Rozważ certyfikat zamiast sekretu
* Minimalizuj zakresy (least privilege)

---

## Gotowe

Po wykonaniu powyższych kroków integracja n8n ↔ Microsoft 365 działa stabilnie i poprawnie.
