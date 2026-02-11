import 'user.dart';

class LoginResponse {
  bool? status;
  String? message;
  String? token;
  User? user;
  String? redirect;

  LoginResponse({
    this.status,
    this.message,
    this.token,
    this.user,
    this.redirect,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      token: json['token'] as String?,
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      redirect: json['redirect'] as String?,
    );
  }
}