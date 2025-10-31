# Railway Environment Variables Setup

## Required Environment Variables for Railway Deployment

### Database Configuration
Railway will automatically provide these when you add a PostgreSQL database:
- `DATABASE_URL` - Automatically set by Railway PostgreSQL service

### Django Configuration
Set these in Railway dashboard or via CLI:

```bash
# Core Django Settings
railway variables set SECRET_KEY="your-super-secret-key-minimum-50-characters-long"
railway variables set DEBUG="False"
railway variables set DJANGO_SETTINGS_MODULE="repairmybike.settings"
railway variables set PYTHONPATH="/app"
railway variables set PORT="8000"

# Allowed Hosts (replace with your Railway domain)
railway variables set ALLOWED_HOSTS="your-app.railway.app,localhost,127.0.0.1"

# CORS Configuration (replace with your frontend domain)
railway variables set CORS_ALLOWED_ORIGINS="https://your-frontend.com,http://localhost:3000"

# Descope Authentication
railway variables set DESCOPE_PROJECT_ID="your-descope-project-id"
railway variables set DESCOPE_MANAGEMENT_KEY="your-descope-management-key"

# Razorpay Payment Gateway (optional)
railway variables set RAZORPAY_KEY_ID="your-razorpay-key-id"
railway variables set RAZORPAY_KEY_SECRET="your-razorpay-key-secret"
railway variables set RAZORPAY_ENABLED="True"

# Staff API Key
railway variables set STAFF_API_KEY="your-staff-api-key"

# Redis Configuration (if using Redis service)
railway variables set REDIS_HOST="redis-service-host"
railway variables set REDIS_PORT="6379"
railway variables set REDIS_DB="0"
```

## GitHub Secrets Required

Set these in your GitHub repository settings > Secrets and variables > Actions:

- `RAILWAY_TOKEN` - Your Railway API token
- `RAILWAY_PROJECT_ID` - Your Railway project ID

## Getting Railway Credentials

1. **Railway Token:**
   ```bash
   railway login
   railway whoami --token
   ```

2. **Project ID:**
   ```bash
   railway status
   ```

## Database Setup

1. Add PostgreSQL service in Railway dashboard
2. The `DATABASE_URL` will be automatically set
3. Migrations will run automatically during deployment

## Deployment Process

1. Push to main branch
2. GitHub Actions will run tests
3. If tests pass, deploy to Railway
4. Railway will build Docker image
5. Run deployment script (migrations, static files)
6. Health check will verify deployment

## Troubleshooting

- Check Railway logs: `railway logs`
- Check deployment status: `railway status`
- Test health endpoint: `curl https://your-app.railway.app/health/`