import 'package:flutter_test/flutter_test.dart';
import 'package:jr_case_boilerplate/core/data/models/user_profile_response_model.dart';

void main() {
  group('UserProfileResponseModel fromJson', () {
    test('başarılı: tüm alanlar mevcut', () {
      final json = {
        'data': {
          'id': '123',
          'name': 'Enver',
          'email': 'enver@example.com',
          'photoUrl': 'https://example.com/photo.png',
        }
      };

      final model = UserProfileResponseModel.fromJson(json);

      expect(model.id, '123');
      expect(model.name, 'Enver');
      expect(model.email, 'enver@example.com');
      expect(model.photoUrl, 'https://example.com/photo.png');
    });

    test('başarısız/eksik alanlar: default değerler atanıyor', () {
      final json = {'data': {}};

      final model = UserProfileResponseModel.fromJson(json);

      expect(model.id, '');
      expect(model.name, '');
      expect(model.email, '');
      expect(model.photoUrl, '');
    });
  });

  group('UserProfileResponseModel toJson', () {
    test('toJson doğru map oluşturuyor', () {
      final model = UserProfileResponseModel(
        id: '123',
        name: 'Enver',
        email: 'enver@example.com',
        photoUrl: 'https://example.com/photo.png',
      );

      final map = model.toJson();

      expect(map['id'], '123');
      expect(map['name'], 'Enver');
      expect(map['email'], 'enver@example.com');
      expect(map['photoUrl'], 'https://example.com/photo.png');
    });
  });
}
