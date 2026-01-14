```json
{
  "name": "6. SSH",
  "nodes": [
    {
      "parameters": {
        "rule": {
          "interval": [
            {}
          ]
        }
      },
      "type": "n8n-nodes-base.scheduleTrigger",
      "typeVersion": 1.2,
      "position": [
        0,
        0
      ],
      "id": "5d35eb0f-9932-4d01-90d4-bdf50cb03ed6",
      "name": "Schedule Trigger"
    },
    {
      "parameters": {
        "command": "systemctl is-active --quiet nginx && echo 1 || echo 0",
        "cwd": "/home/szkolenie"
      },
      "type": "n8n-nodes-base.ssh",
      "typeVersion": 1,
      "position": [
        208,
        0
      ],
      "id": "d9a433b4-7e65-4d58-b8cc-ceaa0056f70b",
      "name": "Execute a command",
      "credentials": {
        "sshPassword": {
          "id": "CBIfFSSTTSSBHlm6",
          "name": "SSH Password account"
        }
      }
    },
    {
      "parameters": {
        "conditions": {
          "options": {
            "caseSensitive": true,
            "leftValue": "",
            "typeValidation": "strict",
            "version": 2
          },
          "conditions": [
            {
              "id": "3ef0a8c3-5fa4-4065-8599-6b7e41a3f649",
              "leftValue": "={{ $json.stdout }}",
              "rightValue": "1",
              "operator": {
                "type": "string",
                "operation": "equals",
                "name": "filter.operator.equals"
              }
            }
          ],
          "combinator": "and"
        },
        "options": {}
      },
      "type": "n8n-nodes-base.if",
      "typeVersion": 2.2,
      "position": [
        416,
        0
      ],
      "id": "85a086e8-55fd-405a-9c7d-eae8bf0d8534",
      "name": "If"
    },
    {
      "parameters": {
        "promptType": "define",
        "text": "=Serwis nginx nie działa na serwerze Alma linux. \n\nNapisz instrukcje jak go wystartować, na  co zwrócić uwagę itd. ",
        "options": {}
      },
      "type": "@n8n/n8n-nodes-langchain.agent",
      "typeVersion": 2.2,
      "position": [
        624,
        96
      ],
      "id": "66b4168e-bbf5-4486-9302-b472b21279a5",
      "name": "AI Agent"
    },
    {
      "parameters": {
        "sendTo": "sebastian.koziatek@sadmin.pl",
        "subject": "Awaria nginx",
        "message": "={{ $json.output }}",
        "options": {}
      },
      "type": "n8n-nodes-base.gmail",
      "typeVersion": 2.1,
      "position": [
        976,
        96
      ],
      "id": "229390fc-d863-42b2-b282-24a0afa5407b",
      "name": "Send a message",
      "webhookId": "7da45599-578e-438e-84cf-22e36540877f",
      "credentials": {
        "gmailOAuth2": {
          "id": "bd6wbOdqWHgE01U1",
          "name": "Gmail account"
        }
      }
    },
    {
      "parameters": {},
      "type": "n8n-nodes-base.noOp",
      "typeVersion": 1,
      "position": [
        688,
        -96
      ],
      "id": "c1889d4b-8f06-4d8c-8787-80dae5431cc1",
      "name": "No Operation, do nothing"
    },
    {
      "parameters": {
        "options": {}
      },
      "type": "@n8n/n8n-nodes-langchain.lmChatGoogleGemini",
      "typeVersion": 1,
      "position": [
        496,
        304
      ],
      "id": "aa1a787e-04ca-4200-8b37-82909d00b426",
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
    "Schedule Trigger": {
      "main": [
        [
          {
            "node": "Execute a command",
            "type": "main",
            "index": 0
          }
        ]
      ]
    },
    "Execute a command": {
      "main": [
        [
          {
            "node": "If",
            "type": "main",
            "index": 0
          }
        ]
      ]
    },
    "If": {
      "main": [
        [
          {
            "node": "No Operation, do nothing",
            "type": "main",
            "index": 0
          }
        ],
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
  "versionId": "6f39aa06-3828-4fc1-ac93-07d3a36cbafc",
  "meta": {
    "templateCredsSetupCompleted": true,
    "instanceId": "45cdfe5d33c15ac09fe745eed18ba8431c804bbc71dfc7e4a62ca65ad47117cb"
  },
  "id": "4PeK16BjIqgWu38C",
  "tags": []
}
```