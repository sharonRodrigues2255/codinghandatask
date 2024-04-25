import 'package:coding_hands_task/helpers/api/api.dart';
import 'package:coding_hands_task/model/product_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductDetailsController {
  static final selectedProductid = StateProvider<int?>((ref) => null);
  static final productProvider = FutureProvider<Product>((ref) async {
    try {
      final response = await ApiConfig.dio
          .get('${ApiConfig.products}/${ref.watch(selectedProductid)}');
      if (response.statusCode == 200) {
        final data = response.data;
        return Product.fromJson(data);
      } else {
        throw Exception('Failed to load ');
      }
    } catch (e) {
      throw Exception('Failed to load: $e');
    }
  });
}
