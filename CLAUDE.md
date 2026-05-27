# SoulArk AI — quiz.soulark.ru

Лендинг с квизом на GitHub Pages. Один файл: `index.html`.

## Архитектура

- **React 18 + htm** (не Babel, не JSX). Шаблоны пишем через `` html`...` ``
- Все три скрипта (React, ReactDOM, htm) — в конце `<body>`, без `defer`
- Inline-скрипт тоже в конце body — порядок выполнения гарантирован
- Динамические значения в htm: `${}`, не `{}`; атрибуты: `onClick=${fn}`, `style=${{color:"red"}}`

## Производительность

- Babel Standalone убран — был главным тормозом (900KB, блокировал рендер)
- Фото: `loading="lazy"` на всех `<img>`
- WebP: `myphoto2.webp` (мобильный аватар), десктопное фото пока JPG (WebP оказался тяжелее)

## Изображения

- `assets/myphoto2.jpg` / `myphoto2.webp` — аватар Александра (мобиль, тег-стрип)
- `assets/photo-fe0bbc87-....jpg` — фото Александра для десктопа (hero)
- `assets/photo-a3a17098-....jpg` — фото Павла (не используется, A/B тест отключён)

## Ключевые интеграции

- **Google Sheets**: `SHEET_URL` — Google Apps Script webhook, POST JSON
- **Yandex Metrica**: ID `109371472`, цель `quiz_submit`
- **Telegram**: уведомления через бота, канал `@SoulArkAI`

## CSS

- Мобильная версия: `@media (max-width: 719px)`
- Десктоп: `@media (min-width: 720px)`
- Цвет акцента: `--color-accent: #FF8C42` (оранжевый)
- Русский текст в JSX/htm: unicode-эскейпы `\uXXXX` или Python-замена через `rb`-режим

## Деплой

Push в `main` → GitHub Actions (`pages.yml`) → GitHub Pages → `quiz.soulark.ru`
