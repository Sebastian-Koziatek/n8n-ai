```json
{
  "name": "10. Gmail",
  "nodes": [
    {
      "parameters": {
        "options": {}
      },
      "type": "@n8n/n8n-nodes-langchain.chatTrigger",
      "typeVersion": 1.4,
      "position": [
        -400,
        0
      ],
      "id": "5f59b3ee-44f1-40a4-b069-7de11c7e9bc2",
      "name": "When chat message received",
      "webhookId": "0c075e0e-e818-43a3-9a12-2851b9645b28"
    },
    {
      "parameters": {
        "promptType": "define",
        "text": "=Jesteś agentem n8n odpowiedzialnym za pobieranie wiadomości Gmail.\nDzisiejsza data to: {{ $json.currentDate }}.\nMasz jedno narzędzie: Get many messages in Gmail.\nTo narzędzie przyjmuje dokładnie jeden parametr: query (string).\nZawsze wykonujesz te kroki:\nOdczytaj polecenie użytkownika po polsku.\nUstal jeden konkretny dzień, którego dotyczy pytanie użytkownika:\n– jeśli użyje słowa „dzisiaj”, to użyj {{ $json.currentDate }}\n– „wczoraj” → data o 1 dzień wcześniejsza\n– „przedwczoraj” → data o 2 dni wcześniejsza\nJeśli poda datę ręcznie (np. „29 listopada 2025”, „27.11.2024”), zinterpretuj ją jako jeden dzień.\nZamień dzień na format YYYY/MM/DD i wylicz dzień następny.\nZbuduj zapytanie Gmail w formacie:\nafter:YYYY/MM/DD before:YYYY/MM/DD_NASTĘPNY_DZIEŃ\nZawsze (dokładnie raz) wywołaj narzędzie „Get many messages in Gmail” z parametrem:\nquery: \"after:... before:...\"\n– nigdy nie wywołuj tego narzędzia bez parametru query\nPo otrzymaniu wyników odpowiedz użytkownikowi na czacie:\n– podaj liczbę wiadomości\n– wypisz listę „Nadawca – temat”\nJeśli lista jest pusta, napisz:\n„Brak wiadomości z tego dnia.”",
        "options": {}
      },
      "type": "@n8n/n8n-nodes-langchain.agent",
      "typeVersion": 3,
      "position": [
        -64,
        0
      ],
      "id": "99558854-9515-4b05-8c49-ba19d5a50839",
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
        "builtInTools": {},
        "options": {}
      },
      "type": "@n8n/n8n-nodes-langchain.lmChatOpenAi",
      "typeVersion": 1.3,
      "position": [
        -208,
        224
      ],
      "id": "033c09d4-4962-4633-9e75-64165756133b",
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
        "limit": 10,
        "filters": {}
      },
      "type": "n8n-nodes-base.gmailTool",
      "typeVersion": 2.1,
      "position": [
        176,
        208
      ],
      "id": "a76d70e6-44b9-4a60-bece-488b35d6de20",
      "name": "Get many messages in Gmail",
      "webhookId": "45dcb7c3-de04-472a-acd5-245726246b3e",
      "credentials": {
        "gmailOAuth2": {
          "id": "bd6wbOdqWHgE01U1",
          "name": "Gmail account"
        }
      }
    }
  ],
  "pinData": {},
  "connections": {
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
    "Get many messages in Gmail": {
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
  "versionId": "fda0fe6b-4518-434c-8f96-ceaa74a92f69",
  "meta": {
    "templateCredsSetupCompleted": true,
    "instanceId": "45cdfe5d33c15ac09fe745eed18ba8431c804bbc71dfc7e4a62ca65ad47117cb"
  },
  "id": "QIkZDsDRRGk7xL9O",
  "tags": []
}
```