import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techmart/core/widgets/custem_appbar.dart';
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
import 'package:techmart/features/track_order/utils/helper_funtions.dart';
import 'package:techmart/features/wishlist/cubit/wishlist_cubit.dart';
import 'package:techmart/features/wishlist/presentation/wisgets/product_card.dart';
import 'package:techmart/features/wishlist/service/wishlistservice.dart';

class LoadingFavoritesScreen extends StatelessWidget {
  final WishlistLoaded state;
  const LoadingFavoritesScreen({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: custemAppbar(heading: "Favorites", context: context),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            crossAxisCount: 2,
            childAspectRatio: 0.65,
          ),
          itemCount: state.wishList.length,
          itemBuilder: (context, index) {
            final wislist = state.wishList[index];

            return FutureBuilder(
              future: WishlistService.getProductFromId(wislist.productId),

              builder: (context, asyncSnapshot) {
                if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                  return loadingCardShimmer(context);
                }
                //       log("id ${asyncSnapshot.data?.productId.toString()}");

                final product = asyncSnapshot.data;
                return FutureBuilder<List<ProductVarientModel>>(
                  future: ProductService.getVariantsForProduct(
                    product!.productId,
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return loadingCardShimmer(context);
                    }

                    final variantList = snapshot.data!;
                    if (variantList.isEmpty) return const SizedBox();

                    final variant = variantList.firstWhere(
                      (v) => v.varientId == wislist.varientId,
                    );
                    final regularPrice = variant.regularPrice;
                    final sellingPrice = variant.sellingPrice;
                    final discount = ProductUtils.calculateDiscount(variant);

                    return GestureDetector(
                      onTap: () {
                        // final indexCubic = context.read<ImageIndexCubit>();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder:
                                (context) => MultiBlocProvider(
                                  providers: [
                                    BlocProvider(
                                      create: (context) => ImageIndexCubit(),
                                    ),
                                    BlocProvider(
                                      create:
                                          (context) =>
                                              ProductBloc()
                                                ..add(ProductLoaded(product)),
                                    ),
                                  ],
                                  child: ProductDetailScreen(
                                    varientModel: variant,
                                  ),
                                ),
                          ),
                        );
                      },
                      child: ProducrCard(
                        variant: variant,
                        product: product,
                        regularPrice: regularPrice,
                        sellingPrice: sellingPrice,
                        discount: discount,
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
}
