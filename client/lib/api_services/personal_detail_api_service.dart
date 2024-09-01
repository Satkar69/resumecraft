import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path/path.dart' as path;
import 'package:http_parser/http_parser.dart';

//====================== api-endpoints ===========================>
import 'package:resumecraft/config.dart';

//====================== profile-sections ===========================>
import 'package:resumecraft/models/profile_section/personal_detail/write/personal_detail_request_model.dart';
import 'package:resumecraft/models/profile_section/personal_detail/write/personal_detail_response_model.dart';
import 'package:resumecraft/models/delete/delete_model.dart';

class PersonalDetailAPIService {
  static final Dio _dio = Dio();

  //====================== profile-sections (authenticated) ===========================>

  static Future<PersonalDetailResponseModel> createPersonalDetail(
      PersonalDetailRequestModel requestModel, String token) async {
    try {
      final response =
          await _dio.post('${Config.apiUrl}${Config.createPersonalDetail}',
              options: Options(
                headers: {'Authorization': 'Bearer $token'},
              ),
              data: requestModel.toJson());
      return PersonalDetailResponseModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to create user personal detail: $e');
    }
  }

  static Future<dynamic> getPersonalDetails(String token) async {
    try {
      final response = await _dio.get(
        '${Config.apiUrl}${Config.getPersonalDetails}',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to get all personal details: $e');
    }
  }

  static Future<dynamic> getPersonalDetail(
      String token, String personalDetailID) async {
    try {
      final response = await _dio.get(
        '${Config.apiUrl}${Config.personalDetailByID}$personalDetailID',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to get the selected personal detail: $e');
    }
  }

  static Future<PersonalDetailResponseModel> updatePersonalDetail(
      PersonalDetailRequestModel requestModel,
      String token,
      personalDetailID) async {
    try {
      final response = await _dio.put(
        '${Config.apiUrl}${Config.personalDetailByID}$personalDetailID',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
        data: requestModel.toJson(),
      );
      return PersonalDetailResponseModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to create user personal detail: $e');
    }
  }

  static Future<DeleteModel> deletePersonalDetail(
      DeleteModel requestModel, String token, personalDetailID) async {
    try {
      final response = await _dio.delete(
        '${Config.apiUrl}${Config.personalDetailByID}$personalDetailID',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
        data: requestModel.toJson(),
      );

      return DeleteModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to delete user personal detail: $e');
    }
  }

  static Future<dynamic> uploadProfileImage(
      File? imageFile, String token) async {
    if (imageFile == null) {
      throw Exception('No image file provided');
    }
    // Ensure the file exists
    if (!imageFile.existsSync()) {
      throw Exception('Image file does not exist');
    }

    String fileName = path.basename(imageFile.path);
    String fileExtension = path.extension(imageFile.path).toLowerCase();

    // Determine the content type based on file extension
    String mimeType;
    String mimeSubtype;

    switch (fileExtension) {
      case '.png':
        mimeType = 'image';
        mimeSubtype = 'png';
        break;
      case '.jpg':
      case '.jpeg':
        mimeType = 'image';
        mimeSubtype = 'jpeg';
        break;
      case '.gif':
        mimeType = 'image';
        mimeSubtype = 'gif';
        break;
      default:
        throw Exception('Unsupported file type');
    }

    FormData formData = FormData.fromMap({
      'resumeMedia': await MultipartFile.fromFile(
        imageFile.path,
        filename: fileName,
        contentType: MediaType(mimeType, mimeSubtype),
      ),
    });

    try {
      final response = await Dio().post(
        '${Config.apiUrl}${Config.uploadProfileImage}',
        data: formData,
        options: Options(headers: {
          'Content-Type': "multipart/form-data",
          'Authorization': 'Bearer $token',
        }),
      );

      // Debugging: Print the response data
      print('Response data: ${response.data}');
      return response.data;
    } catch (e) {
      // Debugging: Print the error
      print('Error uploading profile image: $e');
      throw Exception('Failed to upload profile image');
    }
  }
}
