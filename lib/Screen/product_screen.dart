import 'package:elvate/cubit/product_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/product_cubit.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Products',
        ),
      ),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          else if (state is ProductLoaded) {
            return _buildGridView(state);
          }
          else if (state is ProductError) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text('Error: ${state.error}'),

              ),
            );
          }
          return const Text('No Products Found');
        },
      ),
    );
  }

  Widget _buildGridView(ProductLoaded state) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.75,
      ),
      itemCount: state.products.length,
      itemBuilder: (context, index) {
        final products = state.products[index];
        return InkWell(
          onTap: () {
            // ProductRepository.getHttp();
          },
          child: Card(
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: Colors.blueGrey),
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Image.network(
                        products.image!,
                        // height: 120,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        (loadingProgress.expectedTotalBytes ??
                                            1)
                                    : null,
                              ),
                            );
                          }
                        },
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: IconButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 15,
                              backgroundColor: Colors.white,
                              shape: const CircleBorder()),
                          onPressed: () {},
                          icon: const Icon(Icons.favorite_border),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.all(MediaQuery.sizeOf(context).height * 0.015),
                  child: Text(
                    products.title!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.sizeOf(context).width * 0.02),
                  child: Row(
                    children: [
                      Text(
                        'EGP ${products.price!}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Text(
                      //   'EGP ${product['oldPrice']}',
                      //   style: const TextStyle(
                      //     decoration: TextDecoration.lineThrough,
                      //     color: Colors.grey,
                      //   ),
                      // ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.sizeOf(context).width * 0.02),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Text('Review (${products.rating!.rate})'),
                            const Icon(Icons.star,
                                color: Colors.yellow, size: 16),
                          ],
                        ),
                      ),
                      IconButton(
                          style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              backgroundColor: const Color(0xff00835ff)),
                          onPressed: () {},
                          icon: const Icon(Icons.add, color: Colors.white))
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
