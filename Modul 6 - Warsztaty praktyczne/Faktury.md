# Faktury

```json
{
  "name": "10. Faktury",
  "nodes": [
    {
      "parameters": {
        "pollTimes": {
          "item": [
            {
              "mode": "everyMinute"
            }
          ]
        },
        "triggerOn": "specificFolder",
        "folderToWatch": {
          "__rl": true,
          "value": "1Z7kHbii8ehsaAWTkR9Wdtz3xGjR_Awxk",
          "mode": "list",
          "cachedResultName": "Faktury",
          "cachedResultUrl": "https://drive.google.com/drive/folders/1Z7kHbii8ehsaAWTkR9Wdtz3xGjR_Awxk"
        },
        "event": "fileCreated",
        "options": {}
      },
      "type": "n8n-nodes-base.googleDriveTrigger",
      "typeVersion": 1,
      "position": [
        0,
        0
      ],
      "id": "70ff4ea6-f74e-40e6-869e-f200f2e0c32a",
      "name": "Google Drive Trigger",
      "credentials": {
        "googleDriveOAuth2Api": {
          "id": "pEqWVV1KcW6nOQPy",
          "name": "Google Drive account"
        }
      }
    },
    {
      "parameters": {
        "operation": "download",
        "fileId": {
          "__rl": true,
          "value": "={{$json[\"id\"]}}",
          "mode": "id"
        },
        "options": {}
      },
      "type": "n8n-nodes-base.googleDrive",
      "typeVersion": 3,
      "position": [
        208,
        0
      ],
      "id": "ba3716b0-159b-4ed5-9591-6508010b0dc4",
      "name": "Download file",
      "credentials": {
        "googleDriveOAuth2Api": {
          "id": "pEqWVV1KcW6nOQPy",
          "name": "Google Drive account"
        }
      }
    },
    {
      "parameters": {
        "resource": "document",
        "modelId": {
          "__rl": true,
          "value": "models/gemini-2.5-flash",
          "mode": "list",
          "cachedResultName": "models/gemini-2.5-flash"
        },
        "text": "Przeanalizuj fakturę i zwróć jej treść oraz kluczowe informacje:\nnumer faktury, data wystawienia, sprzedawca, NIP sprzedawcy,\nkwota brutto, waluta oraz informację czy faktura jest opłacona.",
        "inputType": "binary",
        "options": {}
      },
      "type": "@n8n/n8n-nodes-langchain.googleGemini",
      "typeVersion": 1,
      "position": [
        448,
        0
      ],
      "id": "8b006922-e55f-4e55-805e-833fd5bef51d",
      "name": "Analyze document",
      "credentials": {
        "googlePalmApi": {
          "id": "4uHZO99YEmZNtmuG",
          "name": "Google Gemini(PaLM) Api account"
        }
      }
    },
    {
      "parameters": {
        "text": "={{ $json.content.parts[0].text }}",
        "attributes": {
          "attributes": [
            {
              "name": "Numer faktury",
              "description": "Numer faktury"
            },
            {
              "name": "data_wystawienia",
              "description": "Data wystawienia faktury w formacie YYYY-MM-DD"
            },
            {
              "name": "sprzedawca",
              "description": "Pełna nazwa sprzedawcy z faktury"
            },
            {
              "name": "nip_sprzedawcy",
              "description": "Numer NIP sprzedawcy z faktury"
            },
            {
              "name": "kwota_brutto",
              "description": "Łączna kwota brutto do zapłaty z faktury"
            },
            {
              "name": "waluta",
              "description": "Waluta faktury, np. PLN, EUR"
            },
            {
              "name": "status",
              "description": "Status faktury: - Opłacona jeśli w treści jest informacja o zapłacie (np. opłacona, zapłacono, paid) - Do zapłaty jeśli brak informacji o zapłacie - Nieznany jeśli nie da się ustalić"
            }
          ]
        },
        "options": {}
      },
      "type": "@n8n/n8n-nodes-langchain.informationExtractor",
      "typeVersion": 1.2,
      "position": [
        656,
        0
      ],
      "id": "c8031920-892c-4519-965f-e88a0da12a26",
      "name": "Information Extractor"
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
        592,
        208
      ],
      "id": "52ffc742-5517-4189-b0e8-53fc260122c9",
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
        "operation": "append",
        "documentId": {
          "__rl": true,
          "value": "1zzq3of9dhVNtWL0Hmib_Nbpdp6Len549HyrdTa5qC-Q",
          "mode": "list",
          "cachedResultName": "Faktury",
          "cachedResultUrl": "https://docs.google.com/spreadsheets/d/1zzq3of9dhVNtWL0Hmib_Nbpdp6Len549HyrdTa5qC-Q/edit?usp=drivesdk"
        },
        "sheetName": {
          "__rl": true,
          "value": "gid=0",
          "mode": "list",
          "cachedResultName": "Arkusz1",
          "cachedResultUrl": "https://docs.google.com/spreadsheets/d/1zzq3of9dhVNtWL0Hmib_Nbpdp6Len549HyrdTa5qC-Q/edit#gid=0"
        },
        "columns": {
          "mappingMode": "defineBelow",
          "value": {
            "numer_faktury": "={{ $json.output['Numer faktury'] }}",
            "data_wystawienia": "={{ $json.output.data_wystawienia }}",
            "sprzedawca": "={{ $json.output.sprzedawca }}",
            "kwota_brutto": "={{ $json.output.kwota_brutto }}",
            "nip_sprzedawcy": "={{ $json.output.nip_sprzedawcy }}",
            "waluta": "={{ $json.output.waluta }}",
            "status": "={{ $json.output.status }}"
          },
          "matchingColumns": [],
          "schema": [
            {
              "id": "numer_faktury",
              "displayName": "numer_faktury",
              "required": false,
              "defaultMatch": false,
              "display": true,
              "type": "string",
              "canBeUsedToMatch": true
            },
            {
              "id": "data_wystawienia",
              "displayName": "data_wystawienia",
              "required": false,
              "defaultMatch": false,
              "display": true,
              "type": "string",
              "canBeUsedToMatch": true
            },
            {
              "id": "sprzedawca",
              "displayName": "sprzedawca",
              "required": false,
              "defaultMatch": false,
              "display": true,
              "type": "string",
              "canBeUsedToMatch": true
            },
            {
              "id": "nip_sprzedawcy",
              "displayName": "nip_sprzedawcy",
              "required": false,
              "defaultMatch": false,
              "display": true,
              "type": "string",
              "canBeUsedToMatch": true
            },
            {
              "id": "kwota_brutto",
              "displayName": "kwota_brutto",
              "required": false,
              "defaultMatch": false,
              "display": true,
              "type": "string",
              "canBeUsedToMatch": true
            },
            {
              "id": "waluta",
              "displayName": "waluta",
              "required": false,
              "defaultMatch": false,
              "display": true,
              "type": "string",
              "canBeUsedToMatch": true
            },
            {
              "id": "status",
              "displayName": "status",
              "required": false,
              "defaultMatch": false,
              "display": true,
              "type": "string",
              "canBeUsedToMatch": true
            }
          ],
          "attemptToConvertTypes": false,
          "convertFieldsToString": false
        },
        "options": {}
      },
      "type": "n8n-nodes-base.googleSheets",
      "typeVersion": 4.7,
      "position": [
        992,
        0
      ],
      "id": "4ca38ff3-d52d-4460-a6dd-9088d8af169d",
      "name": "Append row in sheet",
      "credentials": {
        "googleSheetsOAuth2Api": {
          "id": "Jd2lgIQ9aRIwbgM4",
          "name": "Google Sheets account"
        }
      }
    }
  ],
  "pinData": {},
  "connections": {
    "Google Drive Trigger": {
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
            "node": "Analyze document",
            "type": "main",
            "index": 0
          }
        ]
      ]
    },
    "Analyze document": {
      "main": [
        [
          {
            "node": "Information Extractor",
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
            "node": "Information Extractor",
            "type": "ai_languageModel",
            "index": 0
          }
        ]
      ]
    },
    "Information Extractor": {
      "main": [
        [
          {
            "node": "Append row in sheet",
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
  "versionId": "30d5fc74-80a7-4670-bf91-4690943317e1",
  "meta": {
    "templateCredsSetupCompleted": true,
    "instanceId": "1353456e2ddcdae7487c07e33159c9fe20fa539d7372a5785d975b74e64d953b"
  },
  "id": "17Ekjxct977EtwpZ",
  "tags": []
}
```
