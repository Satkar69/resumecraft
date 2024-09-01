import 'package:dio/dio.dart';

//====================== api-endpoints ===========================>
import 'package:resumecraft/config.dart';

//====================== profile-sections ===========================>
import 'package:resumecraft/models/delete/delete_model.dart';
import 'package:resumecraft/models/profile_section/education/write/education_request_model.dart';
import 'package:resumecraft/models/profile_section/education/write/education_response_model.dart';

class EducationAPIService {
  static final Dio _dio = Dio();

  //====================== profile-sections (authenticated) ===========================>

  static Future<dynamic> getEducation(String token, String educationID) async {
    try {
      final response = await _dio.get(
        '${Config.apiUrl}${Config.educationByID}$educationID',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to the selected education');
    }
  }

  static Future<dynamic> getEducations(String token) async {
    try {
      final response = await _dio.get(
        '${Config.apiUrl}${Config.getEducations}',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to get educations: $e');
    }
  }

  static Future<EducationResponseModel> updateEducation(
      EducationRequestModel requestModel,
      String token,
      String educationID) async {
    try {
      final response = await _dio.put(
        '${Config.apiUrl}${Config.educationByID}$educationID',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
        data: requestModel.toJson(),
      );
      return EducationResponseModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to update the education: $e');
    }
  }

  static Future<DeleteModel> deleteEducation(
      DeleteModel requestModel, String token, educationID) async {
    try {
      final response = await _dio.delete(
        '${Config.apiUrl}${Config.educationByID}$educationID',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
        data: requestModel.toJson(),
      );

      return DeleteModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to delete education: $e');
    }
  }

  static Future<dynamic> getEducationsByPersonalDetail(
      String token, String personalDetailID) async {
    try {
      final response = await _dio.get(
        '${Config.apiUrl}${Config.educationsByPersonalDetail}$personalDetailID',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to get the selected education: $e');
    }
  }

  static Future<EducationResponseModel> createEducation(
      EducationRequestModel requestModel, String token) async {
    try {
      final response = await _dio.post(
        '${Config.apiUrl}${Config.createEducation}',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
        data: requestModel.toJson(),
      );
      return EducationResponseModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to create education: $e');
    }
  }
}
