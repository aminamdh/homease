import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:homease/core/models/news_model.dart';
import 'package:homease/core/models/post_model.dart';
import 'package:homease/core/models/profile_model.dart';
import 'package:homease/core/models/payment_model.dart';
import 'package:homease/core/models/user_model.dart';
import 'package:homease/core/services/getStorage.dart';

class ApiService {
  final Dio _dio = Dio();
  final GetStorage storage = GetStorage();

//////////////////////////////////////////////////////////news////////////////////////////////////////////////
  Future<List<News>> fetchNews() async {
    const String url = 'http://homease.tech/api/posts';
    try {
      final response = await _dio.get(url);
      print('Fetch News Response: ${response.data}');
      if (response.statusCode == 200) {
        List<dynamic> data = response.data['posts'];
        return data.map((json) => News.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load posts');
      }
    } catch (e) {
      print('Fetch News Error: $e');
      throw Exception('Failed to load posts: $e');
    }
  }

////////////////////////////////////////add comments///////////////////////////////////////////////////////////////
  Future<void> addComment(int postId, String comment) async {
    final String url = 'http://homease.tech/api/posts/$postId/comments';
    try {
      final response = await _dio.post(url, data: {
        'comment': comment,
      });
      print('Add Comment Response: ${response.data}');
      if (response.statusCode != 200) {
        throw Exception('Failed to add comment');
      }
    } catch (e) {
      print('Add Comment Error: $e');
      throw Exception('Failed to add comment: $e');
    }
  }

////////////////////////////////////////////get posts///////////////////////////////////////////////////////
  Future<List<Post>> fetchPosts() async {
    const String url = 'http://homease.tech/api/properties';
    try {
      final response = await _dio.get(url);
      print('Fetch Posts Response: ${response.data}');
      if (response.statusCode == 200) {
        List<dynamic> properties = response.data['properties'];
        return properties.map((property) => Post.fromJson(property)).toList();
      } else {
        throw Exception(
            'Failed to load posts with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Fetch Posts Error: $e');
      throw Exception('Failed to load posts: $e');
    }
  }

//////////////////////////////////////////login///////////////////////////////////////////////////////////////////
  Future<Map<String, dynamic>> login(String email, String password) async {
    const String url = 'http://homease.tech/api/login';
    try {
      final response = await _dio.post(url, data: {
        'email': email,
        'password': password,
      });
      print('Login Response: ${response.data}');

      if (response.statusCode == 200) {
        String token = response.data['success']
            ['token']; // Adjust this according to your API response structure
        gsService.setToken(token);
        print(token);
        return response.data;
      } else {
        throw Exception(
            'Failed to login with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Login Error: $e');
      throw Exception('Failed to login: $e');
    }
  }

/////////////////////////////////////get profile/////////////////////////////////////////////////////////////////
  Future<Map<String, dynamic>> getProfile() async {
    const String profileUrl = 'http://homease.tech/api/profile';
    String? token = gsService.getToken();
    if (token != null) {
      print(token);
      try {
        final response = await _dio.get(
          profileUrl,
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ),
        );
        return response.data;
      } catch (e) {
        print('Get Profile Error: $e');
        throw Exception('Failed to get profile data: $e');
      }
    } else {
      throw Exception('Token not found');
    }
  }

//logout////////////////////////////////////////////////////////////////////////////////////////////
  Future<void> logout() async {
    const String logoutUrl = 'http://homease.tech/api/logout';
    String? token = gsService.getToken();
    if (token != null) {
      try {
        await _dio.post(
          logoutUrl,
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ),
        );
        gsService.deleteToken(); // Clear token
      } catch (e) {
        print('Logout Error: $e');
        throw Exception('Failed to logout: $e');
      }
    } else {
      throw Exception('Token not found');
    }
  }

  /////////////////////////////////////////////////create tickets/////////////////////////////////////////////////
  Future<Map<String, dynamic>> createTicket(
      Map<String, dynamic> ticketData) async {
    const String url = 'http://homease.tech/api/tickets';
    String? token = storage.read('token');
    if (token != null) {
      try {
        final response = await _dio.post(
          url,
          data: ticketData,
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ),
        );
        if (response.statusCode == 200) {
          return response.data;
        } else {
          throw Exception(
              'Failed to create ticket with status code: ${response.statusCode}');
        }
      } catch (e) {
        throw Exception('Failed to create ticket: $e');
      }
    } else {
      throw Exception('Token not found');
    }
  }

////////////////////////////////////////////////get payment/////////////////////////////////////////////////////////
  Future<List<Payment>> getPayments() async {
    const String Paymenturl = 'http://homease.tech/api/payments';
   
    String? token = gsService.getToken();
    if (token != null) {
      print(token);
      try {
        final response = await _dio.get(
          Paymenturl,
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ),
        );
         print('Response data: ${response.data}'); // Debug print
        List<dynamic> data = response.data as List<dynamic>;
        List<Payment> payments = data.map((payment) => Payment.fromJson(payment)).toList();
        return payments;
      } catch (e) {
        print('Error loading payments: $e'); // Debug print
        throw Exception('Failed to load payments: $e');
      }
    } else {
      print('Token not found'); // Debug print
      throw Exception('Token not found');
    }
  }
/////////////////////create payment /////////////////////////////////////////////////////////////////////////////////
  Future<Payment> createPayment(Payment payment) async {
    const String createPaymentUrl = 'http://homease.tech/api/payments';
    String? token = gsService.getToken();
    if (token != null) {
      try {
        FormData formData = FormData.fromMap(payment.toJson());
        final response = await _dio.post(
          createPaymentUrl,
          data: formData,
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ),
        );
        return Payment.fromJson(response.data);
      } catch (e) {
        print('Create Payment Error: $e');
        throw Exception('Failed to create payment: $e');
      }
    } else {
      throw Exception('Token not found');
    }
  }
///////////////////////////////////update payment //////////////////////////////////////////////////////////////
 Future<void> updatePayment(int id, Payment payment) async {
    final String url = 'http://homease.tech/api/payments/$id';
    String? token = gsService.getToken();
    if (token != null) {
      print(token);
      try {
        FormData formData = FormData.fromMap({
          'type_of_payment': payment.typeOfPayment,
          'payment_method': payment.paymentMethod,
          'bill_amount': payment.billAmount,
          if (payment.paymentProof.isNotEmpty) 'payment_proof': await MultipartFile.fromFile(payment.paymentProof, filename: 'proof.jpg'),
        });

        final response = await _dio.put(
          url,
          data: formData,
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ),
        );
        print('Response data: ${response.data}'); // Debug print
      } catch (e) {
        print('Error updating payment: $e'); // Debug print
        throw Exception('Failed to update payment: $e');
      }
    } else {
      print('Token not found'); // Debug print
      throw Exception('Token not found');
    }
  }
}
