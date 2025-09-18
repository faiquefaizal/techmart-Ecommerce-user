import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techmart/core/utils/price_formater.dart';
import 'package:techmart/features/home_page/bloc/product_bloc.dart';
import 'package:techmart/features/home_page/features/image_preview/cubit/image_index_cubit.dart';
import 'package:techmart/features/home_page/models/peoduct_model.dart';
import 'package:techmart/features/home_page/models/product_variet_model.dart';
import 'package:techmart/features/home_page/presentation/screens/product_detailed_screen.dart';
import 'package:techmart/features/home_page/presentation/widgets/favorite_button_widget.dart';
import 'package:techmart/features/home_page/presentation/widgets/loading_product_card.dart';
import 'package:techmart/features/home_page/service/product_service.dart';
import 'package:techmart/features/home_page/utils/product_color_util.dart';
import 'package:techmart/features/home_page/utils/text_util.dart';
import 'package:techmart/features/wishlist/cubit/wishlist_cubit.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ProductVarientModel>>(
      future: ProductService.getVariantsForProduct(product.productId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return loadingCardShimmer(context);
        }
        final variantList = snapshot.data;

        final variant = variantList!.first;
        final regularPrice = variant.regularPrice;
        final sellingPrice = variant.sellingPrice;
        final discount =
            ProductUtils.calculateDiscountFromSellingAndBuyongPrice(
              variant.sellingPrice,
              variant.buyingPrice,
            );

        return InkWell(
          splashColor: Colors.grey[200],

          borderRadius: BorderRadius.circular(16),
          onTap: () {
            final indexCubic = context.read<ImageIndexCubit>();
            Navigator.of(context).push(
              MaterialPageRoute(
                builder:
                    (context) => MultiBlocProvider(
                      providers: [
                        BlocProvider.value(value: indexCubic),
                        BlocProvider(
                          create:
                              (_) => ProductBloc()..add(ProductLoaded(product)),
                        ),
                      ],
                      child: ProductDetailScreen(varientModel: variant),
                    ),
              ),
            );
          },
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(
                              context,
                            ).shadowColor.withOpacity(0.2),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),

                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Hero(
                          tag: variant.variantImageUrls!.first,
                          child: Material(
                            type: MaterialType.transparency,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.network(
                                variant.variantImageUrls!.first,
                                height: 150,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    height: 150,
                                    width: double.infinity,
                                    color: Colors.grey[200],
                                    child: const Icon(Icons.image, size: 50),
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
                      product.productName[0].toUpperCase() +
                          product.productName.substring(1),
                      style: TextStyle(fontFamily: "GeneralSans", fontSize: 20),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          formatIndianPrice((product.minPrice.toInt())),

                          style: CustomTextStyles.homeSellingPrice,
                        ),
                        if (regularPrice <= sellingPrice) SizedBox(width: 2),
                        Text(
                          '-$discount%',
                          style: GoogleFonts.inter(
                            color: Colors.green,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
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
                child: BlocBuilder<WishlistCubit, WishlistState>(
                  builder: (context, state) {
                    bool isWishList = false;
                    if (state is WishlistLoaded) {
                      log("stast is called");
                      isWishList = state.isWishList(
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
            ],
          ),
        );
      },
    );
  }
}
