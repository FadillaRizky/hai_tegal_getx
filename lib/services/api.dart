import 'dart:io';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';

class ApiClient extends GetConnect {
  @override
  void onInit() {
    // Base URL for API requests - don't include trailing slash
    httpClient.baseUrl = 'https://haitegal.id';

    // Request timeout
    httpClient.timeout = const Duration(seconds: 30);

    // Add request modifiers for authentication headers 
    httpClient.addRequestModifier<dynamic>((request) {
      // For this API, we might not need authorization
      request.headers['Accept'] = 'application/json';
      request.headers['Content-Type'] = 'application/json';
      return request;
    });

    // Add response modifiers to handle common errors
    httpClient.addResponseModifier<dynamic>((request, response) {
      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');
      return response;
    });

    super.onInit();
  }

  // Custom response handler that accepts 'res: false' as valid responses
  dynamic _handleResponse(Response response) {
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      // API returns {data: [], msg: "message", res: false} for some valid responses
      // So we should return the body even when res is false
      return response.body;
    } else {
      throw ApiException(
        statusCode: response.statusCode ?? 0,
        message: response.body?['msg'] ?? 'Unknown error occurred',
      );
    }
  }

  // GET request using GetX
  Future<dynamic> getData(String endpoint) async {
    debugPrint('Fetching: ${httpClient.baseUrl}$endpoint');
    try {
      final response = await get(endpoint);
      return _handleResponse(response);
    } catch (e) {
      debugPrint('Error in getData: $e');
      rethrow;
    }
  }

  // POST request using GetX
  Future<dynamic> postData(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await post(endpoint, data);
      return _handleResponse(response);
    } catch (e) {
      debugPrint('Error in postData: $e');
      rethrow;
    }
  }

  // PUT request using GetX
  Future<dynamic> updateData(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await put(endpoint, data);
      return _handleResponse(response);
    } catch (e) {
      debugPrint('Error in updateData: $e');
      rethrow;
    }
  }

  // DELETE request using GetX
  Future<dynamic> deleteData(String endpoint) async {
    try {
      final response = await delete(endpoint);
      return _handleResponse(response);
    } catch (e) {
      debugPrint('Error in deleteData: $e');
      rethrow;
    }
  }

  // POST image upload using GetX MultipartFile
  Future<dynamic> uploadImage(String endpoint, File imageFile) async {
    try {
      final fileExtension = extension(imageFile.path).replaceAll('.', '');
      final form = FormData({
        'image': MultipartFile(
          imageFile.path,
          filename: basename(imageFile.path),
          contentType: 'image/$fileExtension',
        ),
      });

      final response = await post(endpoint, form);
      return _handleResponse(response);
    } catch (e) {
      debugPrint('Error in uploadImage: $e');
      rethrow;
    }
  }
}

// Custom exception class for API errors
class ApiException implements Exception {
  final int statusCode;
  final String message;

  ApiException({required this.statusCode, required this.message});

  @override
  String toString() => 'ApiException: [$statusCode] $message';
}
