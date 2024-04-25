import 'package:coding_hands_task/helpers/api/api.dart';
import 'package:coding_hands_task/model/product_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePageProvider {
  static final currentpage = StateProvider((ref) => 0);
  static final products = StateProvider((ref) => <Product>[]);
  static final selectedBrand = StateProvider<String?>((ref) => "all");
  static final productsProvider = FutureProvider<List<Product>>((ref) async {
    try {
      final response = await ApiConfig.dio.get(ApiConfig.products);
      if (response.statusCode == 200) {
        final data = response.data;
        ref
            .watch(products.notifier)
            .update((state) => ProductsModel.fromJson(data).products);
        return ProductsModel.fromJson(data).products;
      } else {
        throw Exception('Failed to load ');
      }
    } catch (e) {
      throw Exception('Failed to load: $e');
    }
  });
}
