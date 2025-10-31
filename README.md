# RepairMyBike Backend API

A comprehensive Django REST API for bike repair service management with modern security practices, containerization, and CI/CD pipeline.

## 🚀 Features

- **Authentication & Authorization**: Descope integration with JWT tokens
- **Service Management**: Vehicle types, brands, models, and repair services
- **Booking System**: Customer bookings with service scheduling
- **Payment Integration**: Razorpay payment gateway
- **Staff Management**: Staff-specific booking management
- **Shop Management**: Multi-location shop information
- **Security**: Comprehensive security headers, HTTPS, rate limiting
- **Caching**: Redis-based caching for performance
- **Monitoring**: Health checks and logging
- **Containerization**: Docker and Docker Compose support
- **CI/CD**: GitHub Actions pipeline with automated testing and deployment

## 🛠️ Tech Stack

- **Backend**: Django 5.2.7, Django REST Framework
- **Database**: PostgreSQL 15
- **Cache**: Redis 7
- **Authentication**: Descope
- **Payments**: Razorpay
- **Containerization**: Docker, Docker Compose
- **Web Server**: Nginx (production)
- **WSGI Server**: Gunicorn
- **CI/CD**: GitHub Actions
- **Deployment**: Railway (configured)

## 📋 Prerequisites

- Python 3.11+
- PostgreSQL 15+
- Redis 7+
- Docker & Docker Compose (optional)
- Git

## 🔧 Local Development Setup

### 1. Clone the Repository

```bash
git clone <repository-url>
cd repairmybike-backend
```

### 2. Environment Configuration

```bash
# Copy the example environment file
cp .env.example .env

# Edit .env with your configuration
# Required variables:
# - SECRET_KEY: Generate a new Django secret key
# - DATABASE_URL: Your PostgreSQL connection string
# - REDIS_URL: Your Redis connection string
# - DESCOPE_PROJECT_ID: Your Descope project ID
# - DESCOPE_MANAGEMENT_KEY: Your Descope management key
```

### 3. Virtual Environment Setup

```bash
# Create virtual environment
python -m venv venv

# Activate virtual environment
# Windows
venv\Scripts\activate
# macOS/Linux
source venv/bin/activate

# Install dependencies
pip install -r requirements.txt
```

### 4. Database Setup

```bash
# Run migrations
python manage.py migrate

# Create superuser (optional)
python manage.py createsuperuser

# Load initial data (if any)
python manage.py loaddata fixtures/initial_data.json
```

### 5. Run Development Server

```bash
# Start the development server
python manage.py runserver

# The API will be available at http://localhost:8000
```

## 🐳 Docker Development Setup

### 1. Using Docker Compose

```bash
# Build and start all services
docker-compose up --build

# Run in background
docker-compose up -d

# View logs
docker-compose logs -f

# Stop services
docker-compose down
```

### 2. Services Available

- **Web Application**: http://localhost:8000
- **Database Admin**: http://localhost:8080 (Adminer)
- **PostgreSQL**: localhost:5432
- **Redis**: localhost:6379

## 🚀 Production Deployment

### 1. Environment Variables

Set the following environment variables in your production environment:

```bash
# Core Django Settings
SECRET_KEY=your-production-secret-key
DEBUG=False
ENVIRONMENT=production
ALLOWED_HOSTS=yourdomain.com,www.yourdomain.com

# Database
DATABASE_URL=postgresql://user:password@host:port/database

# Cache
REDIS_URL=redis://host:port/db

# Authentication
DESCOPE_PROJECT_ID=your-descope-project-id
DESCOPE_MANAGEMENT_KEY=your-descope-management-key

# Payments
RAZORPAY_KEY_ID=your-razorpay-key-id
RAZORPAY_KEY_SECRET=your-razorpay-key-secret
RAZORPAY_ENABLED=True

# Security
SECURE_SSL_REDIRECT=True
SESSION_COOKIE_SECURE=True
CSRF_COOKIE_SECURE=True
CSRF_TRUSTED_ORIGINS=https://yourdomain.com

# CORS
CORS_ALLOWED_ORIGINS=https://yourfrontend.com
```

