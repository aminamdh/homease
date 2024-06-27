// ignore_for_file: constant_identifier_names, duplicate_ignore, equal_keys_in_map, prefer_interpolation_to_compose_strings, avoid_print

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homease/core/config/design/theme.dart';
import 'package:homease/core/helpers/error_model.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;


// ignore: duplicate_ignore
enum RequestMethod {
  // ignore: constant_identifier_names
  GET,
  POST,
  PATCH,
  DELETE,
  PUT,
  GETWITHTOKEN,
  POSTWITHTOKEN,
  POSTMULTIDATA
}

Future<dynamic> apiRequest({
  required String url,
  required RequestMethod method,
  dynamic body,
  dynamic token,
  dynamic imgPath,
  dynamic imageName,
}) async {
  log("look the token$token");
  try {
    http.Response response;
    String baseUrl = 'https://ecom.azam.agency/';
    final Uri uri = Uri.parse(baseUrl + url);
    switch (method) {
      case RequestMethod.GET:
        response = await http.get(uri);
        //print("testtt"+response.toString());
        break;
      case RequestMethod.GETWITHTOKEN:
        response = await http.get(
          uri,
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        );
        break;
      case RequestMethod.POST:
        response = await http.post(uri, body: jsonEncode(body), headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        });
        // ignore: avoid_print
        print("Response : ${response.body}");
        break;
      case RequestMethod.POSTMULTIDATA:
        var request = http.MultipartRequest('POST', uri);
        request.headers.addAll({
          "Accept": "application/json",
          'Content-Type': 'application/json',
          'Content-Type': 'multipart/form-data',
          "Authorization": " Bearer $token"
        });

        if (imgPath != null) {
          log("img : " + imageName + imgPath);
          request.files.add(
              await http.MultipartFile.fromPath(imageName ?? "image", imgPath));
        }

        request.fields.addAll(body);

        var stremedresponse = await request.send();

        response = await http.Response.fromStream(stremedresponse);

        break;
      case RequestMethod.PATCH:
        response = await http.patch(uri, body: jsonEncode(body), headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        });
        break;

      case RequestMethod.PUT:
        response = await http.put(uri, body: jsonEncode(body));
        break;

      case RequestMethod.DELETE:
        response = await http.delete(uri);
        break;

      case RequestMethod.POSTWITHTOKEN:
        response = await http.post(uri, body: jsonEncode(body), headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        });
        break;
      default:
        response = await http.get(uri);
    }
    final jsonData = jsonDecode(response.body);
    print(jsonData);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return Future.value(jsonData);
    } else {
      log("http request err${jsonData["errors"].runtimeType}");
      if (jsonData["errors"].runtimeType == String) {
        Get.defaultDialog(
            title: "Warning".tr,
            content: Text(jsonData["errors"].toString()),
            actions: [
              MaterialButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text(
                  "OK",
                  style: TextStyle(color: AppTheme.primaryColor, fontSize: 20),
                ),
              )
            ]);
      } else {
        var err = ErrorResponse.fromJson(jsonData);
        Get.snackbar('something went wrong!!!', err.message.toString(),
            backgroundColor: Colors.red);
      }
    }
  } catch (err) {
    print("${method.name} to $url returned Helpeer ERR : $err");
  }
}
