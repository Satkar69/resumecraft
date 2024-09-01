import 'package:dio/dio.dart';

//====================== api-endpoints ===========================>
import 'package:resumecraft/config.dart';

//====================== profile-sections ===========================>
import 'package:resumecraft/models/delete/delete_model.dart';
import 'package:resumecraft/models/profile_section/experience/write/experience_request_model.dart';
import 'package:resumecraft/models/profile_section/experience/write/experience_response_model.dart';

class ExperienceAPIService {
  static final Dio _dio = Dio();

  //====================== profile-sections (authenticated) ===========================>

  static Future<dynamic> getExperience(
      String token, String experienceID) async {
    try {
      final response = await _dio.get(
        '${Config.apiUrl}${Config.experienceByID}$experienceID',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to the selected experience');
    }
  }

  static Future<dynamic> getExperiences(String token) async {
    try {
      final response = await _dio.get(
        '${Config.apiUrl}${Config.getExperiences}',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to get experiences: $e');
    }
  }

  static Future<ExperienceResponseModel> updateExperience(
      ExperienceRequestModel requestModel,
      String token,
      String experienceID) async {
    try {
      final response = await _dio.put(
        '${Config.apiUrl}${Config.experienceByID}$experienceID',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
        data: requestModel.toJson(),
      );
      return ExperienceResponseModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to update the experience: $e');
    }
  }

  static Future<DeleteModel> deleteExperience(
      DeleteModel requestModel, String token, experienceID) async {
    try {
      final response = await _dio.delete(
        '${Config.apiUrl}${Config.experienceByID}$experienceID',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
        data: requestModel.toJson(),
      );

      return DeleteModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to delete experience: $e');
    }
  }

  static Future<dynamic> getExperiencesByPersonalDetail(
      String token, String personalDetailID) async {
    try {
      final response = await _dio.get(
        '${Config.apiUrl}${Config.experiencesByPersonalDetail}$personalDetailID',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to get the selected experience: $e');
    }
  }

  static Future<ExperienceResponseModel> createExperience(
      ExperienceRequestModel requestModel, String token) async {
    try {
      final response = await _dio.post(
        '${Config.apiUrl}${Config.createExperience}',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
        data: requestModel.toJson(),
      );
      return ExperienceResponseModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to create experience: $e');
    }
  }
}
