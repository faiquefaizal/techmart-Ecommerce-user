import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:logger/web.dart';
import 'package:redacted/redacted.dart';
import 'package:techmart/core/utils/price_formater.dart';

import 'package:techmart/features/home_page/bloc/product_bloc.dart';
import 'package:techmart/features/home_page/features/image_preview/cubit/image_index_cubit.dart';
import 'package:techmart/features/home_page/features/product_filter/cubit/filter_cubit.dart';
import 'package:techmart/features/home_page/models/peoduct_model.dart';
import 'package:techmart/features/home_page/models/product_variet_model.dart';
import 'package:techmart/features/home_page/presentation/screens/loading_product_card.dart';
import 'package:techmart/features/home_page/presentation/screens/product_detailed_screen.dart';
import 'package:techmart/features/home_page/presentation/widgets/custem_search_field.dart';
import 'package:techmart/features/home_page/presentation/widgets/discount_widget.dart';
import 'package:techmart/features/home_page/presentation/widgets/favorite_button_widget.dart';
import 'package:techmart/features/home_page/presentation/widgets/visual_search_loading.dart';
import 'package:techmart/features/home_page/service/product_service.dart';
import 'package:techmart/features/home_page/utils/product_color_util.dart';
import 'package:techmart/features/home_page/utils/text_util.dart';
import 'package:techmart/features/wishlist_page/cubit/wishlist_cubit.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   context.read<ProductBloc>().add(SearchProduct(productName: ""));
    // });
    final screenHeight = MediaQuery.of(context).size.height;
    final headerHeight =
        30.0 + 5.0 + 50.0; // Padding + SizedBox + estimated search field height
    final availableHeight = screenHeight - headerHeight;
    return Scaffold(
      backgroundColor: const Color.fromARGB(172, 255, 255, 255),
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
              CustemSearchField(
                searchController: searchController,
                onChanged: (quary) {
                  final filter = context.read<FilterCubit>().state;
                  context.read<ProductBloc>().add(
                    CombinedSearchAndFilter(query: quary, filters: filter),
                  );
                },
              ),
              SizedBox(
                height: availableHeight,
                child: BlocConsumer<ProductBloc, ProductState>(
                  listenWhen: (previous, current) {
                    return previous is VisualSearchLoading ||
                        current is VisualSearchLoading;
                  },
                  listener: (context, state) {
                    Navigator.of(context, rootNavigator: true).maybePop();

                    if (state is VisualSearchLoading) {
                      visualSearchLoading(context);
                    }
                  },
                  builder: (context, state) {
                    if (state is ProductInitial) {
                      log("waiting reached");
                      // return const Center(child: CircularProgressIndicator());
                      return loadingShimmerGrid();
                    }
                    if (state is ProductSearchError) {
                      log("error state");
                      return Center(child: Text("Error: ${state.message}"));
                    }
                    if (state is ProductSearchNotFound) {
                      log("search not found state callled");
                      return const Center(child: Text("Product Not Found"));
                    }
                    if (state is ProductLoading) {
                      log("stateisProductLoading");
                      Logger().w("called");
                      //   return const Center(child: Text('No products available'));
                      // }

                      final products = state.products;

                      return AnimationLimiter(
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                crossAxisCount: 2,
                                childAspectRatio: 0.64, // Maintain aspect ratio
                              ),
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            final rowCount = index ~/ 2;
                            final product = products[index];
                            return AnimationConfiguration.staggeredGrid(
                              columnCount: 2,
                              position: rowCount,
                              duration: Duration(milliseconds: 1000),

                              child: ScaleAnimation(
                                scale: 0.9,

                                curve: Curves.easeOutQuart,
                                child: FadeInAnimation(
                                  child: SlideAnimation(
                                    verticalOffset: 50.0,
                                    curve: Curves.easeOutQuart,
                                    child: FutureBuilder<
                                      List<ProductVarientModel>
                                    >(
                                      future:
                                          ProductService.getVariantsForProduct(
                                            product.productId,
                                          ),
                                      builder: (context, snapshot) {
                                        if (!snapshot.hasData) {
                                          return loadingCardShimmer(context);
                                        }
                                        final variantList = snapshot.data;

                                        final variant = variantList!.first;
                                        final regularPrice =
                                            variant.regularPrice;
                                        final sellingPrice =
                                            variant.sellingPrice;
                                        final discount =
                                            ProductUtils.calculateDiscountFromSellingAndBuyongPrice(
                                              variant.sellingPrice,
                                              variant.buyingPrice,
                                            );

                                        return InkWell(
                                          splashColor: Colors.grey[200],

                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                          onTap: () {
                                            final indexCubic =
                                                context.read<ImageIndexCubit>();
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder:
                                                    (
                                                      context,
                                                    ) => MultiBlocProvider(
                                                      providers: [
                                                        BlocProvider.value(
                                                          value: indexCubic,
                                                        ),
                                                        BlocProvider(
                                                          create:
                                                              (_) =>
                                                                  ProductBloc()
                                                                    ..add(
                                                                      ProductLoaded(
                                                                        product,
                                                                      ),
                                                                    ),
                                                        ),
                                                      ],
                                                      child:
                                                          ProductDetailScreen(
                                                            varientModel:
                                                                variant,
                                                          ),
                                                    ),
                                              ),
                                            );
                                          },
                                          child: Stack(
                                            children: [
                                              Container(
                                                width: 170,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey,
                                                      spreadRadius: 2,
                                                      blurRadius: 3,
                                                      offset: const Offset(
                                                        0,
                                                        0,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                    12.0,
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              12,
                                                            ),
                                                        child: Hero(
                                                          tag:
                                                              variant
                                                                  .variantImageUrls!
                                                                  .first,
                                                          child: Material(
                                                            type:
                                                                MaterialType
                                                                    .transparency,
                                                            child: Image.network(
                                                              variant
                                                                  .variantImageUrls!
                                                                  .first,
                                                              height: 150,
                                                              width:
                                                                  double
                                                                      .infinity,
                                                              fit: BoxFit.cover,
                                                              errorBuilder: (
                                                                context,
                                                                error,
                                                                stackTrace,
                                                              ) {
                                                                return Container(
                                                                  height: 150,
                                                                  width:
                                                                      double
                                                                          .infinity,
                                                                  color:
                                                                      Colors
                                                                          .grey[200],
                                                                  child: const Icon(
                                                                    Icons.image,
                                                                    size: 50,
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        product.productName[0]
                                                                .toUpperCase() +
                                                            product.productName
                                                                .substring(1),
                                                        style: CustomTextStyles
                                                            .homeProductName
                                                            .copyWith(
                                                              fontSize: 21,
                                                            ),
                                                        maxLines: 1,
                                                        overflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                      ),
                                                      const SizedBox(height: 5),
                                                      Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Text(
                                                            formatIndianPrice(
                                                              (product.minPrice
                                                                  .toInt()),
                                                            ),

                                                            style:
                                                                CustomTextStyles
                                                                    .homeSellingPrice,
                                                          ),
                                                          const SizedBox(
                                                            width: 2,
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top: 17,
                                                right: 17,
                                                child: BlocBuilder<
                                                  WishlistCubit,
                                                  WishlistState
                                                >(
                                                  builder: (context, state) {
                                                    bool isWishList = false;
                                                    if (state
                                                        is WishlistLoaded) {
                                                      log("stast is called");
                                                      isWishList = state
                                                          .isWishList(
                                                            product.productId,
                                                            variant.varientId!,
                                                          );
                                                      // log(isWishList.toString());
                                                    }

                                                    return favrite_widget(
                                                      isWishList: isWishList,
                                                      product: product,
                                                      variant: variant,
                                                    );
                                                  },
                                                ),
                                              ),
                                              if (regularPrice <= sellingPrice)
                                                Positioned(
                                                  left: 12,
                                                  top: 12,
                                                  child: discount_widget(
                                                    discount: discount,
                                                  ),
                                                ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }
                    return SizedBox.shrink();
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
