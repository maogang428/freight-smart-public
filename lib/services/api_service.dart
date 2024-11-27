import 'package:dio/dio.dart';

class ApiService {
  // Singleton Instance
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  
  // Dio instance
  final Dio _dio = Dio();

  // Base URL of your API
  static const String _baseUrl = "http://localhost:5000/api/v1/mobile";

  // Private constructor to configure Dio
  ApiService._internal() {
    _dio.options.baseUrl = _baseUrl;
    _dio.options.connectTimeout = 5000 as Duration?; // 5 seconds
    _dio.options.receiveTimeout = 5000 as Duration?; // 5 seconds
    _dio.options.headers = {
      "Content-Type": "application/json",
    };
  }

  // Verify Phone
  Future<Map<String, dynamic>?> verifyPhone(String phoneNumber) async {
    try {
      final response = await _dio.post(
        "/verify",
        data: {"phoneNumber": phoneNumber},
      );
      return response.data;
    } catch (e) {
      print("Verify Phone Error: $e");
      return null;
    }
  }

  // Validate OTP
  Future<Map<String, dynamic>?> validateOtp(String phoneNumber, String otp) async {
    try {
      final response = await _dio.post(
        "/validate",
        data: {"phoneNumber": phoneNumber, "otp": otp},
      );
      return response.data;
    } catch (e) {
      print("Validate OTP Error: $e");
      return null;
    }
  }

  // Login and get AUTH_TOKEN
  Future<Map<String, dynamic>?> login(
      String phoneNumber, String preAuthToken, String tenantId) async {
    try {
      final response = await _dio.post(
        "/login",
        data: {
          "phoneNumber": phoneNumber,
          "preAuthToken": preAuthToken,
          "tenantId": tenantId,
        },
      );
      return response.data;
    } catch (e) {
      print("Login Error: $e");
      return null;
    }
  }

  // Set Token for Authenticated Requests
  void setAuthToken(String token) {
    _dio.options.headers["X-Auth-Token"] = token;
  }
}
