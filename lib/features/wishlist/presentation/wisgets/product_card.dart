import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techmart/core/utils/price_formater.dart';
import 'package:techmart/features/home_page/models/peoduct_model.dart';
import 'package:techmart/features/home_page/models/product_variet_model.dart';
import 'package:techmart/features/home_page/presentation/widgets/favorite_button_widget.dart';
import 'package:techmart/features/home_page/utils/text_util.dart';
import 'package:techmart/features/wishlist/cubit/wishlist_cubit.dart';

class ProducrCard extends StatelessWidget {
  const ProducrCard({
    super.key,
    required this.variant,
    required this.product,
    required this.regularPrice,
    required this.sellingPrice,
    required this.discount,
  });

  final ProductVarientModel variant;
  final ProductModel? product;
  final int regularPrice;
  final int sellingPrice;
  final int discount;

  @override
  Widget build(BuildContext context) {
    log(product!.minPrice.runtimeType.toString());
    return Stack(
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
                      color: Theme.of(context).shadowColor.withOpacity(0.1),
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
              // SizedBox(height: 5),
              Text(
                product!.productName[0].toUpperCase() +
                    product!.productName.substring(1),
                style: TextStyle(fontFamily: "GeneralSans", fontSize: 20),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    formatIndianPrice((product!.minPrice.toInt())),

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
                isWishList = state.isWishList(
                  product!.productId,
                  variant.varientId!,
                ); // log(isWishList.toString());
              }
              return FavoriteButtonWidget(
                isWishList: isWishList,
                product: product!,
                variant: variant,
              );
            },
          ),
        ),
      ],
    );
  }
}
