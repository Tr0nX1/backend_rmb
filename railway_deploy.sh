#!/bin/bash

# Railway deployment script for Django application
set -e

echo "🚀 Starting Railway deployment..."

# Wait for database to be ready
echo "⏳ Waiting for database connection..."
python -c "
import os
import time
import psycopg2
from urllib.parse import urlparse

max_retries = 30
retry_count = 0

while retry_count < max_retries:
    try:
        if 'DATABASE_URL' in os.environ:
            url = urlparse(os.environ['DATABASE_URL'])
            conn = psycopg2.connect(
                host=url.hostname,
                port=url.port,
                user=url.username,
                password=url.password,
                database=url.path[1:]
            )
            conn.close()
            print('Database connection successful!')
            break
        else:
            print('DATABASE_URL not found, skipping database check')
            break
    except Exception as e:
        retry_count += 1
        print(f'Database connection attempt {retry_count}/{max_retries} failed: {e}')
        if retry_count < max_retries:
            time.sleep(2)
        else:
            print('Failed to connect to database after maximum retries')
            exit(1)
"

# Run Django management commands
echo "🔧 Running Django management commands..."

# Check for any issues
python manage.py check --deploy

# Create and run migrations
echo "📊 Running database migrations..."
python manage.py makemigrations --noinput
python manage.py migrate --noinput

# Collect static files
echo "📁 Collecting static files..."
python manage.py collectstatic --noinput --clear

# Create superuser if it doesn't exist (optional)
echo "👤 Creating superuser if needed..."
python manage.py shell -c "
from django.contrib.auth import get_user_model
User = get_user_model()
if not User.objects.filter(is_superuser=True).exists():
    print('No superuser found, you may want to create one manually')
else:
    print('Superuser already exists')
" || true

echo "✅ Railway deployment completed successfully!"

# Start the application
echo "🌟 Starting Gunicorn server..."
exec gunicorn --bind 0.0.0.0:$PORT --workers 4 --worker-class sync --worker-connections 1000 --max-requests 1000 --max-requests-jitter 100 --timeout 30 --keep-alive 2 --access-logfile - --error-logfile - repairmybike.wsgi:application