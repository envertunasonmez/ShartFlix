import 'package:flutter_test/flutter_test.dart';
import 'package:jr_case_boilerplate/core/data/models/user_profile_response_model.dart';
import 'package:jr_case_boilerplate/core/data/repositories/profile_repository.dart';
import 'package:jr_case_boilerplate/core/data/services/profile_service.dart';
import 'package:mocktail/mocktail.dart';

class MockProfileService extends Mock implements ProfileService {}

void main() {
  late MockProfileService mockService;
  late ProfileRepository repository;

  setUp(() {
    mockService = MockProfileService();
    repository = ProfileRepository(mockService);
  });

  final userProfile = UserProfileResponseModel(
    id: '1',
    name: 'Enver',
    email: 'enver@test.com',
    photoUrl: 'https://image.com/photo.jpg',
  );

  test('başarılı: getProfile servisi doğru dönüyor', () async {
    when(() => mockService.getProfile()).thenAnswer((_) async => userProfile);

    final result = await repository.getProfile();

    expect(result.name, 'Enver');
    verify(() => mockService.getProfile()).called(1);
  });

  test('başarısız: getProfile servisi hata fırlatıyor', () async {
    when(() => mockService.getProfile()).thenThrow(Exception('Failed'));

    expect(() => repository.getProfile(), throwsA(isA<Exception>()));
    verify(() => mockService.getProfile()).called(1);
  });

  test('başarılı: updateProfile servisi doğru dönüyor', () async {
    final data = {'name': 'New Name'};
    when(() => mockService.updateProfile(data)).thenAnswer((_) async => userProfile);

    final result = await repository.updateProfile(data);

    expect(result.name, 'Enver'); // mock response
    verify(() => mockService.updateProfile(data)).called(1);
  });

  test('başarısız: updateProfile servisi hata fırlatıyor', () async {
    final data = {'name': 'New Name'};
    when(() => mockService.updateProfile(data)).thenThrow(Exception('Failed'));

    expect(() => repository.updateProfile(data), throwsA(isA<Exception>()));
    verify(() => mockService.updateProfile(data)).called(1);
  });
}
