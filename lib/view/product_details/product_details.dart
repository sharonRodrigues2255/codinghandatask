import 'package:coding_hands_task/controller/products_details.dart';
import 'package:coding_hands_task/helpers/constants/spaces.dart';
import 'package:coding_hands_task/helpers/constants/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductDetails extends ConsumerWidget {
  const ProductDetails({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaHeight = MediaQuery.of(context).size.height / 3;
    return Scaffold(
        body: ref.watch(ProductDetailsController.productProvider).when(
            data: (product) {
              return Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: mediaHeight,
                        decoration: BoxDecoration(
                         
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(product.images!.first),
                          ),
                        ),
                      ),
                        Container(
      height: mediaHeight,
      color: Colors.black.withOpacity(0.3), 
    ),

                     

                      Positioned(
                        top: 45,
                        left: 15,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child:
                              const Icon(Icons.arrow_back, color: Colors.white),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(22.0),
                    child: SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                        width: MediaQuery.of(context).size.width - 159,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                              fontSize: 14, color: Colors.grey),
                                        ),
                                        kwidth10,
                                        const CircleAvatar(
                                          radius: 3,
                                          backgroundColor: Colors.grey,
                                        ),
                                        Text(
                                          '${product.discountPercentage}% off',
                                          style: const TextStyle(
                                              fontSize: 14, color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
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
                                    style: const TextStyle(color: Colors.black),
                                  )
                                ],
                              )
                            ],
                          ),
                          kheight20,
                          SizedBox(
                              width: MediaQuery.of(context).size.width - 50,
                              child: Text(
                                product.description ?? "",
                                textAlign: TextAlign.justify,
                                style: const TextStyle(fontWeight: FontWeight.w400),
                                maxLines: 100,
                              ))
                        ],
                      ),
                    ),
                  )
                ],
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
