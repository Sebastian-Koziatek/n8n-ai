```json
{
  "name": "5. Gemini",
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
      "id": "3429ee19-9455-488f-bf31-717822ca2470",
      "name": "When chat message received",
      "webhookId": "ed5c46d6-080f-427c-9e83-04ffc209c626"
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
      "id": "16a00015-52aa-44a5-a0dd-a5d867959e60",
      "name": "AI Agent"
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
      "id": "83641c5e-45a5-49b6-99dd-c00047a6b161",
      "name": "Google Gemini Chat Model",
      "credentials": {
        "googlePalmApi": {
          "id": "l2Zzh79TXBJdGwI7",
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
  "versionId": "f282b6d2-8237-4f75-8c45-e89b94a4af6e",
  "meta": {
    "templateCredsSetupCompleted": true,
    "instanceId": "45cdfe5d33c15ac09fe745eed18ba8431c804bbc71dfc7e4a62ca65ad47117cb"
  },
  "id": "q43v1Y7D4zIETBTW",
  "tags": []
}
```
