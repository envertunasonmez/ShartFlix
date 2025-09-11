import 'package:flutter_test/flutter_test.dart';
import 'package:jr_case_boilerplate/core/data/models/register_request_model.dart';

void main() {
  group('RegisterRequestModel toJson', () {
    test('başarılı: doğru JSON üretiyor', () {
      // Arrange
      final model = RegisterRequestModel(
        email: 'test@example.com',
        name: 'Enver',
        password: '123456',
      );

      // Act
      final json = model.toJson();

      // Assert
      expect(json, {
        'email': 'test@example.com',
        'name': 'Enver',
        'password': '123456',
      });
    });

    test('başarısız: eksik alanlarda boş değerler dönüyor', () {
      // Arrange:
      final model = RegisterRequestModel(email: '', name: '', password: '');

      // Act
      final json = model.toJson();

      // Assert
      expect(json['email'], '');
      expect(json['name'], '');
      expect(json['password'], '');
    });
  });
}
