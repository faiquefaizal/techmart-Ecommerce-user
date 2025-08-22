import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/web.dart';

import 'package:techmart/core/utils/price_formater.dart';
import 'package:techmart/core/widgets/choice_chips.dart/choicechips.dart';
import 'package:techmart/core/widgets/choice_chips.dart/cubit/selected_chips_cubit.dart';

import 'package:techmart/features/home_page/bloc/product_bloc.dart';
import 'package:techmart/features/home_page/features/banners/services/banner_service.dart';
import 'package:techmart/features/home_page/features/banners/widget/home_corosal.dart';
import 'package:techmart/features/home_page/features/image_preview/cubit/image_index_cubit.dart';
import 'package:techmart/features/home_page/features/product_filter/cubit/filter_cubit.dart';

import 'package:techmart/features/home_page/models/product_variet_model.dart';
import 'package:techmart/features/home_page/presentation/widgets/bacnner_shimmers.dart';
import 'package:techmart/features/home_page/presentation/widgets/header_widget.dart';
import 'package:techmart/features/home_page/presentation/widgets/loading_product_card.dart';
import 'package:techmart/features/home_page/presentation/screens/product_detailed_screen.dart';
import 'package:techmart/features/home_page/presentation/screens/search_not_found.dart';
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
    final headerHeight = 30.0 + 5.0 + 60.0 + 170;
    final availableHeight = screenHeight - headerHeight;
    return Scaffold(
      backgroundColor: const Color.fromARGB(172, 255, 255, 255),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderWidget(),
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
              if (searchController.text.isEmpty) ...[
                BlocProvider(
                  create: (context) => SelectedChipsCubit(),
                  child: CustemChoiceChips(),
                ),
                FutureBuilder(
                  future: BannerService.getAllBaners(),
                  builder: (context, asyncSnapshot) {
                    if (asyncSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return bannerShimmerPlaceholder();
                    }
                    final images = asyncSnapshot.data;
                    if (images == null || images.isEmpty) {
                      Logger().w("${asyncSnapshot.data.toString()}");
                      log("called ${images.toString()}");
                    }
                    return HomeCorosal(
                      imageUrls: asyncSnapshot.data?.expand((e) => e).toList(),
                    );
                  },
                ),
              ] else
                SizedBox.shrink(),

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
                      return SearchNotFound(error: state.message);
                    }
                    if (state is ProductSearchNotFound) {
                      log("search not found state callled");
                      return SearchNotFound();
                    }
                    if (state is ProductLoading) {
                      log("stateisProductLoading");
                      Logger().w("called");
                      //   return const Center(child: Text('No products available'));
                      // }

                      final products = state.products;

                      return AnimationLimiter(
                        child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisSpacing: 0,
                                crossAxisSpacing: 0,
                                crossAxisCount: 2,
                                childAspectRatio: 0.70,
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
                                              Padding(
                                                padding: const EdgeInsets.all(
                                                  12.0,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Theme.of(
                                                              context,
                                                            ).cardColor,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              12,
                                                            ),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Theme.of(
                                                                  context,
                                                                ).shadowColor
                                                                .withOpacity(
                                                                  0.2,
                                                                ),
                                                            blurRadius: 6,
                                                            offset:
                                                                const Offset(
                                                                  0,
                                                                  3,
                                                                ),
                                                          ),
                                                        ],
                                                      ),

                                                      child: ClipRRect(
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
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets.all(
                                                                    8.0,
                                                                  ),
                                                              child: Image.network(
                                                                variant
                                                                    .variantImageUrls!
                                                                    .first,
                                                                height: 150,
                                                                width:
                                                                    double
                                                                        .infinity,
                                                                fit:
                                                                    BoxFit
                                                                        .cover,
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
                                                                      Icons
                                                                          .image,
                                                                      size: 50,
                                                                    ),
                                                                  );
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    // SizedBox(height: 5),
                                                    Text(
                                                      product.productName[0]
                                                              .toUpperCase() +
                                                          product.productName
                                                              .substring(1),
                                                      style: TextStyle(
                                                        fontFamily:
                                                            "GeneralSans",
                                                        fontSize: 20,
                                                      ),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),

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
                                                        if (regularPrice <=
                                                            sellingPrice)
                                                          SizedBox(width: 2),
                                                        Text(
                                                          '-$discount%',
                                                          style:
                                                              GoogleFonts.inter(
                                                                color:
                                                                    Colors
                                                                        .green,
                                                                fontSize: 11,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                              ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Positioned(
                                                top: 20,
                                                right: 20,
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

                                                    return FavoriteButtonWidget(
                                                      isWishList: isWishList,
                                                      product: product,
                                                      variant: variant,
                                                    );
                                                  },
                                                ),
                                              ),

                                              // Positioned(
                                              //   left: 12,
                                              //   top: 12.5,
                                              //   child: dicount_widget(
                                              //     discount: discount,
                                              //   ),
                                              //   //  discount_widget(
                                              //   //   discount: discount,
                                              //   // ),
                                              // ),
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