### 2. Railway Deployment

The project is configured for Railway deployment:

1. Connect your GitHub repository to Railway
2. Set environment variables in Railway dashboard
3. Deploy automatically via GitHub Actions

### 3. Manual Docker Production Deployment

```bash
# Build production image
docker build -t repairmybike-prod .

# Run with production compose
docker-compose -f docker-compose.prod.yml up -d
```

## 🔒 Security Features

### Implemented Security Measures

- **HTTPS Enforcement**: SSL redirect and HSTS headers
- **Security Headers**: XSS protection, content type sniffing prevention
- **CSRF Protection**: Django CSRF middleware with secure cookies
- **Rate Limiting**: Nginx-based rate limiting for API endpoints
- **Input Validation**: Django forms and serializers validation
- **SQL Injection Prevention**: Django ORM protection
- **Authentication**: Secure JWT token-based authentication
- **Environment Variables**: All sensitive data in environment variables
- **Docker Security**: Non-root user, minimal base images

### Security Checklist

- [ ] Change default SECRET_KEY
- [ ] Set DEBUG=False in production
- [ ] Configure ALLOWED_HOSTS properly
- [ ] Set up SSL certificates
- [ ] Configure CORS origins
- [ ] Set secure cookie flags
- [ ] Enable security headers
- [ ] Configure rate limiting
- [ ] Set up monitoring and logging
- [ ] Regular security updates

## 🧪 Testing

### Run Tests

```bash
# Run all tests
python manage.py test

# Run with coverage
coverage run --source='.' manage.py test
coverage report
coverage html
```

### CI/CD Pipeline

The GitHub Actions pipeline includes:

- **Code Quality**: Black formatting, isort, flake8 linting
- **Security Scanning**: Bandit, Safety, Semgrep
- **Testing**: Unit tests with coverage reporting
- **Deployment**: Automated deployment to Railway
- **Monitoring**: Post-deployment health checks

## 📊 API Documentation

### Health Endpoints

- `GET /health/` - Basic health check
- `GET /ready/` - Readiness check (database and cache)

### Authentication Endpoints

- `POST /api/auth/register/` - User registration
- `POST /api/auth/login/` - User login
- `POST /api/auth/logout/` - User logout
- `POST /api/auth/otp/request/` - Request OTP
- `POST /api/auth/otp/verify/` - Verify OTP

### Main API Endpoints

- `/api/vehicles/` - Vehicle management
- `/api/services/` - Service management
- `/api/bookings/` - Booking management
- `/api/payments/` - Payment management
- `/api/staff/` - Staff management
- `/api/shop/` - Shop information

## 🔧 Configuration

### Environment Variables Reference

See `.env.example` for a complete list of configurable environment variables.

### Django Settings

The settings are organized into sections:
- Core Django configuration
- Database settings
- Cache configuration
- Security settings
- Static/media files
- Logging configuration

## 📝 Logging

Logs are configured for different environments:

- **Development**: Console output with detailed formatting
- **Production**: File-based logging with rotation
- **Docker**: Container logs with proper formatting

Log files location: `logs/django.log`

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Run tests and linting
5. Submit a pull request

### Code Style

- Use Black for code formatting
- Use isort for import sorting
- Follow PEP 8 guidelines
- Write comprehensive tests
- Update documentation

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🆘 Support

For support and questions:

1. Check the documentation
2. Review existing issues
3. Create a new issue with detailed information
4. Contact the development team

## 🔄 Changelog

See CHANGELOG.md for version history and updates.

---

**Note**: This is a production-ready Django application with comprehensive security measures, monitoring, and deployment configurations. Always review and test thoroughly before deploying to production.