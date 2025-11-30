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
        0
      ],
      "id": "0838547e-359d-48ad-8951-4507c026b63d",
      "name": "When clicking ‘Execute workflow’"
    },
    {
      "parameters": {
        "url": "https://api.open-meteo.com/v1/forecast?latitude=50.0614&longitude=19.9366&current_weather=true",
        "options": {}
      },
      "type": "n8n-nodes-base.httpRequest",
      "typeVersion": 4.2,
      "position": [
        208,
        0
      ],
      "id": "a9e43bc1-0882-4a52-8c10-c30ac0e313a1",
      "name": "HTTP Request"
    },
    {
      "parameters": {
        "promptType": "define",
        "text": "=Poniżej masz gotowy, poprawiony prompt, idealnie dostosowany do Open-Meteo i do danych, które pokazałeś.\nDziała 1:1 w n8n, nie odwołuje się do JSON, nie pyta o dane, nie wspomina o brakach – wszystko zgodnie z Twoimi zasadami.\nFormat raportu pozostaje taki sam, ale pola są mapowane na dane Open-Meteo (które mają inne nazwy niż wttr.in).\nPOPRAWIONY PROMPT (WKLEJ DO n8n “Message a model”)\nPrzygotuj krótki, czytelny raport pogodowy na podstawie dostarczonych danych.\nNigdy nie proś o dane i nie wspominaj o formatach, strukturach ani o brakach.\nJeśli jakieś pole jest niedostępne, wpisz \"brak danych\".\nZwróć odpowiedź dokładnie w poniższym formacie, wstawiając prawdziwe wartości zamiast nawiasów klamrowych:\nMiejscowość: {areaName}, {country}\nTemperatura: {temp_C}°C (odczuwalna: {FeelsLikeC}°C)\nPogoda: {weatherDesc}\nWilgotność: {humidity}%\nWiatr: {windspeedKmph} km/h\nCiśnienie: {pressure} hPa\nWidoczność: {visibility} km\nKomentarz: {krótkie jedno zdanie opisujące warunki}\nDane wejściowe:\n{{ JSON.stringify($json, null, 2) }}\nMapa danych:\nareaName → \"Kraków\"\ncountry → \"Polska\"\ntemp_C → $json.current_weather.temperature\nFeelsLikeC → brak danych\nweatherDesc → kod pogodowy z weathercode (użyj krótkiego opisu)\nhumidity → brak danych\nwindspeedKmph → $json.current_weather.windspeed\npressure → brak danych\nvisibility → brak danych",
        "options": {}
      },
      "type": "@n8n/n8n-nodes-langchain.agent",
      "typeVersion": 2.2,
      "position": [
        384,
        0
      ],
      "id": "c81354b3-c47d-4229-98b9-8ac711498da5",
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
        256,
        208
      ],
      "id": "9e23c4bb-516d-43d6-8784-2f19d417e052",
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
        "select": "channel",
        "channelId": {
          "__rl": true,
          "value": "#n8n-1",
          "mode": "name"
        },
        "text": "={{ $json.output }}\n\nSebastian",
        "otherOptions": {}
      },
      "type": "n8n-nodes-base.slack",
      "typeVersion": 2.3,
      "position": [
        736,
        64
      ],
      "id": "c070c7fb-3683-49f5-bd26-02ed0e38c961",
      "name": "Send a message",
      "webhookId": "1a6c89b0-22d9-49bb-9698-2c25f5d842c8",
      "credentials": {
        "slackApi": {
          "id": "tPqpFoNVEcDSYAwB",
          "name": "Slack account"
        }
      }
    }
  ],
  "pinData": {},
  "connections": {
    "When clicking ‘Execute workflow’": {
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
    }
  },
  "active": false,
  "settings": {
    "executionOrder": "v1"
  },
  "versionId": "d0c19cf1-ee74-4a17-b5dc-ff7159980059",
  "meta": {
    "templateCredsSetupCompleted": true,
    "instanceId": "45cdfe5d33c15ac09fe745eed18ba8431c804bbc71dfc7e4a62ca65ad47117cb"
  },
  "id": "vEbxDfUh2o3XM785",
  "tags": []
}
```