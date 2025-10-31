import 'dart:convert';

import 'package:http/http.dart' as http;

/// A lightweight API service layer for communicating with the RepairMyBike
/// Django backend.
///
/// NOTE:
/// 1. Adjust [baseUrl] to point to the correct backend host for each
///    environment. When running the backend locally, Android emulators should
///    use `10.0.2.2` instead of `localhost`.
/// 2. Each method returns the decoded JSON body on success or throws an
///    [ApiException] on failure.
/// 3. You can extend this class with additional endpoints as needed.
class ApiService {
  /// Base URL of the backend API (update this for production accordingly).
  /// For example on local machine use: "http://127.0.0.1:8000/api/"
  /// For Android emulator use: "http://10.0.2.2:8000/api/"
  final String baseUrl;

  /// Optional default headers (e.g. for authentication tokens).
  final Map<String, String> defaultHeaders;

  const ApiService({
    required this.baseUrl,
    this.defaultHeaders = const {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  });

  // -------------------------- Service Endpoints -----------------------------

  /// Fetch all service categories.
  Future<List<dynamic>> fetchServiceCategories() async {
    final response = await http.get(Uri.parse('${baseUrl}services/service-categories/'), headers: defaultHeaders);
    return _processResponse(response) as List<dynamic>;
  }

  /// Fetch services, optionally filtered by [categoryId].
  Future<List<dynamic>> fetchServices({int? categoryId}) async {
    final query = categoryId != null ? '?category=$categoryId' : '';
    final response = await http.get(Uri.parse('${baseUrl}services/services/$query'), headers: defaultHeaders);
    return _processResponse(response) as List<dynamic>;
  }

  /// Fetch pricing details for a given [serviceId] and [vehicleModelId].
  Future<Map<String, dynamic>> fetchServicePricing({required int serviceId, required int vehicleModelId}) async {
    final response = await http.get(
      Uri.parse('${baseUrl}services/service-pricing/?service=$serviceId&vehicle_model=$vehicleModelId'),
      headers: defaultHeaders,
    );
    final data = _processResponse(response);
    if (data is List && data.isNotEmpty) {
      return data.first as Map<String, dynamic>;
    }
    throw ApiException('Pricing not found', response.statusCode, data);
  }

  // --------------------------- Booking Endpoints ----------------------------

  /// Create a new booking. Pass [payload] with required keys:
  /// {
  ///   "customer": {
  ///     "name": "John Doe",
  ///     "email": "john@example.com",
  ///     "phone": "9876543210"
  ///   },
  ///   "vehicle_model": 1, // vehicle model ID
  ///   "service_pricing": 3, // service pricing ID
  ///   "appointment_date": "2024-07-01",
  ///   "pickup_required": true,
  ///   "pickup_address": "123 Main Street"
  /// }
  Future<Map<String, dynamic>> createBooking(Map<String, dynamic> payload) async {
    final response = await http.post(
      Uri.parse('${baseUrl}bookings/bookings/'),
      headers: defaultHeaders,
      body: jsonEncode(payload),
    );
    return _processResponse(response) as Map<String, dynamic>;
  }

  /// Retrieve a booking by its [bookingId].
  Future<Map<String, dynamic>> getBooking(int bookingId) async {
    final response = await http.get(Uri.parse('${baseUrl}bookings/bookings/$bookingId/'), headers: defaultHeaders);
    return _processResponse(response) as Map<String, dynamic>;
  }

  /// List bookings, optionally filtered by [phone] or other query params.
  Future<List<dynamic>> listBookings({String? phone}) async {
    final query = phone != null ? '?phone=$phone' : '';
    final response = await http.get(Uri.parse('${baseUrl}bookings/bookings/$query'), headers: defaultHeaders);
    return _processResponse(response) as List<dynamic>;
  }

  // --------------------------- Helper Methods ------------------------------

  dynamic _processResponse(http.Response response) {
    final statusCode = response.statusCode;
    try {
      final decoded = jsonDecode(utf8.decode(response.bodyBytes));
      if (statusCode >= 200 && statusCode < 300) {
        return decoded;
      }
      throw ApiException('Request failed', statusCode, decoded);
    } catch (e) {
      throw ApiException('Invalid response format', statusCode, response.body);
    }
  }
}

/// Custom exception to provide more context on failed requests.
class ApiException implements Exception {
  final String message;
  final int statusCode;
  final dynamic details;

  ApiException(this.message, this.statusCode, [this.details]);

  @override
  String toString() => 'ApiException($statusCode): $message -> $details';
}