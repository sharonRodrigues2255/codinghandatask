
import 'package:coding_hands_task/controller/homepage.dart';
import 'package:coding_hands_task/helpers/constants/spaces.dart';
import 'package:coding_hands_task/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BrandFilterWidget extends ConsumerWidget {
  const BrandFilterWidget({
    super.key,
    required this.brands,
    required this.selectedBrand,
    required this.products
  });

  final List<String?> brands;
  final String? selectedBrand;
  final List<Product> products;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: brands.length,
          itemBuilder: ((context, index) {
            final brand = brands[index];
            return Row(
              children: [
                InkWell(
                  onTap: () {
                    ref
                        .read(HomePageProvider.selectedBrand.notifier)
                        .update((state) => brand);

                    if (brand?.toLowerCase() != 'all') {
                      final updateditems = products.where((element) =>
                          element.brand?.toLowerCase() == brand?.toLowerCase());
                      ref
                          .read(HomePageProvider.products.notifier)
                          .update((state) => updateditems.toList());
                    } else {
                      ref
                          .read(HomePageProvider.products.notifier)
                          .update((state) => products);
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color:
                            selectedBrand?.toLowerCase() != brand?.toLowerCase()
                                ? Colors.white
                                : Colors.blue[100],
                        border: Border.all(
                            width: 2,
                            color: selectedBrand?.toLowerCase() !=
                                    brand?.toLowerCase()
                                ? Colors.grey[300]!
                                : Colors.transparent),
                        borderRadius: BorderRadius.circular(15)),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 1,
                    ),
                    child: Center(
                        child: Text(
                      brand ?? "",
                      style: const TextStyle(fontSize: 12),
                    )),
                  ),
                ),
                kwidth10,
              ],
            );
          })),
    );
  }
}
