import 'package:animated_read_more_text/animated_read_more_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techmart/core/utils/text_util.dart/capitalizse_text.dart';
import 'package:techmart/core/widgets/spacing_widget.dart';
import 'package:techmart/features/home_page/features/image_preview/widgets/image_corosal.dart';
import 'package:techmart/features/home_page/models/peoduct_model.dart';
import 'package:techmart/features/home_page/models/product_variet_model.dart';
import 'package:techmart/features/home_page/presentation/screens/ratings_card.dart';
import 'package:techmart/features/home_page/presentation/screens/wish_list_button.dart';
import 'package:techmart/features/home_page/presentation/widgets/rating_count_widget.dart';
import 'package:techmart/features/home_page/presentation/widgets/rating_section.dart';
import 'package:techmart/features/home_page/utils/text_util.dart';
import 'package:techmart/features/wishlist/cubit/wishlist_cubit.dart';

class SingleVarientDetailedPage extends StatelessWidget {
  const SingleVarientDetailedPage({
    super.key,
    required this.singleVariant,
    required this.product,
    required this.rating,
  });

  final ProductVarientModel singleVariant;
  final ProductModel product;
  final Map<String, dynamic>? rating;

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
                  imageUrls: singleVariant.variantImageUrls,
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
                          singleVariant.varientId!,
                        );
                      }

                      return WishListButtonIcon(
                        isWishList: isWishList,
                        product: product,
                        singleVariant: singleVariant,
                        ontap: () {
                          context.read<WishlistCubit>().toggleWishList(
                            product.productId,
                            singleVariant.varientId!,
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),
            Text(
              captilize(product.productName),
              style: TextStyle(fontFamily: "GeneralSans", fontSize: 33),
            ),
            (rating != null && (rating?["orderList"] as List).isNotEmpty)
                ? RatingCountWidget(rating: rating!)
                : SizedBox.shrink(),
            if (singleVariant.regularPrice > 1000)
              Text(
                "Free Delivery",
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.normal,
                ),
              ),

            AnimatedReadMoreText(
              product.productDescription,
              maxLines: 4,
              textStyle: CustomTextStyles.description,
              buttonTextStyle: TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
            VerticalSpaceWisget(30),
            ...singleVariant.variantAttributes.entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '${entry.key}: ',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      TextSpan(
                        text: captilize('${entry.value}'),
                        style: CustomTextStyles.variantAttributeValue,
                      ),
                    ],
                  ),
                ),
              );
            }),

            SizedBox(height: 16),
            (rating != null && (rating?["orderList"] as List).isNotEmpty)
                ? RatingSectionWidget(rating: rating)
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
