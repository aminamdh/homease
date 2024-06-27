import 'package:dio/dio.dart';
import 'package:homease/core/models/news_model.dart';
import 'package:homease/core/models/post_model.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<List<News>> fetchNews() async {
    const String url = 'http://homease.tech/api/posts';
    try {
      final response = await _dio.get(url);
      print('Fetch News Response: ${response.data}'); // Debug print
      if (response.statusCode == 200) {
        List<dynamic> data = response.data['posts'];
        return data.map((json) => News.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load posts');
      }
    } catch (e) {
      print('Fetch News Error: $e'); // Debug print
      throw Exception('Failed to load posts: $e');
    }
  }

  Future<void> addComment(int postId, String comment) async {
    final String url = 'http://homease.tech/api/posts/$postId';
    try {
      final response = await _dio.post(url, data: {
        'comment': comment,
      });
      print('Add Comment Response: ${response.data}'); // Debug print
      if (response.statusCode != 200) {
        throw Exception('Failed to add comment');
      }
    } catch (e) {
      print('Add Comment Error: $e'); // Debug print
      throw Exception('Failed to add comment: $e');
    }
  }

  Future<List<Post>> fetchPosts() async {
    const String url = 'http://homease.tech/api/properties';
    try {
      final response = await _dio.get(url);
      print('Fetch Posts Response: ${response.data}'); // Debug print
      if (response.statusCode == 200) {
        List<dynamic> properties = response.data['properties'];
        return properties.map((property) => Post.fromJson(property)).toList();
      } else {
        throw Exception('Failed to load posts with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Fetch Posts Error: $e'); // Debug print
      throw Exception('Failed to load posts: $e');
    }
  }

  Future<Map<String, dynamic>> login(String username, String password) async {
    const String url = 'http://homease.tech/api/login';  // Change this to your actual login endpoint
    try {
      final response = await _dio.post(url, data: {
        'username': username,
        'password': password,
      });
      print('Login Response: ${response.data}'); // Debug print
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to login with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Login Error: $e'); // Debug print
      throw Exception('Failed to login: $e');
    }
  }
}
