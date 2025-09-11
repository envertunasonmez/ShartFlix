import 'package:flutter_test/flutter_test.dart';
import 'package:jr_case_boilerplate/core/data/models/login_response_model.dart';

void main() {
  group('LoginResponseModel fromJson', () {
    test('başarılı: doğru JSON ile model oluşturulmalı', () {
      final json = {
        "data": {
          "token": "abc123token",
          "id": "user_1",
          "name": "John Doe",
          "email": "john@example.com",
        }
      };

      final model = LoginResponseModel.fromJson(json);

      expect(model.token, 'abc123token'); 
      expect(model.user.id, 'user_1'); 
      expect(model.user.name, 'John Doe'); 
      expect(model.user.email, 'john@example.com'); 
    });

    test('başarısız: eksik veya yanlış JSON ile default değerler alınmalı', () {
      final json = {
        "data": {
          "token": null,
          "id": null,
          "name": null,
          "email": null,
        }
      };

      final model = LoginResponseModel.fromJson(json);

      expect(model.token, ''); 
      expect(model.user.id, ''); 
      expect(model.user.name, ''); 
      expect(model.user.email, '');
    });
  });
}
