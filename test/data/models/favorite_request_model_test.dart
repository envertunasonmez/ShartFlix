import 'package:flutter_test/flutter_test.dart';
import 'package:jr_case_boilerplate/core/data/models/favorite_request_model.dart';

void main() {
  group('FavoriteRequestModel toJson', () {
    test('başarılı: doğru JSON üretmeli', () {
      final model = FavoriteRequestModel(favoriteId: '123');
      final json = model.toJson();

      expect(json, isA<Map<String, dynamic>>());
      expect(json['favoriteId'], '123'); 
    });

    test('başarısız: yanlış favoriteId ile JSON üretme', () {
      final model = FavoriteRequestModel(favoriteId: '456');
      final json = model.toJson();

      expect(json['favoriteId'], isNot('123')); 
    });
  });
}
