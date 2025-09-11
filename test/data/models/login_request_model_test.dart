import 'package:flutter_test/flutter_test.dart';
import 'package:jr_case_boilerplate/core/data/models/login_request_model.dart';

void main() {
  group('LoginRequestModel toJson', () {
    test('başarılı: doğru verilerle JSON oluşturulmalı', () {
      final model = LoginRequestModel(
        email: 'test@example.com',
        password: '123456',
      );

      final json = model.toJson();

      expect(json['email'], 'test@example.com');
      expect(json['password'], '123456');
    });

    test('başarısız: yanlış veriler JSON\'a dönüştürülmemeli', () {
      final model = LoginRequestModel(
        email: 'wrong@example.com',
        password: 'abcdef',
      );

      final json = model.toJson();

      expect(json['email'], isNot('test@example.com'));
      expect(json['password'], isNot('123456'));
    });
  });
}
