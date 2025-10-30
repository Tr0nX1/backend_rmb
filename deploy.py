#!/usr/bin/env python
"""
Production Deployment Script for RepairMyBike Backend
This script handles all deployment tasks for production environment.
"""

import os
import sys
import subprocess
import secrets
from pathlib import Path

def run_command(command, description):
    """Run a command and handle errors."""
    print(f"🔄 {description}...")
    try:
        result = subprocess.run(command, shell=True, check=True, capture_output=True, text=True)
        print(f"✅ {description} completed successfully")
        return result.stdout
    except subprocess.CalledProcessError as e:
        print(f"❌ {description} failed: {e.stderr}")
        return None

def generate_secret_key():
    """Generate a secure Django secret key."""
    return secrets.token_urlsafe(50)

def check_environment():
    """Check if all required environment variables are set."""
    required_vars = [
        'SECRET_KEY',
        'DATABASE_URL',
        'DESCOPE_PROJECT_ID',
        'DESCOPE_MANAGEMENT_KEY',
        'ALLOWED_HOSTS'
    ]
    
    missing_vars = []
    for var in required_vars:
        if not os.getenv(var):
            missing_vars.append(var)
    
    if missing_vars:
        print(f"❌ Missing environment variables: {', '.join(missing_vars)}")
        print("Please set these variables before deployment.")
        return False
    
    print("✅ All required environment variables are set")
    return True

def collect_static_files():
    """Collect static files for production."""
    return run_command("python manage.py collectstatic --noinput", "Collecting static files")

def run_migrations():
    """Apply database migrations."""
    return run_command("python manage.py migrate", "Applying database migrations")

def create_superuser():
    """Create superuser if it doesn't exist."""
    print("🔄 Checking for superuser...")
    try:
        from django.contrib.auth import get_user_model
        User = get_user_model()
        if not User.objects.filter(is_superuser=True).exists():
            print("Creating superuser...")
            # This would need to be handled differently in production
            print("⚠️  No superuser found. Create one manually after deployment.")
        else:
            print("✅ Superuser already exists")
    except Exception as e:
        print(f"⚠️  Could not check superuser status: {e}")

def run_security_checks():
    """Run Django security checks."""
    return run_command("python manage.py check --deploy", "Running security checks")

def main():
    """Main deployment function."""
    print("🚀 Starting RepairMyBike Backend Deployment")
    print("=" * 50)
    
    # Set Django settings module
    os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'repairmybike.settings')
    
    # Import Django and setup
    import django
    django.setup()
    
    # Check environment variables
    if not check_environment():
        sys.exit(1)
    
    # Run deployment tasks
    tasks = [
        (collect_static_files, "Static files collection"),
        (run_migrations, "Database migrations"),
        (run_security_checks, "Security checks"),
    ]
    
    failed_tasks = []
    for task_func, task_name in tasks:
        result = task_func()
        if result is None:
            failed_tasks.append(task_name)
    
    # Create superuser check
    create_superuser()
    
    # Summary
    print("\n" + "=" * 50)
    if failed_tasks:
        print(f"❌ Deployment completed with {len(failed_tasks)} failed tasks:")
        for task in failed_tasks:
            print(f"   - {task}")
        sys.exit(1)
    else:
        print("✅ Deployment completed successfully!")
        print("\n🎉 RepairMyBike Backend is ready for production!")
        print("\nNext steps:")
        print("1. Set up your production environment variables")
        print("2. Configure your web server (Nginx/Apache)")
        print("3. Set up SSL certificates")
        print("4. Configure monitoring and logging")
        print("5. Set up backup procedures")

if __name__ == "__main__":
    main()