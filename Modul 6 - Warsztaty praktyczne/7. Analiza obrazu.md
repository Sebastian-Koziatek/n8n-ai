```json
{
  "name": "7. Analiza obrazu",
  "nodes": [
    {
      "parameters": {},
      "type": "n8n-nodes-base.manualTrigger",
      "typeVersion": 1,
      "position": [
        0,
        0
      ],
      "id": "14e07030-be68-49ba-bf09-e6494a9f68ee",
      "name": "When clicking ‘Execute workflow’"
    },
    {
      "parameters": {
        "resource": "image",
        "operation": "analyze",
        "modelId": {
          "__rl": true,
          "value": "models/gemini-2.5-flash",
          "mode": "list",
          "cachedResultName": "models/gemini-2.5-flash"
        },
        "imageUrls": "https://i.ibb.co/KcRj5h8f/image.png",
        "options": {}
      },
      "type": "@n8n/n8n-nodes-langchain.googleGemini",
      "typeVersion": 1,
      "position": [
        208,
        0
      ],
      "id": "0fdd5cb3-c594-4a75-a62e-741ba7fc5be6",
      "name": "Analyze image",
      "credentials": {
        "googlePalmApi": {
          "id": "l2Zzh79TXBJdGwI7",
          "name": "Google Gemini(PaLM) Api account"
        }
      }
    },
    {
      "parameters": {
        "promptType": "define",
        "text": "=Na podstawie opisu spróbuj wywnioskować co się mogło stać.  \n\n{{ $json.content.parts[0].text }}",
        "options": {}
      },
      "type": "@n8n/n8n-nodes-langchain.agent",
      "typeVersion": 2.2,
      "position": [
        416,
        0
      ],
      "id": "ea1d0ca8-1008-48e5-8da5-7d83ad4b5fab",
      "name": "AI Agent"
    },
    {
      "parameters": {
        "options": {}
      },
      "type": "@n8n/n8n-nodes-langchain.lmChatGoogleGemini",
      "typeVersion": 1,
      "position": [
        288,
        208
      ],
      "id": "e96622f5-87b5-4381-9c26-7e091e0fe1cf",
      "name": "Google Gemini Chat Model",
      "credentials": {
        "googlePalmApi": {
          "id": "l2Zzh79TXBJdGwI7",
          "name": "Google Gemini(PaLM) Api account"
        }
      }
    },
    {
      "parameters": {
        "sendTo": "sebastian.koziatek@sadmin.pl",
        "subject": "Opis obrazu",
        "message": "={{$json[\"output\"].split('\\\\n').join('\\n')}}\n",
        "options": {}
      },
      "type": "n8n-nodes-base.gmail",
      "typeVersion": 2.1,
      "position": [
        768,
        0
      ],
      "id": "e4ca9090-7652-40e1-ac1c-b9ed49bbbbb1",
      "name": "Send a message",
      "webhookId": "c3bc31f0-90dc-4bd2-a006-4f7af052d3d8",
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
    "When clicking ‘Execute workflow’": {
      "main": [
        [
          {
            "node": "Analyze image",
            "type": "main",
            "index": 0
          }
        ]
      ]
    },
    "Analyze image": {
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
  "versionId": "696ec0e3-1fd5-4afc-af4e-1993626c1a67",
  "meta": {
    "templateCredsSetupCompleted": true,
    "instanceId": "45cdfe5d33c15ac09fe745eed18ba8431c804bbc71dfc7e4a62ca65ad47117cb"
  },
  "id": "s517pz2HuHxwoM6Y",
  "tags": []
}
```
