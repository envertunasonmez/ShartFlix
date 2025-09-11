import 'package:flutter_test/flutter_test.dart';
import 'package:jr_case_boilerplate/core/data/models/favorite_response_model.dart';

void main() {
  group('FavoriteResponseModel fromJson', () {
    
    test('başarılı: doğru JSON ile model oluşturulmalı', () {
      final json = {
        "success": true,
        "message": "Favori başarıyla eklendi"
      };

      final model = FavoriteResponseModel.fromJson(json);

      expect(model.success, true); 
      expect(model.message, "Favori başarıyla eklendi"); 
    });

    test('başarısız: eksik veya hatalı alanlarla oluşturulmalı', () {
      final json = {
        "success": false,
      };

      final model = FavoriteResponseModel.fromJson(json);

      expect(model.success, false); 
      expect(model.message, isNot("Favori başarıyla eklendi")); 
      expect(model.message, ""); 
    });
  });
}
