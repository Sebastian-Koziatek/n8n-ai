```json
{
  "name": "9. PDF converter",
  "nodes": [
    {
      "parameters": {},
      "type": "n8n-nodes-base.manualTrigger",
      "typeVersion": 1,
      "position": [
        0,
        0
      ],
      "id": "fc3ec84e-ec69-4f4c-9262-983f6c1052a4",
      "name": "When clicking ‘Execute workflow’"
    },
    {
      "parameters": {
        "operation": "download",
        "fileId": {
          "__rl": true,
          "value": "1oN87c0AbjrzzaQPIQh4EUx4TJ1fuT_Mt",
          "mode": "list",
          "cachedResultName": "New Dokument tekstowy (4).txt",
          "cachedResultUrl": "https://drive.google.com/file/d/1oN87c0AbjrzzaQPIQh4EUx4TJ1fuT_Mt/view?usp=drivesdk"
        },
        "options": {}
      },
      "type": "n8n-nodes-base.googleDrive",
      "typeVersion": 3,
      "position": [
        208,
        0
      ],
      "id": "c7a06230-76bb-4912-bc46-a5f00c818c33",
      "name": "Download file",
      "credentials": {
        "googleDriveOAuth2Api": {
          "id": "LVVZPMTrms8ndXUS",
          "name": "Google Drive account"
        }
      }
    },
    {
      "parameters": {
        "operation": "text",
        "options": {}
      },
      "type": "n8n-nodes-base.extractFromFile",
      "typeVersion": 1,
      "position": [
        416,
        0
      ],
      "id": "d499b858-39d8-410e-98af-16626f589e19",
      "name": "Extract from File"
    },
    {
      "parameters": {
        "options": {}
      },
      "type": "@n8n/n8n-nodes-langchain.lmChatGoogleGemini",
      "typeVersion": 1,
      "position": [
        528,
        272
      ],
      "id": "03cf1767-0861-4290-9da6-3ee8555d3cf0",
      "name": "Google Gemini Chat Model",
      "credentials": {
        "googlePalmApi": {
          "id": "8hPs0K48wbXONggV",
          "name": "Google Gemini(PaLM) Api account 2"
        }
      }
    },
    {
      "parameters": {
        "promptType": "define",
        "text": "=Przenalizuj czym sa te dane i napisz podsumowanie \n\n{{ $json.data }}",
        "options": {}
      },
      "type": "@n8n/n8n-nodes-langchain.agent",
      "typeVersion": 2.2,
      "position": [
        624,
        0
      ],
      "id": "38a23765-482c-45c4-8869-b4f6a63606ab",
      "name": "AI Agent"
    }
  ],
  "pinData": {},
  "connections": {
    "When clicking ‘Execute workflow’": {
      "main": [
        [
          {
            "node": "Download file",
            "type": "main",
            "index": 0
          }
        ]
      ]
    },
    "Download file": {
      "main": [
        [
          {
            "node": "Extract from File",
            "type": "main",
            "index": 0
          }
        ]
      ]
    },
    "Extract from File": {
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
  "versionId": "8c14c4a9-8bfa-411a-a80f-0816ffbaa235",
  "meta": {
    "templateCredsSetupCompleted": true,
    "instanceId": "45cdfe5d33c15ac09fe745eed18ba8431c804bbc71dfc7e4a62ca65ad47117cb"
  },
  "id": "nN6NIBAYkhzmHvqk",
  "tags": []
}

```