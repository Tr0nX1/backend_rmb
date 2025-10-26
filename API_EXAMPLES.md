# API Response Examples

## Success Response Format

All successful responses follow this format:
```json
{
  "error": false,
  "message": "Success message",
  "data": { ... }
}
```

## Error Response Format

All error responses follow this format:
```json
{
  "error": true,
  "message": "Error message",
  "status_code": 400
}
```

## Example API Calls

### 1. Get Vehicle Types

**Request:**
```
GET /api/vehicle-types/
```

**Response:**
```json
{
  "error": false,
  "message": "Vehicle types retrieved successfully",
  "data": [
    {
      "id": 1,
      "name": "Motorcycle",
      "created_at": "2025-10-26T10:00:00Z",
      "updated_at": "2025-10-26T10:00:00Z"
    },
    {
      "id": 2,
      "name": "Scooter",
      "created_at": "2025-10-26T10:00:00Z",
      "updated_at": "2025-10-26T10:00:00Z"
    }
  ]
}
```

### 2. Get Vehicle Brands

**Request:**
```
GET /api/vehicle-brands/?vehicle_type=1
```

**Response:**
```json
{
  "error": false,
  "message": "Vehicle brands retrieved successfully",
  "data": [
    {
      "id": 1,
      "vehicle_type": 1,
      "vehicle_type_name": "Motorcycle",
      "name": "Bajaj",
      "created_at": "2025-10-26T10:00:00Z",
      "updated_at": "2025-10-26T10:00:00Z"
    },
    {
      "id": 2,
      "vehicle_type": 1,
      "vehicle_type_name": "Motorcycle",
      "name": "Hero",
      "created_at": "2025-10-26T10:00:00Z",
      "updated_at": "2025-10-26T10:00:00Z"
    }
  ]
}
```

### 3. Get Service Pricing by Vehicle

**Request:**
```
GET /api/service-pricing/by-vehicle/?vehicle_model_id=1
```

**Response:**
```json
{
  "error": false,
  "message": "Service pricing retrieved successfully",
  "data": [
    {
      "id": 1,
      "service_id": 1,
      "service_name": "Engine Oil Change",
      "category_id": 1,
      "category_name": "Engine Services",
      "description": "Complete engine oil replacement",
      "vehicle_model": 1,
      "price": "500.00",
      "created_at": "2025-10-26T10:00:00Z",
      "updated_at": "2025-10-26T10:00:00Z"
    },
    {
      "id": 2,
      "service_id": 2,
      "service_name": "Brake Pad Replacement",
      "category_id": 2,
      "category_name": "Brake System",
      "description": "Front and rear brake pad replacement",
      "vehicle_model": 1,
      "price": "800.00",
      "created_at": "2025-10-26T10:00:00Z",
      "updated_at": "2025-10-26T10:00:00Z"
    }
  ]
}
```

### 4. Create Booking

**Request:**
```
POST /api/bookings/
Content-Type: application/json

{
  "customer_name": "Rahul Sharma",
  "customer_phone": "9876543210",
  "customer_email": "rahul@example.com",
  "vehicle_model_id": 1,
  "service_ids": [1, 2],
  "service_location": "home",
  "address": "123, MG Road, Bangalore, Karnataka - 560001",
  "appointment_date": "2025-11-01",
  "appointment_time": "10:00:00",
  "payment_method": "cash",
  "notes": "Please call before arriving"
}
```

**Response:**
```json
{
  "error": false,
  "message": "Booking created successfully",
  "data": {
    "id": 1,
    "customer": {
      "id": 1,
      "name": "Rahul Sharma",
      "phone": "9876543210",
      "email": "rahul@example.com",
      "created_at": "2025-10-26T10:00:00Z",
      "updated_at": "2025-10-26T10:00:00Z"
    },
    "vehicle_model": 1,
    "vehicle_model_name": "Pulsar 150",
    "vehicle_brand_name": "Bajaj",
    "vehicle_type_name": "Motorcycle",
    "service_location": "home",
    "address": "123, MG Road, Bangalore, Karnataka - 560001",
    "appointment_date": "2025-11-01",
    "appointment_time": "10:00:00",
    "total_amount": "1300.00",
    "payment_method": "cash",
    "payment_status": "pending",
    "booking_status": "pending",
    "notes": "Please call before arriving",
    "booking_services": [
      {