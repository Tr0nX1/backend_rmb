# RepairMyBike Backend - Authentication System

A Django REST API backend with Descope authentication integration and PostgreSQL database.

## Features

- **Descope Authentication**: Complete authentication system using Descope SDK
- **Phone OTP Authentication**: SMS-based OTP authentication for secure login
- **PostgreSQL Database**: Robust database backend
- **Django REST Framework**: RESTful API endpoints
- **Custom User Model**: Extended user model with Descope integration
- **Session Management**: Track and manage user sessions
- **Password Reset**: Email-based password reset functionality
- **CORS Support**: Cross-origin resource sharing for frontend integration

## Setup Instructions

### 1. Install Dependencies

```bash
pip install -r requirements.txt
```

### 2. Environment Configuration

Create a `.env` file in the project root with the following variables:

```env
# Django Settings
SECRET_KEY=your-secret-key-here
DEBUG=True
ALLOWED_HOSTS=localhost,127.0.0.1

# Database Settings
DB_NAME=repairmybike
DB_USER=postgres
DB_PASSWORD=your-db-password
DB_HOST=localhost
DB_PORT=5432

# Descope Settings
DESCOPE_PROJECT_ID=your-descope-project-id
DESCOPE_MANAGEMENT_KEY=your-descope-management-key
```

### 3. Database Setup

1. Install PostgreSQL
2. Create a database named `repairmybike`
3. Run migrations:

```bash
python manage.py makemigrations
python manage.py migrate
```

### 4. Create Superuser

```bash
python manage.py createsuperuser
```

### 5. Run Development Server

```bash
python manage.py runserver
```

## API Endpoints

### Authentication

- `POST /api/auth/register/` - User registration
- `POST /api/auth/login/` - User login
- `POST /api/auth/logout/` - User logout

### Phone OTP Authentication

- `POST /api/auth/phone/request-otp/` - Request OTP for phone number
- `POST /api/auth/phone/verify-otp/` - Verify OTP code
- `POST /api/auth/phone/login/` - Login with phone number and OTP
- `GET /api/auth/phone/verification-status/` - Check phone verification status
- `POST /api/auth/phone/resend-otp/` - Resend OTP code

### User Profile

- `GET /api/auth/profile/` - Get user profile
- `PATCH /api/auth/profile/` - Update user profile

### Password Management

- `POST /api/auth/password-reset/` - Request password reset
- `POST /api/auth/password-reset-confirm/` - Confirm password reset

### Session Management

- `GET /api/auth/sessions/` - Get user sessions
- `POST /api/auth/sessions/<id>/revoke/` - Revoke session

## API Usage Examples

### User Registration

```bash
curl -X POST http://localhost:8000/api/auth/register/ \
  -H "Content-Type: application/json" \
  -d '{
    "email": "user@example.com",
    "password": "securepassword123",
    "first_name": "John",
    "last_name": "Doe",
    "phone_number": "+1234567890"
  }'
```

### User Login

```bash
curl -X POST http://localhost:8000/api/auth/login/ \
  -H "Content-Type: application/json" \
  -d '{
    "email": "user@example.com",
    "password": "securepassword123"
  }'
```

### Phone OTP Authentication

```bash
# Request OTP
curl -X POST http://localhost:8000/api/auth/phone/request-otp/ \
  -H "Content-Type: application/json" \
  -d '{
    "phone_number": "+1234567890"
  }'

# Verify OTP and Login
curl -X POST http://localhost:8000/api/auth/phone/verify-otp/ \
  -H "Content-Type: application/json" \
  -d '{
    "phone_number": "+1234567890",
    "otp_code": "123456"
  }'
```

### Access Protected Endpoints

```bash
curl -X GET http://localhost:8000/api/auth/profile/ \
  -H "Authorization: Bearer YOUR_SESSION_TOKEN"
```

## Descope Configuration

