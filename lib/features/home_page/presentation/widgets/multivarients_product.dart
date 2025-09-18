import 'package:animated_read_more_text/animated_read_more_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techmart/core/utils/text_util.dart/capitalizse_text.dart';
import 'package:techmart/core/widgets/spacing_widget.dart';
import 'package:techmart/features/home_page/features/image_preview/widgets/image_corosal.dart';
import 'package:techmart/features/home_page/models/peoduct_model.dart';
import 'package:techmart/features/home_page/models/product_variet_model.dart';
import 'package:techmart/features/home_page/presentation/screens/ratings_card.dart';
import 'package:techmart/features/home_page/presentation/widgets/rating_count_widget.dart';
import 'package:techmart/features/home_page/presentation/widgets/rating_section.dart';
import 'package:techmart/features/home_page/presentation/widgets/varient_button.dart';
import 'package:techmart/features/home_page/service/product_service.dart';
import 'package:techmart/features/home_page/utils/text_util.dart';
import 'package:techmart/features/wishlist/cubit/wishlist_cubit.dart';

class MultiVarientsPage extends StatelessWidget {
  const MultiVarientsPage({
    super.key,
    required this.effectiveVariant,
    required this.product,
    required this.rating,
    required this.variantGroups,
  });

  final ProductVarientModel effectiveVariant;
  final ProductModel product;
  final Map<String, dynamic>? rating;
  final Map<String, Map<String, List<ProductVarientModel>>> variantGroups;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ProductCarouselWidgetUpdated(
                  imageUrls: effectiveVariant.variantImageUrls,
                ),
                Positioned(
                  top: 17,
                  right: 17,
                  child: BlocBuilder<WishlistCubit, WishlistState>(
                    builder: (context, state) {
                      bool isWishList = false;
                      if (state is WishlistLoaded) {
                        isWishList = state.isWishList(
                          product.productId,
                          effectiveVariant.varientId!,
                        );
                      }

                      return IconButton(
                        icon:
                            (isWishList)
                                ? Icon(Icons.favorite, color: Colors.black)
                                : Icon(
                                  Icons.favorite_border,
                                  color: Colors.black,
                                ),
                        onPressed: () {
                          context.read<WishlistCubit>().toggleWishList(
                            product.productId,
                            effectiveVariant.varientId!,
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),
            FutureBuilder<String>(
              future: ProductService.getBrandNameById(product.brandId),
              builder: (context, asyncSnapshot) {
                return Text(
                  captilize(asyncSnapshot.data),
                  style: CustomTextStyles.brandName,
                );
              },
            ),
            Text(
              captilize(product.productName),
              style: TextStyle(fontFamily: "GeneralSans", fontSize: 33),
            ),

            (rating != null)
                ? RatingCountWidget(rating: rating!)
                : SizedBox.shrink(),
            if (effectiveVariant.regularPrice > 1000)
              Text(
                "Free Delivery",
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.normal,
                ),
              ),
            // const SizedBox(height: 16),
            AnimatedReadMoreText(
              product.productDescription,
              maxLines: 4,

              textStyle: CustomTextStyles.description,
              buttonTextStyle: TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            VerticalSpaceWisget(5),

            ...variantGroups.entries.map((entry) {
              final attributeName = entry.key;
              final valueToVariants = entry.value;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Choose ${attributeName[0].toUpperCase()}${attributeName.substring(1)}',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    children:
                        valueToVariants.entries.map((valueEntry) {
                          final value = valueEntry.key;
                          final variants = valueEntry.value;
                          // Select the first variant for this value as the representative
                          final representativeVariant = variants.firstWhere(
                            (v) => v.variantAttributes[attributeName] == value,
                            orElse: () => variants.first,
                          );

                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: varient_button_widget(
                              variants: variants,
                              effectiveVariant: effectiveVariant,
                              representativeVariant: representativeVariant,
                              value: value,
                            ),
                          );
                        }).toList(),
                  ),
                  const SizedBox(height: 16),
                ],
              );
            }),
            (rating != null && (rating?["orderList"] as List).isNotEmpty)
                ? RatingSectionWidget(rating: rating)
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
