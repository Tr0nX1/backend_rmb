# Kong API Gateway Deployment Guide

## Overview
This guide explains how to deploy your Django RepairMyBike backend with Kong API Gateway for production-level API management.

## Architecture
```
Flutter App → Kong Gateway → Django Backend → PostgreSQL/Redis
```

## Features Implemented

### 🔒 Security
- **API Key Authentication**: Secure access with API keys
- **Rate Limiting**: Prevent API abuse (100/min, 1000/hour, 10000/day)
- **IP Restriction**: Admin routes protected by IP whitelist
- **Request Size Limiting**: Max 10MB payload
- **CORS Management**: Centralized CORS policy

### 📊 Monitoring & Analytics
- **Prometheus Integration**: Metrics collection
- **Grafana Dashboard**: Visual monitoring
- **Request Logging**: Comprehensive access logs
- **Health Checks**: Service health monitoring

### 🚀 Performance
- **Load Balancing**: Distribute traffic across instances
- **Response Caching**: Reduce backend load
- **Request/Response Transformation**: Header manipulation

## Deployment Options

### Option 1: Local Development with Docker
```bash
# Start Kong + Django + PostgreSQL + Redis
docker-compose -f docker-compose.kong.yml up -d

# Check services
docker-compose -f docker-compose.kong.yml ps
```

### Option 2: Railway + Kong Cloud
1. Deploy Django to Railway
2. Use Kong Konnect (Cloud) or deploy Kong separately
3. Configure Kong to point to Railway Django URL

### Option 3: Full Docker Deployment
```bash
# Production deployment
docker-compose -f docker-compose.kong.yml up -d --scale django-backend=3
```

## Configuration Files

### 1. kong.yml
- Service definitions
- Route configurations
- Plugin settings
- Consumer management

### 2. docker-compose.kong.yml
- Multi-service orchestration
- Kong + Django + PostgreSQL + Redis
- Monitoring stack (Prometheus + Grafana)

### 3. Dockerfile
- Production-ready Django container
- Security hardening
- Health checks

## API Key Management

### Default API Keys
- **Flutter App**: `rmb-flutter-api-key-2024`
- **Mobile App**: `rmb-mobile-api-key-2024`
- **Web App**: `rmb-web-api-key-2024`

### Usage in Flutter
```dart
// Update your API service
class ApiService {
  static const String baseUrl = 'https://your-kong-gateway.com';
  static const String apiKey = 'rmb-flutter-api-key-2024';
  
  static Map<String, String> get headers => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'apikey': apiKey, // Kong API key
  };
}
```

## Monitoring Setup

### Prometheus Metrics
- Access: http://localhost:9090
- Monitors Kong and Django metrics

### Grafana Dashboard
- Access: http://localhost:3000
- Username: admin
- Password: admin123

## Railway Deployment

### 1. Environment Variables
Set these in Railway:
```
SECRET_KEY=your-secret-key
DEBUG=False
ALLOWED_HOSTS=your-domain.railway.app
DATABASE_URL=postgresql://...
REDIS_URL=redis://...
```

### 2. Deploy Command
```bash
# Railway will automatically detect Dockerfile
railway up
```

## Kong Gateway URLs

### Development
- **Proxy**: http://localhost:8000
- **Admin API**: http://localhost:8001
- **Prometheus**: http://localhost:9090
- **Grafana**: http://localhost:3000

### Production
- **Proxy**: https://your-kong-domain.com
- **Admin API**: https://admin.your-kong-domain.com

## Security Best Practices

### 1. API Keys
- Rotate keys regularly
- Use different keys per environment
- Store keys securely in Flutter app

### 2. Rate Limiting
- Adjust limits based on usage patterns
- Monitor for abuse patterns
- Implement progressive rate limiting

### 3. IP Restrictions
- Whitelist admin access
- Use VPN for admin operations
- Monitor admin access logs

## Troubleshooting

### Common Issues

1. **Kong can't reach Django**
   ```bash
   # Check network connectivity
   docker exec kong-container curl http://django-backend:8000/health/
   ```

2. **API Key Authentication Fails**
   ```bash
   # Test with curl
   curl -H "apikey: rmb-flutter-api-key-2024" http://localhost:8000/api/services/
   ```

3. **Rate Limiting Too Strict**
   ```yaml
   # Adjust in kong.yml
   - name: rate-limiting
     config:
       minute: 200  # Increase limits
   ```

### Logs
```bash
# Kong logs
docker logs kong-container

# Django logs
docker logs django-backend-container

# Database logs
docker logs postgres-container
```

## Performance Tuning

### Kong Configuration
- Adjust worker processes
- Configure memory limits
- Optimize database connections

### Django Configuration
- Scale horizontally with multiple instances
- Use connection pooling
- Implement caching strategies

## Next Steps

1. **Deploy to Railway**: Push your code and configure environment variables
2. **Set up Kong**: Deploy Kong Gateway (cloud or self-hosted)
3. **Configure DNS**: Point your domain to Kong Gateway
4. **Update Flutter**: Use Kong Gateway URL and API keys
5. **Monitor**: Set up alerts and monitoring dashboards

## Support

For issues or questions:
- Check Kong documentation: https://docs.konghq.com/
- Django deployment guide: https://docs.djangoproject.com/en/stable/howto/deployment/
- Railway documentation: https://docs.railway.app/