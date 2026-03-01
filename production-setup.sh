#!/bin/bash
# Production Setup Script für Raspberry Pi

echo "🚀 Setting up Jonas Website Production..."

# 1. .env.prod erstellen
if [ ! -f .env.prod ]; then
    echo "📝 Creating .env.prod from template..."
    cp .env.example .env.prod
    echo "⚠️  WICHTIG: Fülle .env.prod mit echten Werten!"
    echo "    nano .env.prod"
    exit 1
fi

# 2. Secret Key generieren (Helper)
echo "🔑 Generate SECRET_KEY with:"
echo "    python -c 'from django.core.management.utils import get_random_secret_key; print(get_random_secret_key())'"

# 3. Docker Container starten
echo "🐳 Starting Docker containers..."
docker-compose up -d

# 4. Migrations
echo "📦 Running migrations..."
docker-compose exec web python manage.py migrate

# 5. Static files
echo "📂 Collecting static files..."
docker-compose exec web python manage.py collectstatic --noinput

echo "✅ Production setup complete!"
echo "🌐 Visit: http://localhost"