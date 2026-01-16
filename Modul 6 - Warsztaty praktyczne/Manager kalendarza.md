# Manager kalendarza

```json
{
  "name": "8. Manager kalendarza",
  "nodes": [
    {
      "parameters": {
        "promptType": "define",
        "text": "=Jesteś asystentem AI w n8n z bezpośrednim dostępem do Google Calendar.\n\n### KONTEKST CZASOWY (BARDZO WAŻNE):\nDziś jest: {{ $now.format('EEEE, d MMMM yyyy, HH:mm', {timeZone: 'Europe/Warsaw', locale: 'pl'}) }}\nStrefa czasowa: Europe/Warsaw.\n\nWszystkie daty względne (np. \"jutro\", \"za tydzień\", \"w środę\", \"27 listopada\") musisz obliczać w odniesieniu do powyższej daty \"Dziś\".\nZAWSZE używaj roku wynikającego z obecnej daty ({{ $now.format('yyyy') }}), chyba że użytkownik wyraźnie poda inny rok (np. 2026).\n\n### INSTRUKCJE:\n\n1) DODAWANIE WYDARZEŃ:\n- Jeśli intencją użytkownika jest dodanie wpisu (np. \"dodaj\", \"zapisz\", \"umów\", \"siłownia jutro\"), BEZWZGLĘDNIE użyj narzędzia \"Create an event\".\n- Parametry do narzędzia:\n  - Start/Koniec: Muszą być w formacie ISO lub zrozumiałym dla narzędzia. Jeśli nie podano czasu trwania, przyjmij 1 godzinę.\n  - Tytuł: Wyciągnij z kontekstu.\n- Jeśli użytkownik poda datę bez godziny (np. \"zapisz dentystę na jutro\"), dopytaj krótko o godzinę, zamiast zgadywać.\n\n2) STYL ODPOWIEDZI:\n- Po pomyślnym użyciu narzędzia napisz tylko krótkie potwierdzenie, np.: \"Dodałem wpis '[Tytuł]' na [Data] o godzinie [Godzina].\"\n- Nie tłumacz się z technikalii (nie pisz \"użyłem narzędzia\", \"skorzystałem z API\").\n- Odpowiadaj naturalnym językiem polskim.\n\n3) INNE TEMATY:\n- Jeśli użytkownik nie mówi o kalendarzu, prowadź normalną rozmowę.\n\nWykonuj polecenie pdane tutaj:\n{{ $json.chatInput }}\n\n  → UŻYWASZ narzędzia Google Calendar Create Event.",
        "options": {}
      },
      "type": "@n8n/n8n-nodes-langchain.agent",
      "typeVersion": 2.2,
      "position": [
        208,
        0
      ],
      "id": "5c423f0f-06f0-4ab6-80c9-fb4ea62333c7",
      "name": "AI Agent"
    },
    {
      "parameters": {
        "model": {
          "__rl": true,
          "value": "gpt-5-nano",
          "mode": "list",
          "cachedResultName": "gpt-5-nano"
        },
        "options": {}
      },
      "type": "@n8n/n8n-nodes-langchain.lmChatOpenAi",
      "typeVersion": 1.2,
      "position": [
        -96,
        224
      ],
      "id": "fa0271fc-6edf-4c64-a8c1-652cd563b41f",
      "name": "OpenAI Chat Model",
      "credentials": {
        "openAiApi": {
          "id": "WkBGVlYnxgM1ovVB",
          "name": "OpenAi account"
        }
      }
    },
    {
      "parameters": {
        "operation": "getAll",
        "calendar": {
          "__rl": true,
          "value": "83f79425be2ef2645de45538a11526ffe9665401c865ecacc014da7416dc7606@group.calendar.google.com",
          "mode": "list",
          "cachedResultName": "Szkolenie n8n"
        },
        "options": {}
      },
      "type": "n8n-nodes-base.googleCalendarTool",
      "typeVersion": 1.3,
      "position": [
        688,
        208
      ],
      "id": "64081219-6b20-4aa1-a830-d439460f873a",
      "name": "Get many events in Google Calendar",
      "credentials": {
        "googleCalendarOAuth2Api": {
          "id": "V0t3xTDCQzdi8ESC",
          "name": "Google Calendar account"
        }
      }
    },
    {
      "parameters": {},
      "type": "@n8n/n8n-nodes-langchain.memoryBufferWindow",
      "typeVersion": 1.3,
      "position": [
        80,
        224
      ],
      "id": "7134d0e8-d60f-4de8-9dc5-4743a558ff03",
      "name": "Simple Memory"
    },
    {
      "parameters": {
        "calendar": {
          "__rl": true,
          "value": "83f79425be2ef2645de45538a11526ffe9665401c865ecacc014da7416dc7606@group.calendar.google.com",
          "mode": "list",
          "cachedResultName": "Szkolenie n8n"
        },
        "start": "={{ /*n8n-auto-generated-fromAI-override*/ $fromAI('Start', ``, 'string') }}",
        "end": "={{ /*n8n-auto-generated-fromAI-override*/ $fromAI('End', ``, 'string') }}",
        "additionalFields": {
          "summary": "={{ /*n8n-auto-generated-fromAI-override*/ $fromAI('Summary', ``, 'string') }}"
        }
      },
      "type": "n8n-nodes-base.googleCalendarTool",
      "typeVersion": 1.3,
      "position": [
        528,
        208
      ],
      "id": "6ff40979-132b-4836-98c7-ab54b1b333aa",
      "name": "Create an event in Google Calendar",
      "credentials": {
        "googleCalendarOAuth2Api": {
          "id": "V0t3xTDCQzdi8ESC",
          "name": "Google Calendar account"
        }
      }
    },
    {
      "parameters": {
        "operation": "delete",
        "calendar": {
          "__rl": true,
          "value": "83f79425be2ef2645de45538a11526ffe9665401c865ecacc014da7416dc7606@group.calendar.google.com",
          "mode": "list",
          "cachedResultName": "Szkolenie n8n"
        },
        "eventId": "={{ /*n8n-auto-generated-fromAI-override*/ $fromAI('Event_ID', ``, 'string') }}",
        "options": {}
      },
      "type": "n8n-nodes-base.googleCalendarTool",
      "typeVersion": 1.3,
      "position": [
        368,
        208
      ],
      "id": "87dd9366-77e4-4904-88d1-6162bb149fd7",
      "name": "Delete an event in Google Calendar",
      "credentials": {
        "googleCalendarOAuth2Api": {
          "id": "V0t3xTDCQzdi8ESC",
          "name": "Google Calendar account"
        }
      }
    },
    {
      "parameters": {
        "options": {}
      },
      "type": "@n8n/n8n-nodes-langchain.chatTrigger",
      "typeVersion": 1.4,
      "position": [
        0,
        0
      ],
      "id": "c3ed7cd8-5000-4990-a9ad-02d98129ced4",
      "name": "When chat message received",
      "webhookId": "c9a8918b-2c4f-4d72-8f01-a10835610371"
    }
  ],
  "pinData": {},
  "connections": {
    "OpenAI Chat Model": {
      "ai_languageModel": [
        [
          {
            "node": "AI Agent",
            "type": "ai_languageModel",
            "index": 0
          }
        ]
      ]
    },
    "Get many events in Google Calendar": {
      "ai_tool": [
        [
          {
            "node": "AI Agent",
            "type": "ai_tool",
            "index": 0
          }
        ]
      ]
    },
    "Simple Memory": {
      "ai_memory": [
        [
          {
            "node": "AI Agent",
            "type": "ai_memory",
            "index": 0
          }
        ]
      ]
    },
    "Create an event in Google Calendar": {
      "ai_tool": [
        [
          {
            "node": "AI Agent",
            "type": "ai_tool",
            "index": 0
          }
        ]
      ]
    },
    "Delete an event in Google Calendar": {
      "ai_tool": [
        [
          {
            "node": "AI Agent",
            "type": "ai_tool",
            "index": 0
          }
        ]
      ]
    },
    "When chat message received": {
      "main": [
        [
          {
            "node": "AI Agent",
            "type": "main",
            "index": 0
          }
        ]
      ]
    }
  },
  "active": false,
  "settings": {
    "executionOrder": "v1"
  },
  "versionId": "6f064af5-1760-4e42-b81e-9a9c150b8be4",
  "meta": {
    "templateCredsSetupCompleted": true,
    "instanceId": "1353456e2ddcdae7487c07e33159c9fe20fa539d7372a5785d975b74e64d953b"
  },
  "id": "EIZb7L2jP7gmgzPR",
  "tags": []
}
```
