import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techmart/core/widgets/custem_appbar.dart';
import 'package:techmart/features/home_page/bloc/product_bloc.dart';
import 'package:techmart/features/home_page/features/image_preview/cubit/image_index_cubit.dart';
import 'package:techmart/features/home_page/models/peoduct_model.dart';
import 'package:techmart/features/home_page/models/product_variet_model.dart';
import 'package:techmart/features/home_page/presentation/screens/loading_product_card.dart';
import 'package:techmart/features/wishlist_page/presentation/screens/empty_wishlist_screen.dart';
import 'package:techmart/features/home_page/presentation/screens/product_detailed_screen.dart';
import 'package:techmart/features/home_page/service/product_service.dart';
import 'package:techmart/features/home_page/utils/product_color_util.dart';
import 'package:techmart/features/home_page/utils/text_util.dart';
import 'package:techmart/features/wishlist_page/cubit/wishlist_cubit.dart';
import 'package:techmart/features/wishlist_page/service/wishlistservice.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishlistCubit, WishlistState>(
      builder: (context, state) {
        if (state is WishlistInitial) {
          return loadingShimmerGrid();
        }
        if (state is EmptyWishlistState) {
          return EmptyWishlistScreen();
        } else if (state is wishlistError) {
          log(state.error);
        }
        if (state is WishlistLoaded) {
          return Scaffold(
            appBar: custemAppbar(heading: "Favorites", context: context),
            body: Padding(
              padding: const EdgeInsets.all(12),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  crossAxisCount: 2,
                  childAspectRatio: 0.65, // Maintain aspect ratio
                ),
                itemCount: state.wishList.length,
                itemBuilder: (context, index) {
                  final wislist = state.wishList[index];

                  return FutureBuilder(
                    future: WishlistService.getProductFromId(wislist.productId),

                    builder: (context, asyncSnapshot) {
                      if (asyncSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return loadingCardShimmer(context);
                      }
                      log("id ${asyncSnapshot.data?.productId.toString()}");

                      final product = asyncSnapshot.data;
                      return FutureBuilder<List<ProductVarientModel>>(
                        future: ProductService.getVariantsForProduct(
                          product!.productId,
                        ),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return loadingCardShimmer(context);
                          }

                          final variantList = snapshot.data!;
                          if (variantList.isEmpty) return const SizedBox();

                          final variant = variantList.firstWhere(
                            (v) => v.varientId == wislist.varientId,
                          );
                          final regularPrice = variant.regularPrice;
                          final sellingPrice = variant.sellingPrice;
                          final discount = ProductUtils.calculateDiscount(
                            variant,
                          );

                          return GestureDetector(
                            onTap: () {
                              final indexCubic =
                                  context.read<ImageIndexCubit>();
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder:
                                      (context) => MultiBlocProvider(
                                        providers: [
                                          BlocProvider.value(value: indexCubic),
                                          BlocProvider(
                                            create:
                                                (_) =>
                                                    ProductBloc()..add(
                                                      ProductLoaded(product),
                                                    ),
                                          ),
                                        ],
                                        child: ProductDetailScreen(
                                          varientModel: variant,
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
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        spreadRadius: 2,
                                        blurRadius: 3,
                                        offset: const Offset(0, 0),
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
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
                                                  size: 50,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          product.productName,
                                          style:
                                              CustomTextStyles.homeProductName,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              '₹$regularPrice',
                                              style:
                                                  CustomTextStyles
                                                      .homeSellingPrice,
                                            ),
                                            const SizedBox(width: 2),
                                            if (regularPrice >
                                                sellingPrice) ...[
                                              Text(
                                                '₹$sellingPrice',
                                                style:
                                                    CustomTextStyles
                                                        .sellingPrice,
                                              ),
                                              const SizedBox(width: 1),
                                              Text(
                                                '$discount% off',
                                                style:
                                                    CustomTextStyles
                                                        .homeDiscount,
                                              ),
                                            ],
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 17,
                                  right: 17,
                                  child:
                                      BlocBuilder<WishlistCubit, WishlistState>(
                                        builder: (context, state) {
                                          bool isWishList = false;
                                          if (state is WishlistLoaded) {
                                            log("stast is called");
                                            isWishList = state.isWishList(
                                              product.productId,
                                              variant.varientId!,
                                            );
                                            log(isWishList.toString());
                                          }

                                          return Container(
                                            decoration: BoxDecoration(
                                              color:
                                                  (isWishList)
                                                      ? const Color.fromARGB(
                                                        255,
                                                        245,
                                                        227,
                                                        230,
                                                      )
                                                      : Colors.white,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(15),
                                              ),
                                            ),
                                            height: 40,
                                            width: 40,
                                            child: IconButton(
                                              icon:
                                                  (isWishList)
                                                      ? Icon(
                                                        Icons.favorite,
                                                        color: Colors.red,
                                                      )
                                                      : Icon(
                                                        Icons.favorite_border,
                                                        color: Colors.black,
                                                      ),
                                              onPressed: () {
                                                context
                                                    .read<WishlistCubit>()
                                                    .toggleWishList(
                                                      product.productId,
                                                      variant.varientId!,
                                                    );
                                              },
                                            ),
                                          );
                                        },
                                      ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
