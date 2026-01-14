```json
{
  "name": "1. ChatBot",
  "nodes": [
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
      "id": "4557aaf5-8774-471f-a6c4-518af1041fa6",
      "name": "When chat message received",
      "webhookId": "f06b3f54-e625-4ab8-83ea-94caa009a6b9"
    },
    {
      "parameters": {
        "options": {}
      },
      "type": "@n8n/n8n-nodes-langchain.agent",
      "typeVersion": 2.2,
      "position": [
        208,
        0
      ],
      "id": "d9b75a73-b67b-44c1-84d2-97dcfb0fab1f",
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
      "id": "59bfb9de-80e0-4f29-9b28-3b1b88b62c19",
      "name": "OpenAI Chat Model",
      "credentials": {
        "openAiApi": {
          "id": "QIDUdl5nMKsoFRT8",
          "name": "OpenAi account"
        }
      }
    },
    {
      "parameters": {},
      "type": "@n8n/n8n-nodes-langchain.memoryBufferWindow",
      "typeVersion": 1.3,
      "position": [
        224,
        208
      ],
      "id": "6932c46c-36e4-4fd6-99e0-3713b9763623",
      "name": "Simple Memory"
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
    }
  },
  "active": false,
  "settings": {
    "executionOrder": "v1"
  },
  "versionId": "972bb4ea-658e-460c-9d12-f9bc073f92dd",
  "meta": {
    "templateCredsSetupCompleted": true,
    "instanceId": "45cdfe5d33c15ac09fe745eed18ba8431c804bbc71dfc7e4a62ca65ad47117cb"
  },
  "id": "YKwykGTRq6qllKeG",
  "tags": []
}
```
