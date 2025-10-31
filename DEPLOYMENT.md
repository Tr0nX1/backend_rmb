# 🚀 RepairMyBike Backend - Production Deployment Guide

## 📋 Overview

This guide covers the complete deployment process for the RepairMyBike backend API to production servers, specifically optimized for Railway deployment.

## 🔧 Prerequisites

- Python 3.11+
- PostgreSQL database
- Redis (for production caching)
- Railway account (for deployment)
- Descope account (for authentication)
- Razorpay account (for payments)

## 🌟 Features

- **Passwordless Authentication** via Descope
- **Payment Processing** via Razorpay
- **Vehicle Management** system
- **Service Booking** functionality
- **Staff Management** with API keys
- **Shop/Parts Management**
- **Production-ready** with security optimizations

## 🚀 Quick Deployment (Railway)

### 1. Environment Setup

Copy `.env.example` to `.env` and configure:

```bash
# Required for production
SECRET_KEY=your-super-secret-key-here-minimum-50-characters-long
DEBUG=False
ALLOWED_HOSTS=yourdomain.com,www.yourdomain.com

# Database (Railway provides this automatically)
DATABASE_URL=postgresql://username:password@host:port/database

# Authentication
DESCOPE_PROJECT_ID=your-descope-project-id
DESCOPE_MANAGEMENT_KEY=your-descope-management-key

# Payments
RAZORPAY_KEY_ID=your-razorpay-key-id
RAZORPAY_KEY_SECRET=your-razorpay-key-secret
RAZORPAY_ENABLED=True

# Staff API
STAFF_API_KEY=your-staff-api-key

# CORS
CORS_ALLOWED_ORIGINS=https://yourdomain.com,https://www.yourdomain.com
```

### 2. Railway Deployment

1. **Connect Repository**:
   ```bash
   # Push to GitHub
   git add .
   git commit -m "Production deployment setup"
   git push origin main
   ```

2. **Deploy to Railway**:
   - Connect your GitHub repository to Railway
   - Railway will automatically detect the Dockerfile
   - Set environment variables in Railway dashboard
   - Deploy automatically triggers

3. **Post-deployment**:
   ```bash
   # Railway will automatically run:
   # - pip install -r requirements.txt
   # - python manage.py collectstatic --noinput
   # - gunicorn with optimized settings
   ```

## 🔒 Security Configuration

### Production Security Features

- ✅ **Strong SECRET_KEY** (50+ characters)
- ✅ **DEBUG=False** in production
- ✅ **HTTPS enforcement** with HSTS
- ✅ **Secure cookies** (SESSION_COOKIE_SECURE, CSRF_COOKIE_SECURE)
- ✅ **XSS protection** headers
- ✅ **Content type sniffing** protection
- ✅ **Clickjacking** protection
- ✅ **CORS** properly configured
- ✅ **Non-root user** in Docker container

### Environment Variables Security

Never commit these to version control:
- `SECRET_KEY`
- `DATABASE_URL`
- `DESCOPE_MANAGEMENT_KEY`
- `RAZORPAY_KEY_SECRET`
- `STAFF_API_KEY`

## 📊 Performance Optimizations

### Docker Optimizations
- **Multi-stage build** for smaller images
- **Non-root user** for security
- **Optimized Gunicorn** settings
- **Health checks** for monitoring
- **Static file compression** via WhiteNoise

### Database Optimizations
- **Connection pooling** via DATABASE_URL
- **Redis caching** for production
- **Optimized queries** in models

### Gunicorn Configuration
```bash
# Production settings
--workers 4
--worker-class sync
--worker-connections 1000
--max-requests 1000
--max-requests-jitter 100
--timeout 30
--keep-alive 2
```

## 🔍 Monitoring & Logging

### Logging Configuration
- **File logging** to `/app/logs/django.log`
- **Console logging** for Railway
- **Structured logging** with timestamps
- **Application-specific** loggers

### Health Checks
- **Docker health check** every 30 seconds
- **Django system checks** for deployment
- **Database connectivity** monitoring

## 🧪 Testing Deployment

### 1. Local Testing
```bash
# Install dependencies
pip install -r requirements.txt

# Run deployment script
python deploy.py

# Test locally
python manage.py runserver
```

### 2. Docker Testing
```bash
# Build image
docker build -t repairmybike-backend .

# Run container
docker run -p 8000:8000 --env-file .env repairmybike-backend
```

### 3. Production Testing
```bash
# Test API endpoints
curl -X GET https://yourdomain.com/api/services/
curl -X GET https://yourdomain.com/api/vehicles/

# Test authentication
curl -X POST https://yourdomain.com/api/auth/phone-otp-request/ \
  -H "Content-Type: application/json" \
  -d '{"phone": "+1234567890"}'
```

## 🔧 Troubleshooting

### Common Issues

1. **Migration Errors**:
   ```bash
   python manage.py migrate --fake-initial
   ```

2. **Static Files Not Loading**:
   ```bash
   python manage.py collectstatic --clear --noinput
   ```

3. **Database Connection Issues**:
   - Check `DATABASE_URL` format
   - Verify PostgreSQL is running
   - Check network connectivity

4. **Authentication Issues**:
   - Verify Descope configuration
   - Check project ID and management key
   - Ensure CORS is properly configured

### Logs and Debugging

```bash
# Check Railway logs
railway logs

# Check Django logs
tail -f logs/django.log

# Check system status
python manage.py check --deploy
```

## 📚 API Documentation

### Authentication Endpoints
- `POST /api/auth/phone-otp-request/` - Request phone OTP
- `POST /api/auth/phone-otp-verify/` - Verify phone OTP
- `POST /api/auth/email-otp-request/` - Request email OTP
- `POST /api/auth/logout/` - Logout user

### Core Endpoints
- `GET /api/vehicles/` - List vehicles
- `GET /api/services/` - List services
- `POST /api/bookings/` - Create booking
- `GET /api/payments/` - Payment history

### Staff Endpoints (Requires API Key)
- `GET /api/staff/bookings/` - Staff booking management
- `POST /api/staff/services/` - Service management

## 🔄 CI/CD Pipeline

The project includes GitHub Actions workflow for automated deployment:

1. **Code Quality Checks**
2. **Security Scanning**
3. **Automated Testing**
4. **Docker Build**
5. **Railway Deployment**

## 📞 Support

For deployment issues:
1. Check the logs first
2. Verify environment variables
3. Test database connectivity
4. Check Descope configuration
5. Verify payment gateway setup

## 🎯 Next Steps After Deployment

1. **Set up monitoring** (Sentry, DataDog)
2. **Configure backups** for database
3. **Set up SSL certificates** (Railway handles this)
4. **Configure custom domain**
5. **Set up email notifications**
6. **Implement rate limiting**
7. **Set up staging environment**

---

**🎉 Congratulations! Your RepairMyBike backend is now production-ready!**