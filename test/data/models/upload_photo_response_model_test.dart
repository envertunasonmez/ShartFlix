import 'package:flutter_test/flutter_test.dart';
import 'package:jr_case_boilerplate/core/data/models/upload_photo_response_model.dart';

void main() {
  group('UploadPhotoResponseModel fromJson', () {
    test('başarılı: tüm alanlar mevcut', () {
      final json = {
        "photoUrl": "https://example.com/photo.jpg",
        "message": "Yükleme başarılı",
      };

      final model = UploadPhotoResponseModel.fromJson(json);

      expect(model.photoUrl, "https://example.com/photo.jpg");
      expect(model.message, "Yükleme başarılı");
    });

    test('başarısız: eksik alanlarda default değerler alınmalı', () {
      final json = {
        // 'photoUrl' ve 'message' eksik
      };

      final model = UploadPhotoResponseModel.fromJson(json);

      expect(model.photoUrl, ''); // default değer
      expect(model.message, '');  // default değer
    });
  });
}
