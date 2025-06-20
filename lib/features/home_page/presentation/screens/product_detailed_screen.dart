// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:techmart/features/home_page/bloc/product_bloc.dart';
// import 'package:techmart/features/home_page/models/product_variet_model.dart';

// class ProductDetailScreen extends StatelessWidget {
//   const ProductDetailScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () => Navigator.pop(context),
//         ),
//         actions: [],
//       ),
//       body: BlocBuilder<ProductBloc, ProductState>(
//         builder: (context, state) {
//           if (state is! ProductLoadSuccess)
//             return const Center(child: CircularProgressIndicator());

//           final product = state.product;
//           final selectedVariant =
//               state.selectedVariant ?? product.varients.first;

//           if (product.varients.isEmpty) {
//             return const Center(
//               child: Text('No variants available for this product.'),
//             );
//           }

//           final discount =
//               (selectedVariant.sellingPrice > 0)
//                   ? ((selectedVariant.sellingPrice -
//                               selectedVariant.regularPrice) /
//                           selectedVariant.sellingPrice *
//                           100)
//                       .round()
//                   : 0;

//           // Handle single variant case
//           if (product.varients.length == 1) {
//             final singleVariant = product.varients.first;
//             print(
//               'Single Variant: variantAttributes=${singleVariant.variantAttributes}, variantImageUrls=${singleVariant.variantImageUrls}',
//             );

//             return SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     CarouselSlider(
//                       options: CarouselOptions(
//                         height: 300,
//                         aspectRatio: 16 / 9,
//                         viewportFraction: 1.0,
//                       ),
//                       items:
//                           singleVariant.variantImageUrls?.map((url) {
//                             return Builder(
//                               builder: (BuildContext context) {
//                                 return Image.network(
//                                   url,
//                                   fit: BoxFit.cover,
//                                   width: double.infinity,
//                                   errorBuilder: (context, error, stackTrace) {
//                                     return Container(
//                                       height: 300,
//                                       width: double.infinity,
//                                       color: Colors.grey[200],
//                                       child: const Icon(
//                                         Icons.image,
//                                         color: Colors.grey,
//                                         size: 50,
//                                       ),
//                                     );
//                                   },
//                                 );
//                               },
//                             );
//                           }).toList() ??
//                           [const Center(child: Text('No images'))],
//                     ),
//                     const SizedBox(height: 16),
//                     Text(
//                       product.productName ?? 'Unnamed Product',
//                       style: GoogleFonts.anton(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black87,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Row(
//                       children: [
//                         Text(
//                           '₹${singleVariant.sellingPrice}',
//                           style: GoogleFonts.anton(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black87,
//                           ),
//                         ),
//                         if (singleVariant.regularPrice >
//                             singleVariant.sellingPrice) ...[
//                           const SizedBox(width: 8),
//                           Text(
//                             '₹${singleVariant.regularPrice}',
//                             style: GoogleFonts.anton(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.grey,
//                               decoration: TextDecoration.lineThrough,
//                             ),
//                           ),
//                           const SizedBox(width: 8),
//                           Text(
//                             '$discount% OFF',
//                             style: GoogleFonts.anton(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.green,
//                             ),
//                           ),
//                         ],
//                       ],
//                     ),
//                     const SizedBox(height: 16),
//                     ...singleVariant.variantAttributes.entries.map((entry) {
//                       return Padding(
//                         padding: const EdgeInsets.only(bottom: 8.0),
//                         child: Text(
//                           '${entry.key}: ${entry.value ?? 'N/A'}',
//                           style: GoogleFonts.anton(
//                             fontSize: 18,
//                             color: Colors.black87,
//                           ),
//                         ),
//                       );
//                     }).toList(),
//                     const SizedBox(height: 16),
//                     Text(
//                       'Product Description',
//                       style: GoogleFonts.anton(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       product.productDescription ?? 'No description',
//                       style: GoogleFonts.anton(
//                         fontSize: 16,
//                         color: Colors.black54,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           }

//           // Multiple variants case
//           final variantGroups = <String, List<ProductVarientModel>>{};
//           for (var variant in product.varients) {
//             for (var key in variant.variantAttributes.keys) {
//               variantGroups.putIfAbsent(key, () => []).add(variant);
//             }
//           }

//           final effectiveVariant =
//               variantGroups.values.expand((v) => v).contains(selectedVariant)
//                   ? selectedVariant
//                   : product.varients.first;

