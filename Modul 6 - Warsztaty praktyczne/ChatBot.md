# ChatBot

```json
{
  "name": "1. ChatBot",
  "nodes": [
    {
      "parameters": {
        "public": true,
        "options": {}
      },
      "type": "@n8n/n8n-nodes-langchain.chatTrigger",
      "typeVersion": 1.3,
      "position": [
        0,
        0
      ],
      "id": "07d33daf-142a-4189-b560-ce77c22098e8",
      "name": "When chat message received",
      "webhookId": "f06b3f54-e625-4ab8-83ea-94caa009a6b9"
    },
    {
      "parameters": {
        "promptType": "define",
        "text": "={{ $json.chatInput }}",
        "options": {}
      },
      "type": "@n8n/n8n-nodes-langchain.agent",
      "typeVersion": 2.2,
      "position": [
        208,
        0
      ],
      "id": "bef9ed47-908e-4144-84aa-56f038f9c9e2",
      "name": "AI Agent"
    },
    {
      "parameters": {},
      "type": "@n8n/n8n-nodes-langchain.memoryBufferWindow",
      "typeVersion": 1.3,
      "position": [
        240,
        208
      ],
      "id": "493204ee-6fc7-4346-90d4-835811578736",
      "name": "Simple Memory"
    },
    {
      "parameters": {
        "options": {}
      },
      "type": "@n8n/n8n-nodes-langchain.lmChatGoogleGemini",
      "typeVersion": 1,
      "position": [
        80,
        208
      ],
      "id": "3490a7e6-b3a5-4865-9640-104aade1b69a",
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
  "versionId": "82e76958-90d0-4697-8c8f-4d90d2391f96",
  "meta": {
    "templateCredsSetupCompleted": true,
    "instanceId": "1353456e2ddcdae7487c07e33159c9fe20fa539d7372a5785d975b74e64d953b"
  },
  "id": "8Q4mdh5s4aaVGlfL",
  "tags": []
}
```
