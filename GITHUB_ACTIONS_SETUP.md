# GitHub Actions CI/CD Setup for Railway Deployment

## Overview
This project is configured with GitHub Actions for automated testing and deployment to Railway. The workflow automatically runs tests and deploys to Railway when code is pushed to the main branch.

## Workflow File Location
✅ **Confirmed**: The workflow file is located at:
```
/c:/Users/wolf/Desktop/repairmybike/backend_rmb/.github/workflows/deploy.yml
```

## Required GitHub Secrets

You need to set up the following secrets in your GitHub repository:

### 1. RAILWAY_TOKEN
- **Description**: Your Railway authentication token
- **How to get**: 
  1. Go to [Railway Dashboard](https://railway.app/dashboard)
  2. Click on your profile → Account Settings
  3. Go to "Tokens" tab
  4. Create a new token with appropriate permissions

### 2. RAILWAY_PROJECT_ID
- **Description**: Your Railway project ID
- **How to get**: 
  1. Go to your Railway project dashboard
  2. Click on Settings
  3. Copy the Project ID from the General tab

### 3. RAILWAY_SERVICE_ID
- **Description**: Your Railway service ID (for the Django backend)
- **How to get**: 
  1. In your Railway project, click on your Django service
  2. Go to Settings
  3. Copy the Service ID

## Workflow Features

### 🧪 Testing Job
- **Triggers**: On push to `main`/`develop` branches and PRs to `main`
- **Database**: Uses PostgreSQL 15 service for testing
- **Steps**:
  - Python 3.11 setup
  - Dependency caching
  - Environment variable setup (including Razorpay and Staff API keys)
  - Django system checks
  - Database migrations
  - Test execution
  - Static file collection

### 🚀 Deployment Job
- **Triggers**: Only on push to `main` branch (not PRs)
- **Dependencies**: Requires testing job to pass
- **Steps**:
  - Railway CLI installation
  - Project linking and deployment
  - Database migrations on Railway

### 📢 Notification Job
- **Purpose**: Reports deployment status
- **Runs**: Always (even if previous jobs fail)

## Environment Variables

### Fixed Issues ✅
The following environment variables are now properly configured to prevent deployment failures:

```bash
# Required for Django
SECRET_KEY=test-secret-key-for-github-actions
DEBUG=True
ALLOWED_HOSTS=localhost,127.0.0.1

# Database (for testing)
DB_NAME=test_db
DB_USER=postgres
DB_PASSWORD=postgres
DB_HOST=localhost
DB_PORT=5432

# Payment Gateway (with defaults to prevent errors)
RAZORPAY_KEY_ID=
RAZORPAY_KEY_SECRET=
RAZORPAY_ENABLED=False

# Staff API (with default for testing)
STAFF_API_KEY=test-staff-api-key
```

## Local Environment Setup

### .env File Structure
Your local `.env` file should contain:

```bash
SECRET_KEY='your-secret-key'
DEBUG=True
ALLOWED_HOSTS=localhost,127.0.0.1,0.0.0.0

# Database Configuration - Railway PostgreSQL (for production)
DATABASE_URL=postgresql://username:password@host:port/database

# Local Database Configuration (for development)
DB_NAME=your_local_db
DB_USER=postgres
DB_PASSWORD=your_password
DB_HOST=localhost
DB_PORT=5432

# CORS Configuration
CORS_ALLOWED_ORIGINS=http://localhost:3000,http://127.0.0.1:3000

# Redis
REDIS_HOST=localhost
REDIS_PORT=6379
REDIS_DB=0

# Razorpay
RAZORPAY_KEY_ID=your-razorpay-key-id
RAZORPAY_KEY_SECRET=your-razorpay-key-secret
RAZORPAY_ENABLED=False

# Staff API Key
STAFF_API_KEY=your-staff-api-key-here
```

## Deployment Process

### Automatic Deployment
1. Push code to `main` branch
2. GitHub Actions automatically:
   - Runs all tests
   - Deploys to Railway (if tests pass)
   - Runs database migrations
   - Reports status

### Manual Deployment
If needed, you can still deploy manually:
```bash
railway login
railway link your-project-id
railway up --service your-service-id
```

## Railway Environment Setup

### Required Railway Environment Variables
Set these in your Railway service environment:

```bash
# Django
SECRET_KEY=your-production-secret-key
DEBUG=False
ALLOWED_HOSTS=your-railway-domain.railway.app

# Database (automatically provided by Railway)
DATABASE_URL=postgresql://... (auto-generated)

# Payment Gateway
RAZORPAY_KEY_ID=your-actual-razorpay-key
RAZORPAY_KEY_SECRET=your-actual-razorpay-secret
RAZORPAY_ENABLED=True  # Enable when ready

# Staff API
STAFF_API_KEY=your-production-staff-api-key

# CORS (add your frontend domains)
CORS_ALLOWED_ORIGINS=https://your-frontend.com,https://your-app.com
```

## Monitoring and Troubleshooting

### GitHub Actions Logs
- Check the "Actions" tab in your GitHub repository
- Review logs for each job (test, deploy, notify)
- Common issues are usually in the test phase

### Railway Logs
- Check Railway dashboard for deployment logs
- Monitor application logs for runtime issues

### Common Issues and Solutions

1. **UndefinedValueError**: ✅ **Fixed** - All environment variables now have defaults
2. **Database Connection**: Ensure `DATABASE_URL` is set in Railway
3. **Static Files**: Handled automatically by `collectstatic` in Dockerfile
4. **Migrations**: Run automatically during deployment

## Security Best Practices

1. **Never commit secrets** to the repository
2. **Use GitHub Secrets** for sensitive data
3. **Rotate tokens** regularly
4. **Use different keys** for development and production
5. **Enable HTTPS** in production (set `DEBUG=False`)

## Next Steps

1. ✅ Set up GitHub Secrets (RAILWAY_TOKEN, RAILWAY_PROJECT_ID, RAILWAY_SERVICE_ID)
2. ✅ Push code to GitHub main branch
3. ✅ Monitor GitHub Actions workflow
4. ✅ Verify deployment on Railway
5. Configure production environment variables in Railway
6. Set up custom domain (optional)
7. Enable SSL/HTTPS in production

## Status: Ready for Deployment ✅

The GitHub Actions workflow is now properly configured and ready for use. All environment variable issues have been resolved, and the workflow will handle both testing and deployment automatically.