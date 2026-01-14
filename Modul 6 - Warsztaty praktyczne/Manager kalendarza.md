```json
{
  "name": "8. Manager kalendarza",
  "nodes": [
    {
      "parameters": {
        "promptType": "define",
        "text": "=Jesteś asystentem AI w n8n z bezpośrednim dostępem do Google Calendar.\n\n### KONTEKST CZASOWY (BARDZO WAŻNE):\nDziś jest: {{ $now.format('EEEE, d MMMM yyyy, HH:mm', {timeZone: 'Europe/Warsaw', locale: 'pl'}) }}\nStrefa czasowa: Europe/Warsaw.\n\nWszystkie daty względne (np. \"jutro\", \"za tydzień\", \"w środę\", \"27 listopada\") musisz obliczać w odniesieniu do powyższej daty \"Dziś\".\nZAWSZE używaj roku wynikającego z obecnej daty ({{ $now.format('yyyy') }}), chyba że użytkownik wyraźnie poda inny rok (np. 2026).\n\n### INSTRUKCJE:\n\n1) DODAWANIE WYDARZEŃ:\n- Jeśli intencją użytkownika jest dodanie wpisu (np. \"dodaj\", \"zapisz\", \"umów\", \"siłownia jutro\"), BEZWZGLĘDNIE użyj narzędzia \"Create an event\".\n- Parametry do narzędzia:\n  - Start/Koniec: Muszą być w formacie ISO lub zrozumiałym dla narzędzia. Jeśli nie podano czasu trwania, przyjmij 1 godzinę.\n  - Tytuł: Wyciągnij z kontekstu.\n- Jeśli użytkownik poda datę bez godziny (np. \"zapisz dentystę na jutro\"), dopytaj krótko o godzinę, zamiast zgadywać.\n\n2) STYL ODPOWIEDZI:\n- Po pomyślnym użyciu narzędzia napisz tylko krótkie potwierdzenie, np.: \"Dodałem wpis '[Tytuł]' na [Data] o godzinie [Godzina].\"\n- Nie tłumacz się z technikalii (nie pisz \"użyłem narzędzia\", \"skorzystałem z API\").\n- Odpowiadaj naturalnym językiem polskim.\n\n3) INNE TEMATY:\n- Jeśli użytkownik nie mówi o kalendarzu, prowadź normalną rozmowę.\n\nWykonuj polecenie pdane tutaj:\n{{ $json.chatInput }}\n\n   UŻYWASZ narzędzia Google Calendar Create Event.",
        "options": {}
      },
      "type": "@n8n/n8n-nodes-langchain.agent",
      "typeVersion": 2.2,
      "position": [
        208,
        0
      ],
      "id": "55cc9079-530d-43df-ba0d-219d81573e1d",
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
      "id": "967ec645-a8b3-4d98-a28b-64fd8c30aa85",
      "name": "OpenAI Chat Model",
      "credentials": {
        "openAiApi": {
          "id": "n4IfKjRdUa9SjsVf",
          "name": "OpenAi account 2"
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
        672,
        208
      ],
      "id": "56d2e3c7-d390-4f71-bcd5-c6f5233a9d18",
      "name": "Get many events in Google Calendar",
      "credentials": {
        "googleCalendarOAuth2Api": {
          "id": "o8kYeKNsvdk1QzTt",
          "name": "Google Calendar account"
        }
      }
    },
    {
      "parameters": {
        "options": {}
      },
      "type": "@n8n/n8n-nodes-langchain.chatTrigger",
      "typeVersion": 1.3,
      "position": [
        0,
        0
      ],
      "id": "6057d1db-8dce-4566-bdde-307afb3a014d",
      "name": "When chat message received",
      "webhookId": "57edfaa5-8701-4922-b8e1-f3ba9264ea64"
    },
    {
      "parameters": {},
      "type": "@n8n/n8n-nodes-langchain.memoryBufferWindow",
      "typeVersion": 1.3,
      "position": [
        80,
        224
      ],
      "id": "ad3bdf22-a07c-4d50-a30e-7f88340750b4",
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
      "id": "4a63d112-2c5d-4306-a734-8218c064ebb4",
      "name": "Create an event in Google Calendar",
      "credentials": {
        "googleCalendarOAuth2Api": {
          "id": "o8kYeKNsvdk1QzTt",
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
      "id": "10df846e-1b3a-4d5a-bb9f-6696a87f7d57",
      "name": "Delete an event in Google Calendar",
      "credentials": {
        "googleCalendarOAuth2Api": {
          "id": "o8kYeKNsvdk1QzTt",
          "name": "Google Calendar account"
        }
      }
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
    "AI Agent": {
      "main": [
        []
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
    }
  },
  "active": false,
  "settings": {
    "executionOrder": "v1"
  },
  "versionId": "33b13986-3e88-49bc-9cc4-f33cf4f9fb3b",
  "meta": {
    "templateCredsSetupCompleted": true,
    "instanceId": "45cdfe5d33c15ac09fe745eed18ba8431c804bbc71dfc7e4a62ca65ad47117cb"
  },
  "id": "tXxD56bTsb9RrU93",
  "tags": []
}
```