# Scrapper www

```json
{
  "name": "12. Scrapper www",
  "nodes": [
    {
      "parameters": {},
      "type": "n8n-nodes-base.manualTrigger",
      "typeVersion": 1,
      "position": [
        -336,
        0
      ],
      "id": "5fc9e54c-7653-4e85-bbf2-5a5a637eab68",
      "name": "When clicking 'Execute workflow'"
    },
    {
      "parameters": {
        "operation": "convertToHtmlTable",
        "options": {}
      },
      "type": "n8n-nodes-base.html",
      "typeVersion": 1.2,
      "position": [
        80,
        0
      ],
      "id": "a86751da-57f2-4690-a237-6e20b90feb10",
      "name": "HTML"
    },
    {
      "parameters": {
        "url": "https://sekurak.pl/",
        "options": {}
      },
      "type": "n8n-nodes-base.httpRequest",
      "typeVersion": 4.3,
      "position": [
        -128,
        0
      ],
      "id": "bbf2e818-de3a-4d6a-81c9-50075dde46d6",
      "name": "HTTP Request"
    },
    {
      "parameters": {
        "promptType": "define",
        "text": "={{ $json.table }}\n\nPrzenalizuj tabele html i wypisz wpisy przygotowane w tym tygodniu\n\nPrzygotuj odpowiedz w HTML tak zebym mogl ja przeslac mailem ",
        "options": {}
      },
      "type": "@n8n/n8n-nodes-langchain.agent",
      "typeVersion": 3,
      "position": [
        336,
        0
      ],
      "id": "8b51337f-52a9-4442-b6ba-1f7b65944105",
      "name": "AI Agent"
    },
    {
      "parameters": {
        "model": {
          "__rl": true,
          "value": "gpt-4.1",
          "mode": "list",
          "cachedResultName": "gpt-4.1"
        },
        "builtInTools": {},
        "options": {}
      },
      "type": "@n8n/n8n-nodes-langchain.lmChatOpenAi",
      "typeVersion": 1.3,
      "position": [
        208,
        208
      ],
      "id": "d2f85fb3-0f95-41fb-a950-2bbf07c6682d",
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
        "sendTo": "sebastian.koziatek@sadmin.pl",
        "subject": "Parser",
        "message": "={{ $json.output }}",
        "options": {}
      },
      "type": "n8n-nodes-base.gmail",
      "typeVersion": 2.1,
      "position": [
        688,
        0
      ],
      "id": "4f858898-a66f-4fa0-b7fc-9066a66e11ff",
      "name": "Send a message",
      "webhookId": "a4754816-7447-4efa-ad16-a636633b5e47",
      "credentials": {
        "gmailOAuth2": {
          "id": "0Wj0gH1mIojguqO2",
          "name": "Gmail account"
        }
      }
    }
  ],
  "pinData": {},
  "connections": {
    "When clicking 'Execute workflow'": {
      "main": [
        [
          {
            "node": "HTTP Request",
            "type": "main",
            "index": 0
          }
        ]
      ]
    },
    "HTTP Request": {
      "main": [
        [
          {
            "node": "HTML",
            "type": "main",
            "index": 0
          }
        ]
      ]
    },
    "HTML": {
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
    "AI Agent": {
      "main": [
        [
          {
            "node": "Send a message",
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
  "versionId": "9d9497a2-94cf-4ede-affa-3ecfa2e68fae",
  "meta": {
    "templateCredsSetupCompleted": true,
    "instanceId": "1353456e2ddcdae7487c07e33159c9fe20fa539d7372a5785d975b74e64d953b"
  },
  "id": "OhThxyX2swsPGqma",
  "tags": []
}
```
