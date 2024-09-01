import 'package:dio/dio.dart';

//====================== api-endpoints ===========================>
import 'package:resumecraft/config.dart';
import 'package:resumecraft/models/delete/delete_model.dart';

//====================== profile-sections ===========================>
import 'package:resumecraft/models/profile_section/skills/write/skill_request_model.dart';
import 'package:resumecraft/models/profile_section/skills/write/skill_response_model.dart';

class SkillAPIService {
  static final Dio _dio = Dio();

  //====================== profile-sections (authenticated) ===========================>

  static Future<dynamic> getSkill(String token, String skillID) async {
    try {
      final response = await _dio.get(
        '${Config.apiUrl}${Config.skillByID}$skillID',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to the selected skill');
    }
  }

  static Future<dynamic> getSkills(String token) async {
    try {
      final response = await _dio.get(
        '${Config.apiUrl}${Config.getSkills}',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to get skills: $e');
    }
  }

  static Future<SkillResponseModel> updateSkill(
      SkillRequestModel requestModel, String token, String skillID) async {
    try {
      final response = await _dio.put(
        '${Config.apiUrl}${Config.skillByID}$skillID',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
        data: requestModel.toJson(),
      );
      return SkillResponseModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to update the skill: $e');
    }
  }

  static Future<DeleteModel> deleteSkill(
      DeleteModel requestModel, String token, skillID) async {
    try {
      final response = await _dio.delete(
        '${Config.apiUrl}${Config.skillByID}$skillID',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
        data: requestModel.toJson(),
      );

      return DeleteModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to delete skill: $e');
    }
  }

  static Future<dynamic> getSkillsByPersonalDetail(
      String token, String personalDetailID) async {
    try {
      final response = await _dio.get(
        '${Config.apiUrl}${Config.skillsByPersonalDetail}$personalDetailID',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to get the selected skill: $e');
    }
  }

  static Future<SkillResponseModel> createSkill(
      SkillRequestModel requestModel, String token) async {
    try {
      final response = await _dio.post(
        '${Config.apiUrl}${Config.createSkill}',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
        data: requestModel.toJson(),
      );
      return SkillResponseModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to create skill: $e');
    }
  }
}