1. Sign up for a Descope account at [descope.com](https://descope.com)
2. Create a new project
3. Get your Project ID and Management Key from the Descope dashboard
4. Add these credentials to your `.env` file

## Database Models

### User Model
- Extended Django User model with Descope integration
- Fields: `descope_user_id`, `phone_number`, `profile_picture`, `is_verified`

### UserSession Model
- Tracks user sessions
- Fields: `user`, `session_token`, `refresh_token`, `expires_at`, `is_active`

## Security Features

- JWT token validation through Descope
- Session management and revocation
- CORS configuration for frontend integration
- Secure password handling via Descope
- User verification status tracking

## Development

### Running Tests

```bash
python manage.py test
```

### Database Migrations

```bash
# Create migrations
python manage.py makemigrations

# Apply migrations
python manage.py migrate
```

### Admin Interface

Access the Django admin at `http://localhost:8000/admin/` to manage users and sessions.

## Production Deployment

1. Set `DEBUG=False` in production
2. Use environment variables for all sensitive data
3. Configure proper CORS origins
4. Use a production PostgreSQL database
5. Set up proper logging and monitoring

## Troubleshooting

### Common Issues

1. **Database Connection**: Ensure PostgreSQL is running and credentials are correct
2. **Descope Integration**: Verify Project ID and Management Key are correct
3. **CORS Issues**: Check CORS_ALLOWED_ORIGINS in settings.py
4. **Token Validation**: Ensure Descope tokens are properly formatted

### Logs

Check Django logs for authentication errors and Descope API responses.

## Support

For issues related to:
- Django: [Django Documentation](https://docs.djangoproject.com/)
- Descope: [Descope Documentation](https://docs.descope.com/)
- PostgreSQL: [PostgreSQL Documentation](https://www.postgresql.org/docs/)








# Vehicle Repair Service Backend

Django REST API backend for vehicle repair service booking application with PostgreSQL and Redis caching.

## Features

- Vehicle management (Types, Brands, Models)
- Service catalog with dynamic pricing per vehicle
- Customer booking system
- Payment integration (Razorpay + Cash)
- Staff management portal
- Redis caching for performance
- Secure API with validation

## Tech Stack

- Django 4.2.7
- Django REST Framework
- PostgreSQL
- Redis
- Razorpay

## Project Structure

```
vehicle_repair_service/
├── config/              # Project settings
├── vehicles/            # Vehicle management
├── services/            # Service catalog & pricing
├── bookings/            # Booking system
├── payments/            # Payment handling
├── staff/               # Staff portal
└── shop/                # Shop information
```

## Setup Instructions

### 1. Prerequisites

- Python 3.10+
- PostgreSQL
- Redis

### 2. Installation

```bash
# Clone the repository
git clone <repository-url>
cd vehicle_repair_service

# Create virtual environment
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt
```

### 3. Database Setup

```bash
# Create PostgreSQL database
createdb vehicle_repair_db

# Or using psql
psql -U postgres
CREATE DATABASE vehicle_repair_db;
\q
```

### 4. Environment Configuration

```bash
# Copy .env.example to .env
cp .env.example .env

# Update .env with your credentials
```

### 5. Run Migrations

```bash
python manage.py makemigrations
python manage.py migrate
```

### 6. Create Superuser

```bash
python manage.py createsuperuser
```

### 7. Start Redis

```bash
# On Ubuntu/Debian
sudo service redis-server start

# On macOS with Homebrew
brew services start redis

# On Windows
redis-server
```

### 8. Run Development Server

```bash
python manage.py runserver
```

Server will be available at: `http://localhost:8000`

## API Documentation

### Base URL
```
http://localhost:8000/api/
```

### Public Endpoints

#### 1. Vehicle APIs

**Get Vehicle Types**
```
GET /api/vehicle-types/
Response: List of vehicle types (Scooter, Motorcycle)
```

**Get Vehicle Brands**
```
GET /api/vehicle-brands/?vehicle_type={id}
Response: List of brands for selected type
```

**Get Vehicle Models**
```
GET /api/vehicle-models/?vehicle_brand={id}
Response: List of models for selected brand
```

#### 2. Service APIs

**Get Service Categories**
```
GET /api/service-categories/
Response: List of service categories
```

**Get Services**
```
GET /api/services/
GET /api/services/?category_id={id}
Response: List of services
```

**Get Service Pricing by Vehicle**
```
GET /api/service-pricing/by-vehicle/?vehicle_model_id={id}
Response: All services with prices for specific vehicle
```

#### 3. Booking APIs

**Create Booking**
```
POST /api/bookings/
Body: {
  "customer_name": "John Doe",
  "customer_phone": "9876543210",
  "customer_email": "john@example.com",
  "vehicle_model_id": 1,
  "service_ids": [1, 2, 3],
  "service_location": "home",
  "address": "123 Main St",
  "appointment_date": "2025-11-01",
  "appointment_time": "10:00:00",
  "payment_method": "cash",
  "notes": "Optional notes"
}
Response: Created booking details
```

**Get Booking History**
```
GET /api/bookings/?phone=9876543210
Response: List of bookings for phone number
```

**Get Booking Details**
```
GET /api/bookings/{id}/
Response: Single booking details
```

#### 4. Shop Info API

**Get Shop Information**
```
GET /api/shop-info/
Response: Shop details, address, timings
```

#### 5. Payment APIs (Disabled by default)

**Create Razorpay Order**
```
POST /api/payments/razorpay/create-order/
Body: { "booking_id": 1 }
Response: Razorpay order details
```

**Verify Razorpay Payment**
```
POST /api/payments/razorpay/verify/
Body: {
  "razorpay_order_id": "...",
  "razorpay_payment_id": "...",
  "razorpay_signature": "..."
}
Response: Payment verification status
```

### Staff Endpoints (Requires API Key)

All staff endpoints require `X-API-Key` header with the value from `.env` file.

```
Headers: {
  "X-API-Key": "your-staff-api-key"
}
```

**Get All Bookings**
```
GET /api/staff/bookings/
GET /api/staff/bookings/?status=pending
GET /api/staff/bookings/?date=2025-11-01
GET /api/staff/bookings/?search=John
Response: List of bookings with filters
```

**Get Booking Details**
```
GET /api/staff/bookings/{id}/
Response: Single booking details
```

**Update Booking Status**
```
PATCH /api/staff/bookings/{id}/update-status/
Body: { "status": "confirmed" }
Valid statuses: pending, confirmed, in_progress, completed, cancelled
Response: Updated booking
```

**Get Statistics**
```
GET /api/staff/bookings/stats/
Response: Booking and payment statistics
```

## Admin Panel

Access Django admin at: `http://localhost:8000/admin/`

You can manage:
- Vehicle Types, Brands, Models
- Service Categories, Services, Pricing
- Customers and Bookings
- Payments
- Shop Information

## Testing

```bash
# Run tests
python manage.py test

# Check for issues
python manage.py check
```

## Production Deployment

### 1. Update Settings

```python
# In config/settings.py
DEBUG = False
ALLOWED_HOSTS = ['your-domain.com']
```

### 2. Collect Static Files

```bash
python manage.py collectstatic
```

### 3. Use Production Server

```bash
gunicorn config.wsgi:application --bind 0.0.0.0:8000
```

### 4. Setup HTTPS

Ensure SSL certificate is configured for production.

## Security Features

- Input validation and sanitization
- SQL injection prevention (ORM)
- Rate limiting
- CORS configuration
- Secure password hashing
- API key authentication for staff
- Environment variables for secrets

## Caching

Redis caching is implemented for:
- Vehicle types, brands, models (1 hour)
- Service categories (1 hour)
- Services (1 hour)
- Service pricing (30 minutes)
- Shop information (1 hour)

## Troubleshooting

**Database connection error:**
- Check PostgreSQL is running
- Verify credentials in .env

**Redis connection error:**
- Check Redis is running: `redis-cli ping`
- Should return "PONG"

**Migration errors:**
- Delete migrations: `find . -path "*/migrations/*.py" -not -name "__init__.py" -delete`
- Recreate: `python manage.py makemigrations`

## Contributing

1. Create feature branch
2. Make changes
3. Test thoroughly
4. Submit pull request

## License

Proprietary - All rights reserved