import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AdminApiService {
  static const String baseUrl = 'http://127.0.0.1:5000';

  static const FlutterSecureStorage _storage =
      FlutterSecureStorage();

  // =========================
  // Admin Login
  // =========================

  static Future<Map<String, dynamic>> loginAdmin({
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/admin/login'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      await _storage.write(
        key: 'admin_token',
        value: data['token'],
      );

      return data;
    }

    throw Exception(
      data['message'] ?? 'Admin login failed',
    );
  }

  // =========================
  // Get Token
  // =========================

  static Future<String?> getToken() async {
    return await _storage.read(
      key: 'admin_token',
    );
  }

  // =========================
  // Logout
  // =========================

  static Future<void> logout() async {
    await _storage.delete(
      key: 'admin_token',
    );
  }

  // =========================
  // Authorization Header
  // =========================

  static Future<Map<String, String>> _headers() async {
    final token = await getToken();

    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  // =========================
  // Dashboard
  // =========================

  static Future<Map<String, dynamic>> getDashboard() async {
    final response = await http.get(
      Uri.parse('$baseUrl/admin/dashboard'),
      headers: await _headers(),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return data;
    }

    throw Exception(
      data['message'] ?? 'Failed to load dashboard',
    );
  }

  // =========================
  // Complaints
  // =========================

  static Future<Map<String, dynamic>> getComplaints({
    String? search,
    String? status,
    String? wasteType,
    String? ward,
  }) async {
    final queryParameters = <String, String>{};

    if (search != null && search.isNotEmpty) {
      queryParameters['search'] = search;
    }

    if (status != null && status.isNotEmpty) {
      queryParameters['status'] = status;
    }

    if (wasteType != null && wasteType.isNotEmpty) {
      queryParameters['wasteType'] = wasteType;
    }

    if (ward != null && ward.isNotEmpty) {
      queryParameters['ward'] = ward;
    }

    final uri = Uri.parse(
      '$baseUrl/admin/complaints',
    ).replace(
      queryParameters: queryParameters,
    );

    final response = await http.get(
      uri,
      headers: await _headers(),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return data;
    }

    throw Exception(
      data['message'] ?? 'Failed to load complaints',
    );
  }

  // =========================
  // Get Complaint Wards
  // =========================

  static Future<List<String>> getComplaintWards() async {
    final response = await http.get(
      Uri.parse('$baseUrl/admin/complaints/wards'),
      headers: await _headers(),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return List<String>.from(
        data['wards'] ?? [],
      );
    }

    throw Exception(
      data['message'] ?? 'Failed to load wards',
    );
  }

  // =========================
  // Complaint Detail
  // =========================

  static Future<Map<String, dynamic>> getComplaintById(
    int id,
  ) async {
    final response = await http.get(
      Uri.parse('$baseUrl/admin/complaints/$id'),
      headers: await _headers(),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return data;
    }

    throw Exception(
      data['message'] ?? 'Failed to load complaint',
    );
  }

  // =========================
  // Update Complaint Status
  // =========================

  static Future<Map<String, dynamic>> updateComplaintStatus({
    required int id,
    required String status,
  }) async {
    final response = await http.patch(
      Uri.parse(
        '$baseUrl/admin/complaints/$id/status',
      ),
      headers: await _headers(),
      body: jsonEncode({
        'status': status,
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return data;
    }

    throw Exception(
      data['message'] ?? 'Failed to update complaint status',
    );
  }

  // =========================
  // Users
  // =========================

  static Future<Map<String, dynamic>> getUsers({
    String? search,
  }) async {
    final queryParameters = <String, String>{};

    if (search != null && search.isNotEmpty) {
      queryParameters['search'] = search;
    }

    final uri = Uri.parse(
      '$baseUrl/admin/users',
    ).replace(
      queryParameters: queryParameters,
    );

    final response = await http.get(
      uri,
      headers: await _headers(),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return data;
    }

    throw Exception(
      data['message'] ?? 'Failed to load users',
    );
  }

  // =========================
  // User Detail
  // =========================

  static Future<Map<String, dynamic>> getUserById(
    int id,
  ) async {
    final response = await http.get(
      Uri.parse('$baseUrl/admin/users/$id'),
      headers: await _headers(),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return data;
    }

    throw Exception(
      data['message'] ?? 'Failed to load user',
    );
  }

  // =========================
  // Waste Types
  // =========================

  static Future<Map<String, dynamic>> getWasteTypes() async {
    final response = await http.get(
      Uri.parse('$baseUrl/admin/waste-types'),
      headers: await _headers(),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return data;
    }

    throw Exception(
      data['message'] ?? 'Failed to load waste types',
    );
  }

  // =========================
  // Create Waste Type
  // =========================

  static Future<Map<String, dynamic>> createWasteType({
    required String name,
    String? description,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/admin/waste-types'),
      headers: await _headers(),
      body: jsonEncode({
        'name': name,
        'description': description,
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 201) {
      return data;
    }

    throw Exception(
      data['message'] ?? 'Failed to create waste type',
    );
  }

  // =========================
  // Update Waste Type
  // =========================

  static Future<Map<String, dynamic>> updateWasteType({
    required int id,
    required String name,
    String? description,
  }) async {
    final response = await http.put(
      Uri.parse('$baseUrl/admin/waste-types/$id'),
      headers: await _headers(),
      body: jsonEncode({
        'name': name,
        'description': description,
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return data;
    }

    throw Exception(
      data['message'] ?? 'Failed to update waste type',
    );
  }

  // =========================
  // Delete Waste Type
  // =========================

  static Future<Map<String, dynamic>> deleteWasteType(
    int id,
  ) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/admin/waste-types/$id'),
      headers: await _headers(),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return data;
    }

    throw Exception(
      data['message'] ?? 'Failed to delete waste type',
    );
  }
}