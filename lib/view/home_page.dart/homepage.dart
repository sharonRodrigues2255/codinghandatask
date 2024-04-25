import 'package:coding_hands_task/controller/homepage.dart';
import 'package:coding_hands_task/controller/products_details.dart';
import 'package:coding_hands_task/helpers/constants/spaces.dart';
import 'package:coding_hands_task/helpers/constants/textstyle.dart';
import 'package:coding_hands_task/view/home_page.dart/widgets.dart';
import 'package:coding_hands_task/view/product_details/product_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          leading: const Stack(
            fit: StackFit.expand,
            children: [
              Icon(Icons.notifications_outlined),
              Positioned(
                  right: 15,
                  top: 15,
                  child: CircleAvatar(
                    radius: 5,
                    backgroundColor: Colors.purple,
                  ))
            ],
          ),
          centerTitle: true,
          title: Text(
            "Coding Hands",
            style: tittlefont(),
          ),
          actions: const [
            Icon(
              Icons.search,
            ),
            kwidth10
          ],
        ),
        body: ref.watch(HomePageProvider.productsProvider).when(
            skipLoadingOnRefresh: false,
            data: (products) {
              final selectedBrand = ref.watch(HomePageProvider.selectedBrand);
              final List<String?> brands = ["All"];
              final items = ref.watch(HomePageProvider.products);
              final brandList = products.map((e) => e.brand).toList().toSet();
              if (brands.length == 1) {
                brands.addAll(brandList.toList());
              }
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(22.0),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () async {
                          ref
                              .read(ProductDetailsController
                                  .selectedProductid.notifier)
                              .update((state) => products.first.id);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const ProductDetails()));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(products[0].thumbnail!))),
                          width: 328,
                          height: 180,
                        ),
                      ),
                      kheight10,
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: BrandFilterWidget(products: products,
                            brands: brands, selectedBrand: selectedBrand),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: items.length,
                            itemBuilder: (context, index) {
                              final product = items[index];
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                child: InkWell(
                                  onTap: () {
                                    ref
                                        .read(ProductDetailsController
                                            .selectedProductid.notifier)
                                        .update((state) => items[index].id);
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const ProductDetails()));
                                  },
                                  child: Stack(
                                    children: [
                                      Container(
                                        width: 328,
                                        height: 180,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                product.images!.first),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                          top: 75,
                                          child: Row(
                                            children: [
                                              kwidth10,
                                              const Icon(
                                                Icons.favorite,
                                                color: Colors.red,
                                                size: 18,
                                              ),
                                              kwidth10,
                                              Text(
                                                product.rating.toString(),
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              )
                                            ],
                                          )),
                                      Positioned(
                                        bottom: 0,
                                        left: 0,
                                        right: 0,
                                        child: Container(
                                          width: 328,
                                          padding: const EdgeInsets.all(12),
                                          height: 80,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 2,
                                                color: Colors.grey[400]!),
                                            borderRadius:
                                                const BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10)),
                                            color: Colors.white,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                product.title ?? "",
                                                style: tittlefont(),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    product.price.toString(),
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.grey),
                                                  ),
                                                  kwidth10,
                                                  const CircleAvatar(
                                                    radius: 3,
                                                    backgroundColor:
                                                        Colors.grey,
                                                  ),
                                                  kwidth10,
                                                  Text(
                                                    '${product.discountPercentage}% off',
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.grey),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) {
              return const Center(
                child: Text("Unfortunaltely an error occured"),
              );
            }));
  }
}
