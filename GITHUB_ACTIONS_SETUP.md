# GitHub Actions CI/CD Setup for Railway Deployment

This document explains how to set up automated deployment to Railway using GitHub Actions and GitHub Secrets.

## Overview

The CI/CD pipeline automatically:
- Runs tests on every push and pull request
- Deploys to Railway when code is pushed to the `main` branch
- Runs database migrations after deployment
- Provides deployment status notifications

## Required GitHub Secrets

You need to add the following secrets to your GitHub repository:

### 1. Railway Configuration Secrets

Go to your GitHub repository → Settings → Secrets and variables → Actions → New repository secret

Add these secrets:

| Secret Name | Description | How to Get |
|-------------|-------------|------------|
| `RAILWAY_TOKEN` | Railway API token for authentication | Railway Dashboard → Account Settings → Tokens → Create New Token |
| `RAILWAY_PROJECT_ID` | Your Railway project ID | Run `railway status` in your project directory |
| `RAILWAY_SERVICE_ID` | Your Railway service ID | Railway Dashboard → Your Project → Service → Settings → Service ID |

### 2. Getting Railway Values

#### Railway Token:
1. Go to [Railway Dashboard](https://railway.com/dashboard)
2. Click on your profile → Account Settings
3. Go to "Tokens" tab
4. Click "Create New Token"
5. Give it a name (e.g., "GitHub Actions")
6. Copy the token and add it as `RAILWAY_TOKEN` secret

#### Railway Project ID:
```bash
cd backend_rmb
railway status
```
Look for the project ID in the output.

#### Railway Service ID:
1. Go to Railway Dashboard
2. Select your project
3. Click on your service
4. Go to Settings tab
5. Copy the Service ID

## Workflow Features

### 🧪 Testing Job
- Sets up Python 3.11 environment
- Installs dependencies with caching
- Runs PostgreSQL service for testing
- Executes Django system checks
- Runs database migrations
- Executes test suite
- Collects static files

### 🚀 Deployment Job
- Only runs on `main` branch pushes
- Installs Railway CLI
- Authenticates with Railway
- Deploys the application
- Runs database migrations on production

### 📊 Notification Job
- Reports deployment status
- Runs after both test and deploy jobs

## Environment Variables

The workflow uses these environment variables during testing:
- `SECRET_KEY`: Test secret key
- `DEBUG`: Set to True for testing
- Database configuration for PostgreSQL test service

Production environment variables are managed through Railway's environment variable system.

## Triggering Deployments

### Automatic Deployment
- Push to `main` branch triggers automatic deployment
- Pull requests to `main` branch run tests only

### Manual Deployment
You can also trigger deployments manually:
1. Go to Actions tab in your GitHub repository
2. Select "Deploy to Railway" workflow
3. Click "Run workflow"
4. Select the branch to deploy

## Railway Environment Setup

Make sure your Railway project has these environment variables set:

### Required Variables:
- `SECRET_KEY`: Django secret key
- `DEBUG`: Set to `False` for production
- `ALLOWED_HOSTS`: Your domain(s)
- `DATABASE_URL`: Automatically provided by Railway PostgreSQL service

### Optional Variables:
- `CORS_ALLOWED_ORIGINS`: Frontend domain(s)
- `RAZORPAY_KEY_ID`: Payment gateway key
- `RAZORPAY_KEY_SECRET`: Payment gateway secret
- `STAFF_API_KEY`: Staff API authentication key

## Monitoring Deployments

### GitHub Actions
- Go to Actions tab in your repository
- Click on any workflow run to see detailed logs
- Check individual job status and logs

### Railway Logs
- Railway Dashboard → Your Project → Service → Deployments
- Click on any deployment to see build and runtime logs

## Troubleshooting

### Common Issues:

1. **Railway Token Invalid**
   - Regenerate token in Railway Dashboard
   - Update `RAILWAY_TOKEN` secret in GitHub

2. **Service ID Not Found**
   - Verify `RAILWAY_SERVICE_ID` in GitHub Secrets
   - Check service exists in Railway Dashboard

3. **Database Migration Errors**
   - Check Railway PostgreSQL service is running
   - Verify `DATABASE_URL` is set correctly in Railway

4. **Build Failures**
   - Check requirements.txt is up to date
   - Verify Dockerfile syntax
   - Check Railway build logs

### Getting Help:
- Check GitHub Actions logs for detailed error messages
- Review Railway deployment logs
- Ensure all required secrets are properly set

## Security Best Practices

1. **Never commit sensitive data**
   - Use `.env.example` for structure reference
   - Keep actual `.env` file in `.gitignore`

2. **Rotate secrets regularly**
   - Update Railway tokens periodically
   - Regenerate API keys as needed

3. **Limit secret access**
   - Only add necessary secrets
   - Use environment-specific secrets when possible

## Next Steps

After setting up the CI/CD pipeline:
1. Test the workflow by pushing to a feature branch
2. Create a pull request to `main` to test the full pipeline
3. Monitor the first deployment carefully
4. Set up monitoring and alerting for production

---

For more information, refer to:
- [Railway Documentation](https://docs.railway.com/)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)