//           return SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   CarouselSlider(
//                     options: CarouselOptions(
//                       height: 300,
//                       autoPlay: true,
//                       enlargeCenterPage: true,
//                       aspectRatio: 16 / 9,
//                       autoPlayCurve: Curves.fastOutSlowIn,
//                       enableInfiniteScroll: true,
//                       autoPlayAnimationDuration: const Duration(
//                         milliseconds: 800,
//                       ),
//                       viewportFraction: 1.0,
//                     ),
//                     items:
//                         effectiveVariant.variantImageUrls?.map((url) {
//                           return Builder(
//                             builder: (BuildContext context) {
//                               return Image.network(
//                                 url,
//                                 fit: BoxFit.cover,
//                                 width: double.infinity,
//                                 errorBuilder: (context, error, stackTrace) {
//                                   return Container(
//                                     height: 300,
//                                     width: double.infinity,
//                                     color: Colors.grey[200],
//                                     child: const Icon(
//                                       Icons.image,
//                                       color: Colors.grey,
//                                       size: 50,
//                                     ),
//                                   );
//                                 },
//                               );
//                             },
//                           );
//                         }).toList() ??
//                         [const Center(child: Text('No images'))],
//                   ),
//                   const SizedBox(height: 16),
//                   Text(
//                     product.productName ?? 'Unnamed Product',
//                     style: GoogleFonts.anton(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black87,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Row(
//                     children: [
//                       Text(
//                         '₹${effectiveVariant.regularPrice.toString()}',
//                         style: GoogleFonts.anton(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black87,
//                         ),
//                       ),
//                       const SizedBox(width: 8),
//                       Text(
//                         '₹${effectiveVariant.sellingPrice.toString()}',
//                         style: GoogleFonts.anton(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.grey,
//                           decoration: TextDecoration.lineThrough,
//                         ),
//                       ),
//                       const SizedBox(width: 8),
//                       Text(
//                         '$discount% off',
//                         style: GoogleFonts.anton(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.green,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 16),
//                   ...variantGroups.entries.map((entry) {
//                     final attributeName = entry.key;
//                     final variants =
//                         entry.value.toSet().toList(); // Remove duplicates
//                     if (variants.isEmpty) return const SizedBox.shrink();

