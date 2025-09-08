import 'package:dio/dio.dart';
import 'dart:io';
import '../models/upload_photo_response_model.dart';
import '../storage/token_storage.dart';

class UploadPhotoService {
  final Dio _dio = Dio(
    BaseOptions(baseUrl: "https://caseapi.servicelabs.tech/"),
  )..interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

  Future<UploadPhotoResponseModel> uploadPhoto(String photoPath) async {
    final token = await TokenStorage.getToken();
    final file = File(photoPath);
    final fileName = file.path.split('/').last;
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(file.path, filename: fileName),
    });
    final response = await _dio.post(
      "user/upload_photo",
      data: formData,
      options: Options(
        headers: {
          if (token != null && token.isNotEmpty)
            'Authorization': 'Bearer $token',
        },
      ),
    );
    return UploadPhotoResponseModel.fromJson(response.data);
  }
}
