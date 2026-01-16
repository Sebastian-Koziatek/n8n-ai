# BBC RSS

```json
{
  "name": "11. BBC RSS",
  "nodes": [
    {
      "parameters": {
        "triggerTimes": {
          "item": [
            {
              "hour": 8
            }
          ]
        }
      },
      "id": "65f8e9df-2bd0-40e0-bc2e-e231d60a3d6a",
      "name": "Cron (codziennie 08:00)",
      "type": "n8n-nodes-base.cron",
      "typeVersion": 1,
      "position": [
        0,
        0
      ]
    },
    {
      "parameters": {
        "jsCode": "// Ustaw strefę czasu (IANA)\nconst TZ = 'Europe/Warsaw';\n\n// Helper: YYYY-MM-DD w zadanej strefie czasu\nfunction ymdInTZ(date, timeZone) {\n  const fmt = new Intl.DateTimeFormat('en-CA', {\n    timeZone,\n    year: 'numeric',\n    month: '2-digit',\n    day: '2-digit',\n  });\n  return fmt.format(date); // en-CA daje YYYY-MM-DD\n}\n\nconst todayYmd = ymdInTZ(new Date(), TZ);\n\nconst items = $input.all().map(i => i.json);\n\nconst todays = items.filter(it => {\n  const raw = it.isoDate || it.pubDate;\n  if (!raw) return false;\n\n  const d = new Date(raw); // ISO albo RFC2822 (pubDate) powinno wejść\n  if (Number.isNaN(d.getTime())) return false;\n\n  return ymdInTZ(d, TZ) === todayYmd;\n});\n\n// Budowa maila (HTML)\nconst lines = todays.map((it, idx) => {\n  const title = it.title || '(bez tytulu)';\n  const link = it.link || '';\n  return `${idx + 1}. <a href=\"${link}\">${title}</a>`;\n});\n\nconst subject = `Gazeta.pl – artykuly z dzisiaj (${todayYmd}) – ${todays.length} szt.`;\nconst html = todays.length\n  ? `<p>Lista artykulow z dzisiaj (${todayYmd}):</p><ol><li>${lines.join('</li><li>')}</li></ol>`\n  : `<p>Brak nowych pozycji z dzisiaj (${todayYmd}).</p>`;\n\nreturn [\n  {\n    json: {\n      to: 'TU_WPISZ_ODBIORCE@example.com',\n      subject,\n      html\n    }\n  }\n];\n"
      },
      "id": "7011ef90-1ec7-4d3f-901d-62daeb41c0c5",
      "name": "Code (filtr dzisiaj + email content)",
      "type": "n8n-nodes-base.code",
      "typeVersion": 2,
      "position": [
        528,
        0
      ]
    },
    {
      "parameters": {
        "sendTo": "sebastian.koziatek@sadmin.pl",
        "subject": "=Prasówka dzienna",
        "message": "={{ $json.output }}",
        "options": {}
      },
      "id": "a205028c-b091-4815-b6b1-f4067a42057c",
      "name": "Gmail (send)",
      "type": "n8n-nodes-base.gmail",
      "typeVersion": 2,
      "position": [
        1072,
        0
      ],
      "webhookId": "ad9e24d6-2fa3-494e-8321-f7111371e756",
      "credentials": {
        "gmailOAuth2": {
          "id": "0Wj0gH1mIojguqO2",
          "name": "Gmail account"
        }
      }
    },
    {
      "parameters": {
        "url": "https://feeds.bbci.co.uk/news/rss.xml",
        "options": {}
      },
      "id": "84c6de18-fe54-4118-a008-dc57db5a605d",
      "name": "RSS Read (BBC)",
      "type": "n8n-nodes-base.rssFeedRead",
      "typeVersion": 1,
      "position": [
        272,
        0
      ]
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
        608,
        272
      ],
      "id": "6ec98754-d0be-494d-a3db-184765ab4cb2",
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
        "promptType": "define",
        "text": "=jesteś analitykiem prasy i twoim zadaniem jest przesyłanie mi informacj o nowych tekstach na stronie mojego RSS.\n\nPrzanalizuj wyniki z mojego czystnika RSS:\n{{ $json.html }}\n\nPowiedz mi jakie artykuły warto przeczytać w kontekście zdrowia i służby zdrowia.\n\nPrzygotuj mi w formacie HTML gotową do wysłania przez gmail z ładną odpowiedz z polecanym tematem i streszczeniem go w języku polskim.\n\nNie pisz świetnie, bądź profesjonalny, styl formalny. \nOdbiorcą są pracownicy w firmie do których prześlę te wiadomości. \n\nNie pisz instrukcji dodatkowych, nie dodawaj nic od siebie przygotuj tylko gotowego maila ze streszczeniem, nie odpisuj nic wiecej, podaj tylko wiadomosc HTML. ",
        "options": {}
      },
      "type": "@n8n/n8n-nodes-langchain.agent",
      "typeVersion": 3,
      "position": [
        736,
        0
      ],
      "id": "7fda2e1a-a70b-4f58-bbc2-d9edd5727e43",
      "name": "AI Agent"
    }
  ],
  "pinData": {},
  "connections": {
    "Cron (codziennie 08:00)": {
      "main": [
        [
          {
            "node": "RSS Read (BBC)",
            "type": "main",
            "index": 0
          }
        ]
      ]
    },
    "RSS Read (BBC)": {
      "main": [
        [
          {
            "node": "Code (filtr dzisiaj + email content)",
            "type": "main",
            "index": 0
          }
        ]
      ]
    },
    "Code (filtr dzisiaj + email content)": {
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
    "AI Agent": {
      "main": [
        [
          {
            "node": "Gmail (send)",
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
  "versionId": "44b3b2b1-dbe2-4446-a774-e1182fd62a44",
  "meta": {
    "templateCredsSetupCompleted": true,
    "instanceId": "1353456e2ddcdae7487c07e33159c9fe20fa539d7372a5785d975b74e64d953b"
  },
  "id": "sjA8J2P6N4VP9idI",
  "tags": []
}
```
