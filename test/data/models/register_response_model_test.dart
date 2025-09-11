import 'package:flutter_test/flutter_test.dart';
import 'package:jr_case_boilerplate/core/data/models/register_response_model.dart';

void main() {
  group('RegisterResponseModel fromJson', () {
    test('başarılı: tüm alanlar mevcut', () {
      final json = {
        "token": "abc123",
        "user": {
          "id": "u1",
          "name": "Enver",
          "email": "enver@test.com",
        },
      };

      final model = RegisterResponseModel.fromJson(json);

      expect(model.token, "abc123");
      expect(model.user.id, "u1");
      expect(model.user.name, "Enver");
      expect(model.user.email, "enver@test.com");
    });

    test('başarısız: eksik alanlarda varsayılan değerler alınmalı', () {
      final json = {
      };

      
      final model = RegisterResponseModel.fromJson({
        "token": json["token"] ?? '',
        "user": {
          "id": json["user"]?["id"] ?? '',
          "name": json["user"]?["name"] ?? '',
          "email": json["user"]?["email"] ?? '',
        },
      });

      expect(model.token, '');
      expect(model.user.id, '');
      expect(model.user.name, '');
      expect(model.user.email, '');
    });
  });
}
