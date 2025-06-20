import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:techmart/features/home_page/bloc/product_bloc.dart';
import 'package:techmart/features/home_page/models/peoduct_model.dart';
import 'package:techmart/features/home_page/presentation/screens/product_detailed_screen.dart';
import 'package:techmart/features/home_page/presentation/widgets/custem_search_field.dart';
import 'package:techmart/features/home_page/service/product_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final headerHeight =
        30.0 + 5.0 + 50.0; // Padding + SizedBox + estimated search field height
    final availableHeight = screenHeight - headerHeight;
    return Scaffold(
      body: SingleChildScrollView(
        // Make the entire screen scrollable
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min, // Limit height to content
            children: [
              Text("Discover", style: Theme.of(context).textTheme.displaySmall),
              const SizedBox(height: 5),
              const CustemSearchField(),
              SizedBox(
                // Constrain GridView height
                height: availableHeight, // 75% of screen height
                child: StreamBuilder<List<ProductModel>>(
                  stream: ProductService.getAllproducts(),
                  builder: (context, asyncSnapshot) {
                    if (asyncSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      log("waiting reached");
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (asyncSnapshot.hasError) {
                      log(asyncSnapshot.error.toString());
                      return Center(
                        child: Text('Error: ${asyncSnapshot.error}'),
                      );
                    }
                    if (!asyncSnapshot.hasData || asyncSnapshot.data!.isEmpty) {
                      log("asyncSnapshot.hasData reached");
                      return const Center(child: Text('No products available'));
                    }

                    final products = asyncSnapshot.data!;
                    log("products beire gridvidw $products");
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            crossAxisCount: 2,
                            childAspectRatio: 0.60, // Maintain aspect ratio
                          ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        log('Product $index: $product');
                        final variant = product.varients.first;

                        log('varient Data: $variant');
                        final regularPrice = variant.regularPrice;
                        final sellingPrice = variant.sellingPrice;
                        final discount =
                            (sellingPrice > 0)
                                ? ((sellingPrice - regularPrice) /
                                        sellingPrice *
                                        100)
                                    .round()
                                : 0;

                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder:
                                    (context) => BlocProvider(
                                      create:
                                          (context) =>
                                              ProductBloc()
                                                ..add(ProductLoaded(product)),
                                      child: ProductDetailScreen(),
                                    ),
                              ),
                            );
                          },
                          child: Container(
                            width: 170,
                            height: 500,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                // mainAxisSize: MainAxisSize.min,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      variant.variantImageUrls!.first,
                                      height: 150,
                                      width: double.infinity,
                                      fit: BoxFit.cover,

                                      errorBuilder: (
                                        context,
                                        error,
                                        stackTrace,
                                      ) {
                                        return Container(
                                          height: 150,
                                          width: double.infinity,
                                          color: Colors.grey[200],
                                          child: const Icon(
                                            Icons.image,
                                            color: Colors.grey,
                                            size: 50,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    product.productName,
                                    style: GoogleFonts.anton(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),

                                  const SizedBox(height: 5),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        '₹$regularPrice',
                                        style: GoogleFonts.anton(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                          letterSpacing: 0.2,
                                        ),
                                        maxLines: 1,
                                      ),
                                      const SizedBox(width: 8),

                                      if (regularPrice < sellingPrice) ...[
                                        Text(
                                          '₹$sellingPrice',
                                          style: GoogleFonts.anton(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey,

                                            decoration:
                                                TextDecoration.lineThrough,
                                          ),
                                          maxLines: 1,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          '$discount% off',
                                          style: GoogleFonts.anton(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green,
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