//                     return Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Choose ${attributeName[0].toUpperCase()}${attributeName.substring(1)}',
//                           style: GoogleFonts.anton(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         Row(
//                           children:
//                               variants.map((variant) {
//                                 final value =
//                                     variant.variantAttributes[attributeName] ??
//                                     '';
//                                 return Padding(
//                                   padding: const EdgeInsets.only(right: 8.0),
//                                   child: ElevatedButton(
//                                     onPressed:
//                                         () => context.read<ProductBloc>().add(
//                                           VariantSelected(variant),
//                                         ),
//                                     style: ElevatedButton.styleFrom(
//                                       backgroundColor:
//                                           variant == effectiveVariant
//                                               ? Colors.black
//                                               : Colors.grey,
//                                       foregroundColor: Colors.white,
//                                     ),
//                                     child: Text(value),
//                                   ),
//                                 );
//                               }).toList(),
//                         ),
//                         const SizedBox(height: 16),
//                       ],
//                     );
//                   }),
//                   Text(
//                     'Product Description',
//                     style: GoogleFonts.anton(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     product.productDescription ?? 'No description',
//                     style: GoogleFonts.anton(
//                       fontSize: 16,
//                       color: Colors.black54,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techmart/features/home_page/bloc/product_bloc.dart';
import 'package:techmart/features/home_page/models/product_variet_model.dart';
import 'package:techmart/features/home_page/service/product_service.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [],
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is! ProductLoadSuccess)
            return const Center(child: CircularProgressIndicator());

          final product = state.product;
          final selectedVariant = state.selectedVariant;

          final discount =
              (selectedVariant.sellingPrice > 0)
                  ? ((selectedVariant.sellingPrice -
                              selectedVariant.regularPrice) /
                          selectedVariant.sellingPrice *
                          100)
                      .round()
                  : 0;

          // Handle single variant case
          if (product.varients.length == 1) {
            final singleVariant = product.varients.first;
            print(
              'Single Variant: variantAttributes=${singleVariant.variantAttributes}, variantImageUrls=${singleVariant.variantImageUrls}',
            );

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 300,
                        aspectRatio: 16 / 9,
                        viewportFraction: 1.0,
                      ),
                      items:
                          singleVariant.variantImageUrls?.map((url) {
                            return Image.network(
                              url,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  height: 300,
                                  width: double.infinity,
                                  color: Colors.grey[200],
                                  child: const Icon(
                                    Icons.image,
                                    color: Colors.grey,
                                    size: 50,
                                  ),
                                );
                              },
                            );
                          }).toList(),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      product.productName,
                      style: GoogleFonts.anton(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          '₹${singleVariant.sellingPrice}',
                          style: GoogleFonts.anton(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        if (singleVariant.regularPrice >
                            singleVariant.sellingPrice) ...[
                          const SizedBox(width: 8),
                          Text(
                            '₹${singleVariant.regularPrice}',
                            style: GoogleFonts.anton(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '$discount% OFF',
                            style: GoogleFonts.anton(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 16),
                    ...singleVariant.variantAttributes.entries.map((entry) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          '${entry.key}: ${entry.value}',
                          style: GoogleFonts.anton(
                            fontSize: 18,
                            color: Colors.black87,
                          ),
                        ),
                      );
                    }),
                    SizedBox(height: 16),
                    Text(
                      'Product Description',
                      style: GoogleFonts.anton(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      product.productDescription,
                      style: GoogleFonts.anton(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          // Multiple variants case
          final variantGroups =
              <String, Map<String, List<ProductVarientModel>>>{};
          for (var variant in product.varients) {
            for (var entry in variant.variantAttributes.entries) {
              final attributeName = entry.key;
              final attributeValue = entry.value ?? '';
              variantGroups
                  .putIfAbsent(attributeName, () => {})
                  .putIfAbsent(attributeValue, () => [])
                  .add(variant);
            }
          }

          final effectiveVariant =
              variantGroups.values
                      .expand((group) => group.values.expand((v) => v))
                      .contains(selectedVariant)
                  ? selectedVariant
                  : product.varients.first;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 300,
                      // autoPlay: true,
                      // enlargeCenterPage: true,
                      aspectRatio: 16 / 9,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: true,
                      // autoPlayAnimationDuration: const Duration(
                      //   milliseconds: 800,
                      // ),
                      viewportFraction: 1.0,
                    ),
                    items:
                        effectiveVariant.variantImageUrls?.map((url) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Image.network(
                                url,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    height: 300,
                                    width: double.infinity,
                                    color: Colors.grey[200],
                                    child: const Icon(
                                      Icons.image,
                                      color: Colors.grey,
                                      size: 50,
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        }).toList() ??
                        [const Center(child: Text('No images'))],
                  ),
                  const SizedBox(height: 16),
                  FutureBuilder<String>(
                    future: ProductService.getBrandNameById(product.brandId),
                    builder: (context, asyncSnapshot) {
                      return Text(
                        asyncSnapshot.data ?? "Loading..",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      );
                    },
                  ),
                  Text(
                    product.productName,
                    style: GoogleFonts.anton(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        '₹${effectiveVariant.regularPrice.toString()}',
                        style: GoogleFonts.anton(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '₹${effectiveVariant.sellingPrice.toString()}',
                        style: GoogleFonts.anton(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '$discount% off',
                        style: GoogleFonts.anton(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ...variantGroups.entries.map((entry) {
                    final attributeName = entry.key;
                    final valueToVariants = entry.value;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Choose ${attributeName[0].toUpperCase()}${attributeName.substring(1)}',
                          style: GoogleFonts.anton(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children:
                              valueToVariants.entries.map((valueEntry) {
                                final value = valueEntry.key;
                                final variants = valueEntry.value;
                                // Select the first variant for this value as the representative
                                final representativeVariant = variants
                                    .firstWhere(
                                      (v) =>
                                          v.variantAttributes[attributeName] ==
                                          value,
                                      orElse: () => variants.first,
                                    );

                                return Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (variants.contains(effectiveVariant)) {
                                        context.read<ProductBloc>().add(
                                          VariantSelected(effectiveVariant),
                                        );
                                      } else {
                                        context.read<ProductBloc>().add(
                                          VariantSelected(
                                            representativeVariant,
                                          ),
                                        );
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          variants.contains(effectiveVariant)
                                              ? Colors.black
                                              : Colors.grey,
                                      foregroundColor: Colors.white,
                                    ),
                                    child: Text(value),
                                  ),
                                );
                              }).toList(),
                        ),
                        const SizedBox(height: 16),
                      ],
                    );
                  }),
                  Text(
                    'Product Description',
                    style: GoogleFonts.anton(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.productDescription,
                    style: GoogleFonts.anton(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
