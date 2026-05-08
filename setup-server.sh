#!/bin/bash
# Скрипт первоначальной настройки сервера для soulark.ru
# Запускать один раз: bash setup-server.sh
set -e

echo "=== [1/4] Установка Nginx ==="
apt-get update -q
apt-get install -y nginx rsync

echo "=== [2/4] Создание папки сайта ==="
mkdir -p /var/www/soulark

echo "=== [3/4] Настройка Nginx ==="
cat > /etc/nginx/sites-available/soulark << 'NGINX'
server {
    listen 80;
    server_name _;

    root /var/www/soulark;
    index index.html;

    gzip on;
    gzip_types text/html text/css application/javascript image/png image/jpeg font/woff;

    location / {
        try_files $uri $uri/ =404;
    }
}
NGINX

ln -sf /etc/nginx/sites-available/soulark /etc/nginx/sites-enabled/soulark
rm -f /etc/nginx/sites-enabled/default
nginx -t && systemctl restart nginx

echo "=== [4/4] Генерация SSH-ключа для GitHub Actions ==="
ssh-keygen -t ed25519 -f /root/.ssh/github_deploy -N "" -C "github-actions" -q
cat /root/.ssh/github_deploy.pub >> /root/.ssh/authorized_keys

echo ""
echo "=========================================="
echo "  ГОТОВО. Nginx установлен и запущен."
echo "=========================================="
echo ""
echo "Теперь добавьте в GitHub Settings → Secrets:"
echo ""
echo "  DEPLOY_KEY (содержимое ниже, скопируйте всё целиком):"
echo "----------------------------------------------------------"
cat /root/.ssh/github_deploy
echo "----------------------------------------------------------"
echo ""
echo "  DEPLOY_HOST = 5.188.24.69"
echo "  DEPLOY_USER = root"
echo ""
