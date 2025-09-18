import 'dart:developer';

import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:animated_read_more_text/animated_read_more_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techmart/core/utils/price_formater.dart';
import 'package:techmart/core/utils/text_util.dart/capitalizse_text.dart';
import 'package:techmart/core/widgets/button_widgets.dart';
import 'package:techmart/core/widgets/custem_appbar.dart';
import 'package:techmart/core/widgets/snakbar_widgert.dart';
import 'package:techmart/core/widgets/spacing_widget.dart';
import 'package:techmart/features/cart/bloc/cart_bloc.dart';
import 'package:techmart/features/cart/cubit/cart_cubit.dart';
import 'package:techmart/features/cart/model/product_cart_model.dart';
import 'package:techmart/features/home_page/bloc/product_bloc.dart';
import 'package:techmart/features/home_page/features/image_preview/widgets/image_corosal.dart';
import 'package:techmart/features/home_page/models/peoduct_model.dart';
import 'package:techmart/features/home_page/models/product_variet_model.dart';
import 'package:techmart/features/home_page/presentation/screens/add_to_cart.dart';
import 'package:techmart/features/home_page/presentation/screens/detailed_pageing_loading.dart';
import 'package:techmart/features/home_page/presentation/screens/ratings_card.dart';
import 'package:techmart/features/home_page/presentation/screens/single_varient_detailed_page.dart';
import 'package:techmart/features/home_page/presentation/widgets/add_to_cart_widget.dart';
import 'package:techmart/features/home_page/presentation/widgets/favorites_detail_page.dart';
import 'package:techmart/features/home_page/presentation/widgets/multivarients_product.dart';
import 'package:techmart/features/home_page/presentation/widgets/product_corosel_widget.dart';
import 'package:techmart/features/home_page/presentation/widgets/rating_count_widget.dart';
import 'package:techmart/features/home_page/presentation/widgets/varient_button.dart';
import 'package:techmart/features/home_page/service/product_service.dart';
import 'package:techmart/features/home_page/utils/product_color_util.dart';
import 'package:techmart/features/home_page/utils/text_util.dart';
import 'package:techmart/features/rating/presentation/widget/rating_widget.dart';
import 'package:techmart/features/wishlist/cubit/wishlist_cubit.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductVarientModel? varientModel;
  const ProductDetailScreen({super.key, this.varientModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: custemAppbar(heading: "Details", context: context),
      body: BlocListener<CartBloc, CartState>(
        listener: (context, state) {
          if (state is CartAdded) {
            custemSnakbar(
              context: context,
              message: "Product added to cart",
              color: Colors.green,
            );
          }
        },
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is! ProductLoadSuccess) {
              return ProductDetailsShimmer(varientModel: varientModel);
            }

            final product = state.product;
            final selectedVariant = state.selectedVariant;
            final rating = state.rating;

            if (state.vairents.length == 1) {
              final singleVariant = state.vairents.first;

              return SingleVarientDetailedPage(
                singleVariant: singleVariant,
                product: product,
                rating: rating,
              );
            }

            final variantGroups = ProductUtils.groupVariants(state.vairents);

            final effectiveVariant = ProductUtils.getEffectiveVariant(
              variantGroups,
              selectedVariant,
              state.vairents,
            );

            return MultiVarientsPage(
              effectiveVariant: effectiveVariant,
              product: product,
              rating: rating,
              variantGroups: variantGroups,
            );
          },
        ),
      ),
      bottomNavigationBar: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is! ProductLoadSuccess) {
            return SizedBox.shrink();
          }

          final product = state.product;
          final effectiveVariant = ProductUtils.getEffectiveVariant(
            ProductUtils.groupVariants(state.vairents),
            state.selectedVariant,
            state.vairents,
          );

          return AddToCartWidget(
            effectiveVariant: effectiveVariant,
            product: product,
            state: state,
          );
        },
      ),
    );
  }
}
