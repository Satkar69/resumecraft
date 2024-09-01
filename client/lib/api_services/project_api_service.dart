import 'package:dio/dio.dart';

//====================== api-endpoints ===========================>
import 'package:resumecraft/config.dart';

//====================== profile-sections ===========================>
import 'package:resumecraft/models/delete/delete_model.dart';
import 'package:resumecraft/models/profile_section/projects/write/project_request_model.dart';
import 'package:resumecraft/models/profile_section/projects/write/project_response_model.dart';

class ProjectAPIService {
  static final Dio _dio = Dio();

  //====================== profile-sections (authenticated) ===========================>

  static Future<dynamic> getProject(String token, String projectID) async {
    try {
      final response = await _dio.get(
        '${Config.apiUrl}${Config.projectByID}$projectID',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to the selected project');
    }
  }

  static Future<dynamic> getProjects(String token) async {
    try {
      final response = await _dio.get(
        '${Config.apiUrl}${Config.getProjects}',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to get projects: $e');
    }
  }

  static Future<ProjectResponseModel> updateProject(
      ProjectRequestModel requestModel, String token, String projectID) async {
    try {
      final response = await _dio.put(
        '${Config.apiUrl}${Config.projectByID}$projectID',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
        data: requestModel.toJson(),
      );
      return ProjectResponseModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to update the education: $e');
    }
  }

  static Future<DeleteModel> deleteProject(
      DeleteModel requestModel, String token, projectID) async {
    try {
      final response = await _dio.delete(
        '${Config.apiUrl}${Config.projectByID}$projectID',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
        data: requestModel.toJson(),
      );

      return DeleteModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to delete project: $e');
    }
  }

  static Future<dynamic> getProjectsByPersonalDetail(
      String token, String personalDetailID) async {
    try {
      final response = await _dio.get(
        '${Config.apiUrl}${Config.projectsByPersonalDetail}$personalDetailID',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to get the selected project: $e');
    }
  }

  static Future<ProjectResponseModel> createProject(
      ProjectRequestModel requestModel, String token) async {
    try {
      final response = await _dio.post(
        '${Config.apiUrl}${Config.createProject}',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
        data: requestModel.toJson(),
      );
      return ProjectResponseModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to create project: $e');
    }
  }
}
