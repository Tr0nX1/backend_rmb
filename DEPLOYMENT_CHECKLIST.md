# Deployment Checklist

## 🚀 Pre-Deployment Checklist

### ✅ Security Configuration
- [x] All sensitive data moved to environment variables
- [x] `.env` file added to `.gitignore`
- [x] `.env.example` template created with all required variables
- [x] `DEBUG=False` configured for production
- [x] `SECRET_KEY` externalized and secure
- [x] `ALLOWED_HOSTS` properly configured
- [x] HTTPS settings configured for production
- [x] Security headers implemented
- [x] CORS origins properly configured
- [x] Database credentials externalized

### ✅ Django Configuration
- [x] Django system check passes: `python manage.py check`
- [x] Deployment security check reviewed: `python manage.py check --deploy`
- [x] Static files configuration ready
- [x] Media files configuration ready
- [x] Logging configuration implemented
- [x] Database configuration with connection pooling
- [x] Cache configuration with Redis

### ✅ Docker & Containerization
- [x] `Dockerfile` created with multi-stage build
- [x] `.dockerignore` file configured
- [x] `docker-compose.yml` for development
- [x] `docker-compose.prod.yml` for production
- [x] Nginx configuration for reverse proxy
- [x] PostgreSQL initialization scripts
- [x] Log rotation configuration

### ✅ CI/CD Pipeline
- [x] GitHub Actions workflow for CI/CD
- [x] Automated testing pipeline
- [x] Security scanning (Bandit, Safety, Semgrep)
- [x] Code quality checks (Black, isort, flake8)
- [x] Deployment automation to Railway
- [x] Health checks after deployment
- [x] Daily security monitoring workflow

### ✅ Documentation
- [x] Comprehensive README.md
- [x] Security documentation (SECURITY.md)
- [x] Deployment checklist (this file)
- [x] Environment variables documented
- [x] API endpoints documented

## 🔧 Production Deployment Steps

### 1. Environment Setup
```bash
# Set production environment variables
export DEBUG=False
export ENVIRONMENT=production
export SECRET_KEY=your-production-secret-key
export DATABASE_URL=postgresql://user:password@host:port/database
export REDIS_URL=redis://host:port/db
export ALLOWED_HOSTS=yourdomain.com,www.yourdomain.com

# Security settings
export SECURE_SSL_REDIRECT=True
export SECURE_HSTS_SECONDS=31536000
export SESSION_COOKIE_SECURE=True
export CSRF_COOKIE_SECURE=True

# CORS settings
export CORS_ALLOWED_ORIGINS=https://yourdomain.com
```

### 2. Database Migration
```bash
python manage.py migrate
python manage.py collectstatic --noinput
```

### 3. Security Verification
```bash
# Run security checks
python manage.py check --deploy

# Expected warnings in development:
# - SECURE_HSTS_SECONDS (set via env var in production)
# - SECURE_SSL_REDIRECT (set via env var in production)
# - SESSION_COOKIE_SECURE (set via env var in production)
# - CSRF_COOKIE_SECURE (set via env var in production)
# - DEBUG=True (set to False in production)
```

### 4. Docker Deployment
```bash
# Build production image
docker build -t repairmybike-prod .

# Run with production compose
docker-compose -f docker-compose.prod.yml up -d
```

### 5. Railway Deployment
1. Connect GitHub repository to Railway
2. Set environment variables in Railway dashboard
3. Deploy via GitHub Actions or Railway CLI

## 🔍 Post-Deployment Verification

### Health Checks
- [ ] Application starts successfully
- [ ] Database connection works
- [ ] Redis cache connection works
- [ ] Static files are served correctly
- [ ] API endpoints respond correctly
- [ ] Authentication works
- [ ] HTTPS redirect works (production)
- [ ] Security headers are present

### Security Verification
```bash
# Test security headers
curl -I https://yourdomain.com

# Expected headers:
# - Strict-Transport-Security
# - X-Content-Type-Options: nosniff
# - X-Frame-Options: DENY
# - X-XSS-Protection: 1; mode=block
# - Referrer-Policy: strict-origin-when-cross-origin
```

### Performance Checks
- [ ] Response times are acceptable
- [ ] Database queries are optimized
- [ ] Cache is working effectively
- [ ] Static files are compressed
- [ ] Images are optimized

## 🚨 Production Environment Variables

### Required Variables
```bash
# Core Django
SECRET_KEY=your-256-bit-secret-key
DEBUG=False
ENVIRONMENT=production
ALLOWED_HOSTS=yourdomain.com,www.yourdomain.com

# Database
DATABASE_URL=postgresql://user:password@host:port/database

# Cache
REDIS_URL=redis://host:port/db

# Authentication
DESCOPE_PROJECT_ID=your-project-id
DESCOPE_MANAGEMENT_KEY=your-management-key

# Payments
RAZORPAY_KEY_ID=your-key-id
RAZORPAY_KEY_SECRET=your-key-secret

# Security
SECURE_SSL_REDIRECT=True
SECURE_HSTS_SECONDS=31536000
SESSION_COOKIE_SECURE=True
CSRF_COOKIE_SECURE=True

# CORS
CORS_ALLOWED_ORIGINS=https://yourdomain.com
```

## 🔄 Monitoring & Maintenance

### Daily Tasks
- [ ] Check application logs
- [ ] Monitor error rates
- [ ] Review security alerts
- [ ] Check system resources

### Weekly Tasks
- [ ] Review access logs
- [ ] Update dependencies (if needed)
- [ ] Check backup integrity
- [ ] Performance monitoring

### Monthly Tasks
- [ ] Security audit
- [ ] Dependency vulnerability scan
- [ ] Performance optimization review
- [ ] Backup strategy review

## 🆘 Troubleshooting

### Common Issues

1. **Static files not loading**
   - Check `STATIC_ROOT` and `STATIC_URL` settings
   - Run `python manage.py collectstatic`
   - Verify Nginx configuration

2. **Database connection errors**
   - Check `DATABASE_URL` format
   - Verify database server is running
   - Check network connectivity

3. **Redis connection errors**
   - Check `REDIS_URL` format
   - Verify Redis server is running
   - Check Redis configuration

4. **CORS errors**
   - Verify `CORS_ALLOWED_ORIGINS` includes your frontend domain
   - Check protocol (http vs https)
   - Verify middleware order

### Emergency Contacts
- Development Team: [contact info]
- Infrastructure Team: [contact info]
- Security Team: [contact info]

## 📋 Rollback Plan

If deployment fails:

1. **Immediate Actions**
   - Revert to previous Docker image
   - Check application logs
   - Verify database integrity

2. **Investigation**
   - Identify root cause
   - Document the issue
   - Plan fix implementation

3. **Recovery**
   - Apply hotfix if possible
   - Schedule proper fix deployment
   - Update deployment procedures

---

**Note**: This checklist should be reviewed and updated with each deployment to ensure all steps are current and complete.