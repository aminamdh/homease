import 'dart:convert';

class ErrorResponse {
  String? message;

  ErrorResponse({this.message});

  static ErrorResponse fromJson(Map<String, dynamic> json) {
    final errorMessages = <ErrorResponse>[];
    json.forEach((key, value) {
      if (key == "errors") {
        Map<String, dynamic> map = Map<String, dynamic>.from(json[key]);
        map.forEach((mapKey, value) {
          errorMessages.add(ErrorResponse(message: map[mapKey][0]));
        });
      }
    });
    return errorMessages.first;
  }
}

//THE TOKEN MODEL

// To parse this JSON data, do
//
//     final tokenModel = tokenModelFromJson(jsonString);

TokenModel tokenModelFromJson(String str) =>
    TokenModel.fromJson(json.decode(str));

String tokenModelToJson(TokenModel data) => json.encode(data.toJson());

class TokenModel {
  TokenModel({
    required this.token,
  });

  String token;

  factory TokenModel.fromJson(Map<String, dynamic> json) => TokenModel(
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
      };
}
