# Passwordless Authentication API Documentation

This Django backend now supports **complete passwordless authentication** using OTP (One-Time Password) via both phone SMS and email. Users can authenticate without passwords using either their phone number or email address.

## 🔐 Authentication Methods

### 1. Phone OTP Authentication
- **Request OTP**: Send SMS OTP to phone number
- **Verify OTP**: Verify the SMS code to authenticate
- **Login**: Complete authentication flow

### 2. Email OTP Authentication  
- **Request OTP**: Send email OTP to email address
- **Verify OTP**: Verify the email code to authenticate
- **Login**: Complete authentication flow

### 3. Unified OTP Authentication (Recommended)
- **Single endpoint** for both phone and email OTP
- **Method parameter** specifies phone or email
- **Consistent API** across all authentication methods

## 📡 API Endpoints

### Phone OTP Endpoints
```
POST /auth/phone/request-otp/     # Request SMS OTP
POST /auth/phone/verify-otp/       # Verify SMS OTP
POST /auth/phone/login/           # Login with SMS OTP
```

### Email OTP Endpoints
```
POST /auth/email/request-otp/     # Request Email OTP
POST /auth/email/verify-otp/       # Verify Email OTP
POST /auth/email/login/           # Login with Email OTP
```

### Unified OTP Endpoints (Recommended)
```
POST /auth/otp/request/           # Request OTP (phone or email)
POST /auth/otp/verify/            # Verify OTP (phone or email)
```

## 📋 Request/Response Examples

### 1. Request Phone OTP
```bash
POST /auth/otp/request/
Content-Type: application/json

{
    "identifier": "+1234567890",
    "method": "phone"
}
```

**Response:**
```json
{
    "message": "OTP sent successfully",
    "identifier": "+1234567890",
    "method": "phone",
    "expires_in": 300
}
```

### 2. Request Email OTP
```bash
POST /auth/otp/request/
Content-Type: application/json

{
    "identifier": "user@example.com",
    "method": "email"
}
```

**Response:**
```json
{
    "message": "OTP sent successfully",
    "identifier": "user@example.com",
    "method": "email",
    "expires_in": 300
}
```

### 3. Verify OTP and Login
```bash
POST /auth/otp/verify/
Content-Type: application/json

{
    "identifier": "+1234567890",
    "otp_code": "123456",
    "method": "phone"
}
```

**Response:**
```json
{
    "message": "OTP verified successfully",
    "user": {
        "id": 1,
        "username": "user_1234567890",
        "email": "",
        "phone_number": "+1234567890",
        "is_verified": true,
        "is_phone_verified": true,
        "created_at": "2024-01-01T00:00:00Z"
    },
    "session_token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9...",
    "refresh_token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9..."
}
```

## 🔒 Security Features

### Rate Limiting
- **Maximum 5 OTP requests per hour** per identifier
- **Automatic blocking** for 1 hour after limit exceeded
- **Separate limits** for phone and email

### OTP Security
- **5-minute expiration** for all OTP codes
- **No storage** of actual OTP codes in database
- **Attempt tracking** with automatic cleanup

### Session Management
- **JWT tokens** for authentication
- **Refresh token** support
- **Session tracking** and management

## 🛠️ Management Commands

### Cleanup Expired OTPs
```bash
# Clean up expired OTPs and reset rate limits
python manage.py cleanup_otp

# Dry run to see what would be cleaned
python manage.py cleanup_otp --dry-run
```

## 📊 Admin Interface

The Django admin interface provides:
- **User management** with OTP verification status
- **OTP attempt tracking** and rate limiting
- **Session management** and monitoring
- **Bulk actions** for rate limit resets

## 🔧 Configuration

### Environment Variables
```bash
DESCOPE_PROJECT_ID=your_descope_project_id
DESCOPE_MANAGEMENT_KEY=your_descope_management_key
```

### Settings
The system uses Descope for OTP delivery and verification. Make sure your Descope project is configured with:
- **SMS OTP** enabled for phone authentication
- **Email OTP** enabled for email authentication
- **Proper templates** for OTP messages

## 🚀 Usage Flow

### For Frontend Applications

1. **Request OTP**:
   ```javascript
   const response = await fetch('/auth/otp/request/', {
       method: 'POST',
       headers: { 'Content-Type': 'application/json' },
       body: JSON.stringify({
           identifier: '+1234567890', // or email
           method: 'phone' // or 'email'
       })
   });
   ```

2. **Verify OTP**:
   ```javascript
   const response = await fetch('/auth/otp/verify/', {
       method: 'POST',
       headers: { 'Content-Type': 'application/json' },
       body: JSON.stringify({
           identifier: '+1234567890',
           otp_code: '123456',
           method: 'phone'
       })
   });
   
   const data = await response.json();
   // Store session_token for authenticated requests
   localStorage.setItem('session_token', data.session_token);
   ```

3. **Make Authenticated Requests**:
   ```javascript
   const response = await fetch('/auth/profile/', {
       headers: {
           'Authorization': `Bearer ${localStorage.getItem('session_token')}`
       }
   });
   ```

## 📱 Frontend Integration Examples

### React Hook Example
```javascript
const usePasswordlessAuth = () => {
    const [loading, setLoading] = useState(false);
    const [user, setUser] = useState(null);
    
    const requestOTP = async (identifier, method) => {
        setLoading(true);
        try {
            const response = await fetch('/auth/otp/request/', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ identifier, method })
            });
            return await response.json();
        } finally {
            setLoading(false);
        }
    };
    
    const verifyOTP = async (identifier, otpCode, method) => {
        setLoading(true);
        try {
            const response = await fetch('/auth/otp/verify/', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ identifier, otp_code: otpCode, method })
            });
            const data = await response.json();
            if (data.session_token) {
                localStorage.setItem('session_token', data.session_token);
                setUser(data.user);
            }
            return data;
        } finally {
            setLoading(false);
        }
    };
    
    return { requestOTP, verifyOTP, loading, user };
};
```

## 🎯 Benefits

1. **Enhanced Security**: No passwords to compromise
2. **Better UX**: Faster authentication flow
3. **Flexible Options**: Phone or email authentication
4. **Rate Limiting**: Protection against abuse
5. **Automatic Cleanup**: Self-maintaining system
6. **Admin Monitoring**: Full visibility and control

## 🔄 Migration from Password-based Auth

The system maintains backward compatibility with existing password-based authentication while providing the new passwordless options. You can:

1. **Keep existing users** with password authentication
2. **Add OTP verification** to existing accounts
3. **Gradually migrate** users to passwordless authentication
4. **Support both methods** simultaneously

This implementation provides a complete, production-ready passwordless authentication system that's secure, scalable, and user-friendly.
