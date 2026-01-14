```json
{
  "name": "4. Telegram",
  "nodes": [
    {
      "parameters": {
        "updates": [
          "message"
        ],
        "additionalFields": {}
      },
      "type": "n8n-nodes-base.telegramTrigger",
      "typeVersion": 1.2,
      "position": [
        0,
        0
      ],
      "id": "dc2588c2-6f4e-46de-8532-9c55ccb2c96b",
      "name": "Telegram Trigger",
      "webhookId": "5721f9e2-06c1-465c-b5e1-efc628aad1f1",
      "credentials": {
        "telegramApi": {
          "id": "GGNMzpacCZnzAuab",
          "name": "Telegram account"
        }
      }
    },
    {
      "parameters": {
        "promptType": "define",
        "text": "=Jesteś agentem AI pracującym w n8n. Masz pełny dostęp do podłączonych narzędzi w tym workflow, w tym narzędzia Google Calendar „Create Event”. Nigdy nie twierdzisz, że nie masz dostępu do kalendarza, API czy Google — bo to narzędzie wykonuje wszystko za Ciebie.\n\nTreść wiadomości użytkownika z Telegrama otrzymujesz jako: {{ $json.message.text }}.\n\nTwoje zasady działania:\n\n1) Dodawanie wydarzeń:\n- Jeśli użytkownik napisze cokolwiek sugerującego dodanie, zapisanie, ustawienie lub umówienie wydarzenia, np.:\n  „dodaj do kalendarza”, „zapisz spotkanie jutro o 14”, „umów wizytę na poniedziałek 9:00”, „zrób wpis: test szkolenie 20 listopada”\n  → UŻYWASZ narzędzia Google Calendar Create Event.\n- Wyciągnij z wiadomości:\n  • tytuł (summary),\n  • datę,\n  • godzinę startu,\n  • godzinę końca lub czas trwania (jeśli nie ma – przyjmij 1 godzinę),\n  • opcjonalnie opis i lokalizację.\n- Daty względne (dziś, jutro, w środę, za tydzień) zamieniasz na konkretne daty.\n- Jeśli absolutnie brakuje kluczowej informacji (np. brak jakiejkolwiek daty), zapytaj jednym krótkim pytaniem.\n\n2) Odpowiadanie:\n- Po utworzeniu wydarzenia wysyłasz krótkie potwierdzenie, np.:\n  „Dodałem wydarzenie 'Spotkanie' jutro o 14:00.”\n- Nigdy nie piszesz o ICS, importach, API, instrukcjach ręcznych, braku dostępu, ani o tym, czego nie możesz zrobić.\n\n3) Inne wiadomości:\n- Jeśli wiadomość nie dotyczy kalendarza, odpowiadasz normalnie na jej treść.\n- Nie dodajesz dopisków typu: „This message was sent automatically with n8n”.\n\nTwoim zadaniem jest wykonywanie poleceń użytkownika poprzez narzędzia n8n.\n",
        "options": {}
      },
      "type": "@n8n/n8n-nodes-langchain.agent",
      "typeVersion": 2.2,
      "position": [
        208,
        0
      ],
      "id": "58e8823d-8b49-4ea0-a8c6-18718847d0f5",
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
        80,
        208
      ],
      "id": "a51b1c2c-61c5-411d-bfd8-c4deb3db1f38",
      "name": "OpenAI Chat Model",
      "credentials": {
        "openAiApi": {
          "id": "QIDUdl5nMKsoFRT8",
          "name": "OpenAi account"
        }
      }
    },
    {
      "parameters": {
        "operation": "getAll",
        "calendar": {
          "__rl": true,
          "value": "c_052ff8ec6c89fe77d412ab1186a2c569020c927826e4cca76a8c4b0e696e82cc@group.calendar.google.com",
          "mode": "list",
          "cachedResultName": "Seba Koziatek "
        },
        "options": {}
      },
      "type": "n8n-nodes-base.googleCalendarTool",
      "typeVersion": 1.3,
      "position": [
        464,
        224
      ],
      "id": "812a2d4c-0069-441b-ab2c-c4a1fe3d9e34",
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
        "chatId": "={{ $node[\"Telegram Trigger\"].json[\"message\"][\"chat\"][\"id\"] }}",
        "text": "={{ $json.output }}",
        "additionalFields": {}
      },
      "type": "n8n-nodes-base.telegram",
      "typeVersion": 1.2,
      "position": [
        560,
        0
      ],
      "id": "d238a0d7-6f2e-40c4-82be-e310e4c26723",
      "name": "Send a text message",
      "webhookId": "b2fffcef-b5a7-493d-98b7-a788f5f54ef2",
      "credentials": {
        "telegramApi": {
          "id": "GGNMzpacCZnzAuab",
          "name": "Telegram account"
        }
      }
    }
  ],
  "pinData": {},
  "connections": {
    "Telegram Trigger": {
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
        [
          {
            "node": "Send a text message",
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
  "versionId": "4459ddc7-98ae-4901-bfe9-e943845ed77a",
  "meta": {
    "templateCredsSetupCompleted": true,
    "instanceId": "45cdfe5d33c15ac09fe745eed18ba8431c804bbc71dfc7e4a62ca65ad47117cb"
  },
  "id": "MEFtrU8dHIMfekRH",
  "tags": []
}
```