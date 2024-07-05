import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:homease/core/models/complaint.dart';

import 'package:homease/core/models/news_model.dart';
import 'package:homease/core/models/post_model.dart';
import 'package:homease/core/models/profile_model.dart';
import 'package:homease/core/models/payment_model.dart';
import 'package:homease/core/models/user_model.dart';
import 'package:homease/core/services/getStorage.dart';

class ApiService {
  final Dio _dio = Dio();

  final String baseUrl = 'https://ce52-154-121-16-130.ngrok-free.app/api/tickets';
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
        List<Payment> payments =
            data.map((payment) => Payment.fromJson(payment)).toList();
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
  Future<void> updatePayment(int id, Payment updatedPayment) async {
    final url = 'http://homease.tech/api/payments/$id';
    String? token = gsService.getToken();

    print('Attempting to update payment with URL: $url'); // Debug print
    print('Token: $token'); // Debug print
    print('Updated Payment Data: ${updatedPayment.toJson()}'); // Debug print

    try {
      Response response = await _dio.put(
        url,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500; // Accept all responses with status code < 500
          },
        ),
        data: updatedPayment.toJson(),
      );

      if (response.statusCode == 200) {
        // Handle success
        print('Payment updated successfully');
      } else if (response.statusCode == 302) {
        // Handle redirect
        final location = response.headers['location']?.first;
        if (location != null) {
          Response newResponse = await _dio.put(
            location,
            options: Options(
              headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer $token',
              },
            ),
            data: updatedPayment.toJson(),
          );

          if (newResponse.statusCode == 200) {
            print('Payment updated successfully after redirect');
          } else {
            throw Exception(
                'Failed to update payment after redirect: ${newResponse.statusCode}');
          }
        } else {
          throw Exception('Redirect location not provided');
        }
      } else {
        throw Exception('Failed to update payment: ${response.statusCode}');
      }
    } catch (e) {
      print('Error updating payment: $e');
    }
  }

//////////////////////////////:create ticket//////////////////////////////////////////

Future<void> createComplaint({
  required String address,
  required String description,
  required String status,
  required String priority,
  required String category,
  File? image,
  required String token,
}) async {
  try {
    FormData createFormData() {
      return FormData.fromMap({
        'address': address,
        'description': description,
        'status': status,
        'priority': priority,
        'category': category,
        if (image != null) 
          'attachment': MultipartFile.fromFileSync(image.path),
      });
    }

    // Debugging information
    print('Creating FormData with the following details:');
    print('Address: $address');
    print('Description: $description');
    print('Status: $status');
    print('Priority: $priority');
    print('Category: $category');
    if (image != null) {
      print('Image path: ${image.path}');
    }
    print('Token: $token');
    print('Sending request to $baseUrl');

    Response response = await _dio.put(
      baseUrl, // Ensure this URL is correct and expects a POST request
      data: createFormData(),
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
        validateStatus: (status) {
          return status! < 500; // Accept all status codes below 500
        },
      ),
    );

    // Handle 302 redirection
    if (response.statusCode == 302) {
      String? redirectUrl = response.headers['location']?.first;
      if (redirectUrl != null) {
        print('Following redirection to: $redirectUrl');
        response = await _dio.post(
          redirectUrl,
          data: createFormData(),
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
            validateStatus: (status) {
              return status! < 500;
            },
          ),
        );
      }
    }

    print('Response status code: ${response.statusCode}');
    print('Response data: ${response.data}');
    print('Response headers: ${response.headers}');

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to create complaint. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error creating complaint: $e');
    rethrow;
  }
}


  /*Future<List<Complaint>> getComplaints() async {
    const String getComplaintsUrl = 'http://homease.tech/api/tickets';
    String? token = gsService.getToken();

    if (token != null) {
      try {
        Response response = await _dio.get(
          getComplaintsUrl,
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
            followRedirects: false,
            validateStatus: (status) {
              return status != null && status < 500; // Accept status codes below 500
            },
          ),
        );

        if (response.statusCode == 200) {
          List<Complaint> complaints = (response.data as List)
              .map((complaintData) => Complaint.fromJson(complaintData))
              .toList();
          return complaints;
        } else {
          throw Exception('Failed to load complaints: ${response.statusCode}');
        }
      } catch (e) {
        print('Get Complaints Error: $e');
        throw Exception('Failed to load complaints: $e');
      }
    } else {
      throw Exception('Token not found');
    }
  }*/
  //////////////////////////////////////get ticket/////////////////////////////////////////////

  Future<List<Complaint>> getComplaints() async {
    const String getComplaintsUrl = 'http://homease.tech/api/tickets';
    String? token = gsService.getToken();

    if (token != null) {
      try {
        final response = await _dio.get(
          getComplaintsUrl,
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ),
        );

        print('API Response: ${response.data}'); // Debug print

        if (response.data != null && response.data is Map<String, dynamic>) {
          var tickets = response.data['data'];
          print('Tickets: $tickets'); // Debug print
          if (tickets is List) {
            return tickets
                .map((complaint) => Complaint.fromJson(complaint))
                .toList();
          } else {
            print('Unexpected response format: tickets is not a list');
            throw Exception(
                'Unexpected response format: tickets is not a list');
          }
        } else {
          print(
              'Unexpected response format: response data is null or not a map');
          throw Exception(
              'Unexpected response format: response data is null or not a map');
        }
      } on DioError catch (dioError) {
        throw Exception(
            'Failed to load complaints: ${dioError.response?.data ?? dioError.message}');
      } catch (e) {
        throw Exception('Unexpected error: $e');
      }
    } else {
      throw Exception('Token not found');
    }
  }
  //////////////////////////////update complaint /////////////////////////////////////////////

  Future<void> updateComplaint(Complaint complaint) async {
    final String updateComplaintUrl =
        'http://homease.tech/api/tickets/${complaint.id}';
    String? token = gsService.getToken();

    if (token != null) {
      try {
        final response = await _dio.put(
          updateComplaintUrl,
          data: complaint.toJson(),
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ),
        );

        if (response.statusCode == 200) {
          print('Complaint updated successfully');
        } else {
          throw Exception(
              'Failed to update complaint: ${response.statusMessage}');
        }
      } on DioError catch (dioError) {
        print('Dio error: ${dioError.response?.data ?? dioError.message}');
        throw Exception(
            'Failed to update complaint: ${dioError.response?.data ?? dioError.message}');
      } catch (e) {
        print('Unexpected error: $e');
        throw Exception('Unexpected error: $e');
      }
    } else {
      throw Exception('Token not found');
    }
  }
}
