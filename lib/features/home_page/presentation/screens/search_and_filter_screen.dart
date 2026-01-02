// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:techmart/features/home_page/bloc/product_bloc.dart';
// import 'package:techmart/features/home_page/cubit/catogory_cubic_cubit.dart';
// import 'package:techmart/features/home_page/features/product_filter/cubit/filter_cubit.dart';
// import 'package:techmart/features/home_page/models/product_variet_model.dart';
// import 'package:techmart/features/home_page/presentation/screens/product_detailed_screen.dart';
// import 'package:techmart/features/home_page/presentation/widgets/custem_search_field.dart';
// import 'package:techmart/features/home_page/service/product_service.dart';
// import 'package:techmart/features/home_page/utils/product_color_util.dart';
// import 'package:techmart/features/home_page/utils/text_util.dart';
// import 'package:techmart/features/wishlist/cubit/wishlist_cubit.dart';

// class CombinedFilterSearchScreen extends StatelessWidget {
//   CombinedFilterSearchScreen({super.key});

//   final searchController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//     final headerHeight = 30.0 + 5.0 + 50.0;
//     final availableHeight = screenHeight - headerHeight;

//     return Scaffold(
//       backgroundColor: const Color.fromARGB(172, 255, 255, 255),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text("Discover", style: Theme.of(context).textTheme.displaySmall),
//               const SizedBox(height: 5),
//               CustemSearchField(
//                 searchController: searchController,
//                 onChanged: (query) {
//                   final filterState = context.read<FilterCubit>().state;
//                   context.read<ProductBloc>().add(
//                     CombinedSearchAndFilter(
//                       query: query,
//                       filters: filterState,
//                       catagoryId:
//                           (context.read<CatogoryCubicCubit>().state
//                                   as CatagoryCubicLoaded)
//                               .selectedId,
//                     ),
//                   );
//                 },
//               ),
//               SizedBox(
//                 height: availableHeight,
//                 child: BlocBuilder<ProductBloc, ProductState>(
//                   builder: (context, state) {
//                     if (state is CombinedProductLoading) {
//                       return const Center(child: CircularProgressIndicator());
//                     }
//                     if (state is CombinedProductError) {
//                       return Center(child: Text("Error: ${state.message}"));
//                     }
//                     if (state is CombinedProductLoaded &&
//                         state.products.isEmpty) {
//                       return const Center(child: Text("Product Not Found"));
//                     }
//                     if (state is CombinedProductLoaded) {
//                       final products = state.products;
//                       return GridView.builder(
//                         gridDelegate:
//                             const SliverGridDelegateWithFixedCrossAxisCount(
//                               mainAxisSpacing: 10,
//                               crossAxisSpacing: 10,
//                               crossAxisCount: 2,
//                               childAspectRatio: 0.65,
//                             ),
//                         itemCount: products.length,
//                         itemBuilder: (context, index) {
//                           final product = products[index];
//                           return FutureBuilder<List<ProductVarientModel>>(
//                             future: ProductService.getVariantsForProduct(
//                               product.productId,
//                             ),
//                             builder: (context, snapshot) {
//                               if (!snapshot.hasData) {
//                                 return const Center(
//                                   child: CircularProgressIndicator(),
//                                 );
//                               }
//                               final variantList = snapshot.data!;
//                               if (variantList.isEmpty) return const SizedBox();
//                               final variant = variantList.first;
//                               final regularPrice = variant.regularPrice;
//                               final sellingPrice = variant.sellingPrice;
//                               final discount = ProductUtils.calculateDiscount(
//                                 variant,
//                               );
//                               return GestureDetector(
//                                 onTap: () {
//                                   Navigator.of(context).push(
//                                     MaterialPageRoute(
//                                       builder:
//                                           (context) => BlocProvider(
//                                             create:
//                                                 (_) =>
//                                                     ProductBloc()..add(
//                                                       ProductLoaded(product),
//                                                     ),
//                                             child: ProductDetailScreen(),
//                                           ),
//                                     ),
//                                   );
//                                 },
//                                 child: Stack(
//                                   children: [
//                                     Container(
//                                       width: 170,
//                                       decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         borderRadius: BorderRadius.circular(16),
//                                         boxShadow: [
//                                           BoxShadow(
//                                             color: Colors.grey,
//                                             spreadRadius: 2,
//                                             blurRadius: 3,
//                                             offset: const Offset(0, 0),
//                                           ),
//                                         ],
//                                       ),
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(12.0),
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             ClipRRect(
//                                               borderRadius:
//                                                   BorderRadius.circular(12),
//                                               child: Image.network(
//                                                 variant.variantImageUrls!.first,
//                                                 height: 150,
//                                                 width: double.infinity,
//                                                 fit: BoxFit.cover,
//                                                 errorBuilder: (
//                                                   context,
//                                                   error,
//                                                   stackTrace,
//                                                 ) {
//                                                   return Container(
//                                                     height: 150,
//                                                     width: double.infinity,
//                                                     color: Colors.grey[200],
//                                                     child: const Icon(
//                                                       Icons.image,
//                                                       size: 50,
//                                                     ),
//                                                   );
//                                                 },
//                                               ),
//                                             ),
//                                             const SizedBox(height: 10),
//                                             Text(
//                                               product.productName,
//                                               style:
//                                                   CustomTextStyles
//                                                       .homeProductName,
//                                               maxLines: 1,
//                                               overflow: TextOverflow.ellipsis,
//                                             ),
//                                             const SizedBox(height: 5),
//                                             Row(
//                                               mainAxisSize: MainAxisSize.min,
//                                               children: [
//                                                 Text(
//                                                   '₹$regularPrice',
//                                                   style:
//                                                       CustomTextStyles
//                                                           .regularPrice,
//                                                 ),
//                                                 const SizedBox(width: 2),
//                                                 if (regularPrice >
//                                                     sellingPrice) ...[
//                                                   Text(
//                                                     '₹$sellingPrice',
//                                                     style:
//                                                         CustomTextStyles
//                                                             .sellingPrice,
//                                                   ),
//                                                   const SizedBox(width: 1),
//                                                   Text(
//                                                     '$discount% off',
//                                                     style:
//                                                         CustomTextStyles
//                                                             .homeDiscount,
//                                                   ),
//                                                 ],
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                     Positioned(
//                                       top: 17,
//                                       right: 17,
//                                       child: BlocBuilder<
//                                         WishlistCubit,
//                                         WishlistState
//                                       >(
//                                         builder: (context, state) {
//                                           bool isWishList = false;
//                                           if (state is WishlistLoaded) {
//                                             isWishList = state.isWishList(
//                                               product.productId,
//                                               variant.varientId!,
//                                             );
//                                           }
//                                           return Container(
//                                             decoration: BoxDecoration(
//                                               color:
//                                                   (isWishList)
//                                                       ? const Color.fromARGB(
//                                                         255,
//                                                         245,
//                                                         227,
//                                                         230,
//                                                       )
//                                                       : Colors.white,
//                                               borderRadius:
//                                                   BorderRadius.circular(15),
//                                             ),
//                                             height: 40,
//                                             width: 40,
//                                             child: IconButton(
//                                               icon: Icon(
//                                                 isWishList
//                                                     ? Icons.favorite
//                                                     : Icons.favorite_border,
//                                                 color:
//                                                     isWishList
//                                                         ? Colors.red
//                                                         : Colors.black,
//                                               ),
//                                               onPressed: () {
//                                                 context
//                                                     .read<WishlistCubit>()
//                                                     .toggleWishList(
//                                                       product.productId,
//                                                       variant.varientId!,
//                                                     );
//                                               },
//                                             ),
//                                           );
//                                         },
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               );
//                             },
//                           );
//                         },
//                       );
//                     }
//                     return const SizedBox();
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
