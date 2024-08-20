import 'package:dio/dio.dart';

import 'package:resumecraft/config.dart';
import 'package:resumecraft/models/login/login_request_model.dart';
import 'package:resumecraft/models/login/login_response_model.dart';
import 'package:resumecraft/models/register/register_request_model.dart';
import 'package:resumecraft/models/register/register_response_model.dart';

class APIService {
  static final Dio _dio = Dio();

  static Future<LoginResponseModel> login(
      LoginRequestModel requestModel) async {
    try {
      final response = await _dio.post(
        '${Config.apiUrl}${Config.login}',
        data: requestModel.toJson(),
      );
      return LoginResponseModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }

  static Future<RegisterResponseModel> register(
      RegisterRequestModel requestModel) async {
    try {
      final response = await _dio.post(
        '${Config.apiUrl}${Config.register}',
        data: requestModel.toJson(),
      );
      return RegisterResponseModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to register: $e');
    }
  }

  static Future<dynamic> getUserProfile(String token) async {
    try {
      final response = await _dio.get(
        '${Config.apiUrl}${Config.userProfile}',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to get user profile: $e');
    }
  }
}
