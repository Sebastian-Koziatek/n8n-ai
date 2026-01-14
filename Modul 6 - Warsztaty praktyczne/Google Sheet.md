```json
{
  "name": "3. Sheet",
  "nodes": [
    {
      "parameters": {},
      "type": "n8n-nodes-base.manualTrigger",
      "typeVersion": 1,
      "position": [
        0,
        0
      ],
      "id": "42ccdd01-a071-4b77-93dc-b849f4d43a33",
      "name": "When clicking ‘Execute workflow’"
    },
    {
      "parameters": {
        "documentId": {
          "__rl": true,
          "value": "1D7vzFzdgzuc_VPTu_Lzlaf19-b2P8bQvUimN9xcAnmo",
          "mode": "list",
          "cachedResultName": "n8n-szkolenie",
          "cachedResultUrl": "https://docs.google.com/spreadsheets/d/1D7vzFzdgzuc_VPTu_Lzlaf19-b2P8bQvUimN9xcAnmo/edit?usp=drivesdk"
        },
        "sheetName": {
          "__rl": true,
          "value": 2032561876,
          "mode": "list",
          "cachedResultName": "Klienci",
          "cachedResultUrl": "https://docs.google.com/spreadsheets/d/1D7vzFzdgzuc_VPTu_Lzlaf19-b2P8bQvUimN9xcAnmo/edit#gid=2032561876"
        },
        "options": {}
      },
      "type": "n8n-nodes-base.googleSheets",
      "typeVersion": 4.7,
      "position": [
        208,
        0
      ],
      "id": "9edecfb4-cf22-4d93-bd65-02ca65a59dc8",
      "name": "Get row(s) in sheet",
      "credentials": {
        "googleSheetsOAuth2Api": {
          "id": "Penjuu1nZdxL99hn",
          "name": "Google Sheets account"
        }
      }
    },
    {
      "parameters": {
        "promptType": "define",
        "text": "=Dane wejściowe znajdują się w polu \"data\". Jest to lista obiektów JSON.\n\nPrzeanalizuj je i zwróć wynik WYŁĄCZNIE jako poprawny JSON w dokładnie takim formacie:\n\n{\n\"liczba_klientow\": liczba,\n\"laczny_mrr\": liczba,\n\"sredni_mrr\": liczba,\n\"sredni_nps\": liczba,\n\"top5\": [\"tekst\", \"tekst\", \"tekst\", \"tekst\", \"tekst\"],\n\"wysokie_ryzyko\": [\"tekst\", \"tekst\"],\n\"rekomendacje\": \"tekst\"\n}\n\nZasady:\n\n* Zawsze zwracaj tylko JSON, bez żadnych wstępów, komentarzy ani opisu.\n* top5 to lista 5 pozycji uporządkowanych malejąco po MRR.\n* wysokie_ryzyko: tylko elementy, które faktycznie spełniają warunki ryzyka.\n* rekomendacje: krótki opis 2-4 zdań.\n\nDane:\n{{ JSON.stringify($json.data, null, 2) }}\n",
        "options": {}
      },
      "type": "@n8n/n8n-nodes-langchain.agent",
      "typeVersion": 2.2,
      "position": [
        688,
        0
      ],
      "id": "a82bf4de-88e6-481b-a4f1-12c0e72a619e",
      "name": "AI Agent"
    },
    {
      "parameters": {
        "model": {
          "__rl": true,
          "value": "gpt-4.1-nano",
          "mode": "list",
          "cachedResultName": "gpt-4.1-nano"
        },
        "options": {}
      },
      "type": "@n8n/n8n-nodes-langchain.lmChatOpenAi",
      "typeVersion": 1.2,
      "position": [
        528,
        224
      ],
      "id": "f358af4a-df19-4765-a7b0-13773ea02673",
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
        "aggregate": "aggregateAllItemData",
        "options": {}
      },
      "type": "n8n-nodes-base.aggregate",
      "typeVersion": 1,
      "position": [
        416,
        0
      ],
      "id": "18aa3516-8029-4692-9088-f31efdb56c6e",
      "name": "Aggregate"
    },
    {
      "parameters": {
        "sendTo": "sebastian.koziatek@sadmin.pl",
        "subject": "Raport google sheet",
        "message": "=<div style=\"font-family: Arial, sans-serif; font-size: 14px; line-height: 1.6; color: #333;\">\n  \n  <h2 style=\"color:#2a4b8d;\">Raport z Google Sheets – Klienci</h2>\n\n  <h3>1. Podsumowanie ogólne</h3>\n  <p>\n    <strong>Liczba klientów:</strong>\n    {{ JSON.parse($json.output.replace('json\\n', '')).liczba_klientow }}<br>\n    <strong>Łączny MRR:</strong>\n    {{ JSON.parse($json.output.replace('json\\n', '')).laczny_mrr }} EUR<br>\n    <strong>Średni MRR:</strong>\n    {{ JSON.parse($json.output.replace('json\\n', '')).sredni_mrr }} EUR<br>\n    <strong>Średni NPS:</strong>\n    {{ JSON.parse($json.output.replace('json\\n', '')).sredni_nps }}\n  </p>\n\n  <h3>2. TOP 5 klientów (MRR)</h3>\n  <ul>\n    {{ JSON.parse($json.output.replace('json\\n', '')).top5\n        .map(e => \"<li>\" + e + \"</li>\")\n        .join(\"\") }}\n  </ul>\n\n  <h3>3. Klienci wysokiego ryzyka</h3>\n  <div style=\"background:#fff7f7; padding:10px; border-left:4px solid #d9534f;\">\n    {{\n      (d => d.wysokie_ryzyko.length > 0\n        ? d.wysokie_ryzyko.join(\"<br>\")\n        : \"Brak klientów wysokiego ryzyka\"\n      )(JSON.parse($json.output.replace('json\\n', '')))\n    }}\n  </div>\n\n  <h3>4. Rekomendacje ogólne</h3>\n  <div style=\"background:#f4f7ff; padding:10px; border-left:4px solid #337ab7;\">\n    {{ JSON.parse($json.output.replace('json\\n', '')).rekomendacje }}\n  </div>\n\n  <br>\n  <p style=\"font-size:12px; color:#777;\">Automatyczny raport wygenerowany przez n8n + OpenAI.</p>\n\n</div>\n",
        "options": {}
      },
      "type": "n8n-nodes-base.gmail",
      "typeVersion": 2.1,
      "position": [
        1040,
        0
      ],
      "id": "44e83466-d2f6-47f1-8a94-a803dbd1f74e",
      "name": "Send a message",
      "webhookId": "686afb0b-b975-4629-abdb-0482155aa710",
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
            "node": "Get row(s) in sheet",
            "type": "main",
            "index": 0
          }
        ]
      ]
    },
    "Get row(s) in sheet": {
      "main": [
        [
          {
            "node": "Aggregate",
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
    },
    "Aggregate": {
      "main": [
        [
          {
            "node": "AI Agent",
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
  "versionId": "3a1a1be3-c6ec-4987-8ce6-51d3c14aaef2",
  "meta": {
    "templateCredsSetupCompleted": true,
    "instanceId": "45cdfe5d33c15ac09fe745eed18ba8431c804bbc71dfc7e4a62ca65ad47117cb"
  },
  "id": "66Q1IWuhIAO53gIk",
  "tags": []
}
```