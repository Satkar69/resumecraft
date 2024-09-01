import 'package:dio/dio.dart';

//====================== api-endpoints ===========================>
import 'package:resumecraft/config.dart';

//====================== profile-sections ===========================>
import 'package:resumecraft/models/delete/delete_model.dart';
import 'package:resumecraft/models/profile_section/objective/write/objective_request_model.dart';
import 'package:resumecraft/models/profile_section/objective/write/objective_response_model.dart';

class ObjectiveAPIService {
  static final Dio _dio = Dio();

  //====================== profile-sections (authenticated) ===========================>

  static Future<dynamic> getObjective(String token, String objectiveID) async {
    try {
      final response = await _dio.get(
        '${Config.apiUrl}${Config.objectiveByID}$objectiveID',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to the selected objective');
    }
  }

  static Future<dynamic> getObjectives(String token) async {
    try {
      final response = await _dio.get(
        '${Config.apiUrl}${Config.getObjectives}',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to get objectives: $e');
    }
  }

  static Future<ObjectiveResponseModel> updateObjective(
      ObjectiveRequestModel requestModel,
      String token,
      String objectiveID) async {
    try {
      final response = await _dio.put(
        '${Config.apiUrl}${Config.objectiveByID}$objectiveID',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
        data: requestModel.toJson(),
      );
      return ObjectiveResponseModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to update the objective: $e');
    }
  }

  static Future<DeleteModel> deleteObjective(
      DeleteModel requestModel, String token, objectiveID) async {
    try {
      final response = await _dio.delete(
        '${Config.apiUrl}${Config.objectiveByID}$objectiveID',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
        data: requestModel.toJson(),
      );

      return DeleteModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to delete objective: $e');
    }
  }

  static Future<dynamic> getObjectivesByPersonalDetail(
      String token, String personalDetailID) async {
    try {
      final response = await _dio.get(
        '${Config.apiUrl}${Config.objectivesByPersonalDetail}$personalDetailID',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to get the selected objective: $e');
    }
  }

  static Future<ObjectiveResponseModel> createObjective(
      ObjectiveRequestModel requestModel, String token) async {
    try {
      final response = await _dio.post(
        '${Config.apiUrl}${Config.createObjective}',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
        data: requestModel.toJson(),
      );
      return ObjectiveResponseModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to create objective: $e');
    }
  }
}
