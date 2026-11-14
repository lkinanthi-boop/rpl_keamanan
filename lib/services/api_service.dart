import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../config/app_config.dart';
import '../models/user.dart';
import '../models/post.dart';
import '../utils/logger.dart';

/// Service untuk komunikasi HTTP dengan REST API.
///
/// Class ini menangani semua request HTTP ke API, termasuk
/// penanganan error dan timeout.
class ApiService {
  final http.Client _client;
  final String _baseUrl;

  ApiService({http.Client? client, String? baseUrl})
    : _client = client ?? http.Client(),
      _baseUrl = baseUrl ?? AppConfig.baseUrl;

  /// Mengambil daftar pengguna dari API.
  Future<List<User>> getUsers() async {
    try {
      _logRequest('GET', '/users');

      final response = await _client
          .get(Uri.parse('$_baseUrl/users'), headers: _buildHeaders())
          .timeout(Duration(seconds: AppConfig.timeoutSeconds));

      _logResponse(response.statusCode);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => User.fromJson(json)).toList();
      } else {
        throw Exception('Gagal memuat data. Status: ${response.statusCode}');
      }
    } on TimeoutException {
      throw Exception('Request timeout. Periksa koneksi internet Anda.');
    } on SocketException {
      throw Exception('Tidak ada koneksi internet. Periksa jaringan Anda.');
    } on FormatException {
      throw Exception('Format data tidak valid.');
    } catch (e) {
      Logger.error('API Error di getUsers: $e');
      throw Exception(
        'Terjadi kesalahan pada sistem. Silakan coba lagi nanti.',
      );
    }
  }

  /// Mengambil pengguna berdasarkan ID.
  Future<User> getUserById(int id) async {
    try {
      _logRequest('GET', '/users/$id');

      final response = await _client
          .get(Uri.parse('$_baseUrl/users/$id'), headers: _buildHeaders())
          .timeout(Duration(seconds: AppConfig.timeoutSeconds));

      _logResponse(response.statusCode);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return User.fromJson(data);
      } else {
        throw Exception('Gagal memuat data. Status: ${response.statusCode}');
      }
    } on TimeoutException {
      throw Exception('Request timeout. Periksa koneksi internet Anda.');
    } on SocketException {
      throw Exception('Tidak ada koneksi internet. Periksa jaringan Anda.');
    } on FormatException {
      throw Exception('Format data tidak valid.');
    } catch (e) {
      Logger.error('API Error di getUserById: $e');
      throw Exception(
        'Terjadi kesalahan pada sistem. Silakan coba lagi nanti.',
      );
    }
  }

  /// Mengambil daftar post dari API.
  Future<List<Post>> getPosts() async {
    try {
      _logRequest('GET', '/posts');

      final response = await _client
          .get(Uri.parse('$_baseUrl/posts'), headers: _buildHeaders())
          .timeout(Duration(seconds: AppConfig.timeoutSeconds));

      _logResponse(response.statusCode);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Post.fromJson(json)).toList();
      } else {
        throw Exception(
          'Gagal memuat data post. Status: ${response.statusCode}',
        );
      }
    } on TimeoutException {
      throw Exception('Request timeout. Periksa koneksi internet Anda.');
    } on SocketException {
      throw Exception('Tidak ada koneksi internet. Periksa jaringan Anda.');
    } on FormatException {
      throw Exception('Format data post tidak valid.');
    } catch (e) {
      Logger.error('API Error di getPosts: $e');
      throw Exception(
        'Terjadi kesalahan pada sistem. Silakan coba lagi nanti.',
      );
    }
  }

  /// Membangun header untuk request HTTP.
  ///
  /// API key diambil dari konfigurasi AppConfig.
  Map<String, String> _buildHeaders() {
    return {'Content-Type': 'application/json', 'X-API-Key': AppConfig.apiKey};
  }

  /// Logging request tanpa mencetak API key.
  void _logRequest(String method, String endpoint) {
    Logger.info('[$method] $endpoint');
  }

  /// Logging response hanya menampilkan status code.
  void _logResponse(int statusCode) {
    Logger.info('Response status: $statusCode');
  }

  /// Menutup client HTTP.
  void dispose() {
    _client.close();
  }
}
