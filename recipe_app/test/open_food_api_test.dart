import 'package:flutter_log/pages/add_remove_ingredients_page/open_food_api.dart';
import 'package:test/test.dart';

void main() {
  group('IngredientAPI', () {
    test('Valid ingredient', () async {
      final api = IngredientAPI();
      final result = await api.ingredientAPICheck('banana');
      expect(result, true);
    });

    test('Valid ingredient abbreviation', () async {
      final api = IngredientAPI();
      final result = await api.ingredientAPICheck('msg');
      expect(result, true);
    });

    test('Invalid ingredient', () async {
      // Originally wrong
      final api = IngredientAPI();
      final result = await api.ingredientAPICheck('');
      expect(result, false);
    });

    test('Invalid ingredient', () async {
      final api = IngredientAPI();
      final result = await api.ingredientAPICheck('asdfsdf');
      expect(result, false);
    });
  });
}
