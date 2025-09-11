import 'package:flutter_test/flutter_test.dart';
import 'package:jr_case_boilerplate/core/data/models/upload_photo_response_model.dart';
import 'package:jr_case_boilerplate/core/data/repositories/upload_photo_repository.dart';
import 'package:jr_case_boilerplate/core/data/services/upload_photo_service.dart';
import 'package:mocktail/mocktail.dart';


class MockUploadPhotoService extends Mock implements UploadPhotoService {}

void main() {
  late MockUploadPhotoService mockService;
  late UploadPhotoRepository repository;

  setUp(() {
    mockService = MockUploadPhotoService();
    repository = UploadPhotoRepository(mockService);
  });

  final response = UploadPhotoResponseModel(
    photoUrl: 'https://image.com/photo.jpg',
    message: 'Uploaded',
  );

  test('başarılı: uploadPhoto servisi doğru dönüyor', () async {
    when(() => mockService.uploadPhoto('photo.jpg'))
        .thenAnswer((_) async => response);

    final result = await repository.uploadPhoto('photo.jpg');

    expect(result.photoUrl, 'https://image.com/photo.jpg');
    expect(result.message, 'Uploaded');
    verify(() => mockService.uploadPhoto('photo.jpg')).called(1);
  });

  test('başarısız: uploadPhoto servisi hata fırlatıyor', () async {
    when(() => mockService.uploadPhoto('photo.jpg'))
        .thenThrow(Exception('Upload failed'));

    expect(() => repository.uploadPhoto('photo.jpg'), throwsA(isA<Exception>()));
    verify(() => mockService.uploadPhoto('photo.jpg')).called(1);
  });
}
