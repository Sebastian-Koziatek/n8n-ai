# Pogoda

```json
{
  "name": "2. Pogoda",
  "nodes": [
    {
      "parameters": {},
      "type": "n8n-nodes-base.manualTrigger",
      "typeVersion": 1,
      "position": [
        0,
        -96
      ],
      "id": "75c952e3-2d2e-4485-89b8-c41e60d3b7f0",
      "name": "When clicking 'Execute workflow'"
    },
    {
      "parameters": {
        "url": "https://api.open-meteo.com/v1/forecast?latitude=50.0647&longitude=19.9450&current_weather=true&hourly=temperature_2m,relative_humidity_2m,wind_speed_10m",
        "options": {}
      },
      "type": "n8n-nodes-base.httpRequest",
      "typeVersion": 4.2,
      "position": [
        208,
        -96
      ],
      "id": "a8fabf7a-71e7-43ca-9224-f7fa09d3205d",
      "name": "HTTP Request"
    },
    {
      "parameters": {
        "promptType": "define",
        "text": "=Jesteś AI Agentem w n8n\n\nDzisiaj w Krakowie jest taka pogoda:\nTemperatura: {{ $json.current_weather.temperature }}\nPrędkość wiatru: {{ $json.current_weather.windspeed }}\n\n\nNa podstawie tych danych zaproponuj mi odpowiedniu ubiór. \n\nOdpowiedz mi tylko w formacie HTML gotowym do wysłania przez gmail.",
        "options": {}
      },
      "type": "@n8n/n8n-nodes-langchain.agent",
      "typeVersion": 2.2,
      "position": [
        384,
        -96
      ],
      "id": "ba4cc304-e19b-4e2e-900c-72dae6d0e564",
      "name": "AI Agent"
    },
    {
      "parameters": {
        "sendTo": "sebastian.koziatek@sadmin.pl",
        "subject": "Pogoda dla Krakowa",
        "message": "={{ $json.output }}",
        "options": {}
      },
      "type": "n8n-nodes-base.gmail",
      "typeVersion": 2.1,
      "position": [
        736,
        -96
      ],
      "id": "8af9e32a-f270-4938-ac5d-00cdef630309",
      "name": "Send a message",
      "webhookId": "96d288f2-d6e2-4e45-94b4-57f6b45a603d",
      "credentials": {
        "gmailOAuth2": {
          "id": "0Wj0gH1mIojguqO2",
          "name": "Gmail account"
        }
      }
    },
    {
      "parameters": {
        "options": {}
      },
      "type": "@n8n/n8n-nodes-langchain.lmChatGoogleGemini",
      "typeVersion": 1,
      "position": [
        256,
        112
      ],
      "id": "34ba392e-663e-4092-9f0e-637ac270b8f1",
      "name": "Google Gemini Chat Model",
      "credentials": {
        "googlePalmApi": {
          "id": "4uHZO99YEmZNtmuG",
          "name": "Google Gemini(PaLM) Api account"
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
            "node": "AI Agent",
            "type": "main",
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
    },
    "Google Gemini Chat Model": {
      "ai_languageModel": [
        [
          {
            "node": "AI Agent",
            "type": "ai_languageModel",
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
  "versionId": "57ede4f9-ae73-4e6e-92a0-6b2ded6cade9",
  "meta": {
    "templateCredsSetupCompleted": true,
    "instanceId": "1353456e2ddcdae7487c07e33159c9fe20fa539d7372a5785d975b74e64d953b"
  },
  "id": "9b8TLk21634LaCWj",
  "tags": []
}
```
