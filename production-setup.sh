#!/bin/bash
# Production Setup Script für Raspberry Pi

set -e

echo "🚀 Setting up Jonas Website Production..."

if command -v docker-compose >/dev/null 2>&1; then
    COMPOSE_CMD="docker-compose"
elif docker compose version >/dev/null 2>&1; then
    COMPOSE_CMD="docker compose"
else
    echo "❌ Docker Compose wurde nicht gefunden."
    echo "   Installiere Docker + Compose und versuche es erneut."
    exit 1
fi

# 1. .env.prod erstellen
if [ ! -f .env.prod ]; then
    if [ -f .env.prod.example ]; then
        echo "📝 Creating .env.prod from .env.prod.example..."
        cp .env.prod.example .env.prod
    elif [ -f .env.example ]; then
        echo "📝 Creating .env.prod from .env.example..."
        cp .env.example .env.prod
    else
        echo "❌ Keine Vorlage gefunden (.env.prod.example oder .env.example)."
        exit 1
    fi
    echo "⚠️  WICHTIG: .env.prod wurde erstellt, ist aber noch nicht konfiguriert."
    echo "    Bitte jetzt ausfüllen und Script danach erneut starten:"
    echo "    nano .env.prod"
    exit 1
fi

# 2. Secret Key generieren (Helper)
echo "🔑 Generate SECRET_KEY with:"
echo "    python -c 'from django.core.management.utils import get_random_secret_key; print(get_random_secret_key())'"

# 3. Docker Container starten
echo "🐳 Starting Docker containers..."
$COMPOSE_CMD up -d

# 4. Migrations
echo "📦 Running migrations..."
$COMPOSE_CMD exec web python manage.py migrate

# 5. Static files
echo "📂 Collecting static files..."
$COMPOSE_CMD exec web python manage.py collectstatic --noinput

echo "✅ Production setup complete!"
echo "🌐 Visit: http://localhost"
echo "📊 Container status:"
$COMPOSE_CMD ps