# Russian Technical Readability Basics

Use this profile when a team wants Russian technical prose that is direct,
precise, and easy to follow. This profile is inspired by controlled-language
principles but is adapted for Russian. Do not describe it as STE100.

## Core Rules

- Use direct verbs: `откройте`, `задайте`, `проверьте`, `запустите`.
- Replace bureaucratic noun phrases with actions.
- Keep one action or one point per sentence.
- Put the condition before the action.
- Prefer active voice when it clarifies who acts or what the system does.
- Keep one term for one concept across the document.
- Split long noun chains with prepositions or shorter sentences.
- Replace vague wording with concrete files, commands, fields, values, and results.
- Avoid empty formulas such as `в рамках`, `осуществить`, `произвести`, `данный`, `соответствующий`, `при необходимости` when the condition can be named.

## Good And Bad Pairs

### Pair: Bureaucratic setup language

Bad: Для осуществления установки пакета необходимо выполнить команду `npm install`.

Good: Чтобы установить пакет, выполните команду `npm install`.

### Pair: Vague proxy condition

Bad: При наличии необходимости использования прокси-сервера следует произвести соответствующую настройку переменных окружения.

Good: Если вы работаете через прокси, задайте переменные `HTTP_PROXY` и `HTTPS_PROXY`.

### Pair: Noun-heavy startup description

Bad: После выполнения операции создания конфигурационного файла может быть произведен запуск сервиса.

Good: После создания файла `config.yml` запустите сервис.

### Pair: Bureaucratic troubleshooting

Bad: В случае возникновения ситуации, связанной с невозможностью подключения к базе данных, рекомендуется осуществить проверку корректности учетных данных.

Good: Если приложение не подключается к базе данных, проверьте логин, пароль и адрес хоста.

### Pair: Empty feature description

Bad: Данный параметр предоставляет возможность выполнения более гибкой конфигурации поведения приложения в рамках различных сценариев эксплуатации.

Good: Параметр `timeout` задает время ожидания ответа в миллисекундах.

### Pair: Hidden condition after action

Bad: Перезапустите сервис при изменении порта в конфигурации.

Good: Если вы изменили порт в конфигурации, перезапустите сервис.
