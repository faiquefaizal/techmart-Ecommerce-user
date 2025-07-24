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
import 'package:techmart/features/cart/bloc/cart_bloc.dart';
import 'package:techmart/features/cart/cubit/cart_cubit.dart';
import 'package:techmart/features/cart/model/product_cart_model.dart';
import 'package:techmart/features/home_page/bloc/product_bloc.dart';
import 'package:techmart/features/home_page/features/image_preview/widgets/image_corosal.dart';
import 'package:techmart/features/home_page/models/peoduct_model.dart';
import 'package:techmart/features/home_page/models/product_variet_model.dart';
import 'package:techmart/features/home_page/presentation/screens/add_to_cart.dart';
import 'package:techmart/features/home_page/presentation/widgets/favorites_detail_page.dart';
import 'package:techmart/features/home_page/presentation/widgets/product_corosel_widget.dart';
import 'package:techmart/features/home_page/presentation/widgets/varient_button.dart';
import 'package:techmart/features/home_page/service/product_service.dart';
import 'package:techmart/features/home_page/utils/product_color_util.dart';
import 'package:techmart/features/home_page/utils/text_util.dart';
import 'package:techmart/features/wishlist_page/cubit/wishlist_cubit.dart';

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
              return Center(
                child: Hero(
                  tag: varientModel!.variantImageUrls!.first,
                  child: Image.network(
                    varientModel!.variantImageUrls!.first,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }

            final product = state.product;
            final selectedVariant = state.selectedVariant;

            final discount =
                ProductUtils.calculateDiscountFromSellingAndBuyongPrice(
                  selectedVariant.sellingPrice,
                  selectedVariant.buyingPrice,
                );

            if (state.vairents.length == 1) {
              final singleVariant = state.vairents.first;
              print(
                'Single Variant: variantAttributes=${singleVariant.variantAttributes}, variantImageUrls=${singleVariant.variantImageUrls}',
              );

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          // ProductCarouselWidget(
                          //   imageUrls: singleVariant.variantImageUrls,
                          // ),
                          ProductCarouselWidgetUpdated(
                            imageUrls: singleVariant.variantImageUrls,
                          ),
                          Positioned(
                            top: 22,
                            right: 22,
                            child: BlocBuilder<WishlistCubit, WishlistState>(
                              builder: (context, state) {
                                bool isWishList = false;
                                if (state is WishlistLoaded) {
                                  isWishList = state.isWishList(
                                    product.productId,
                                    singleVariant.varientId!,
                                  );
                                }

                                return favorites_detailPage_button(
                                  isWishList: isWishList,
                                  product: product,
                                  singleVariant: singleVariant,
                                );
                              },
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),
                      Text(
                        captilize(product.productName),
                        style: CustomTextStyles.productName,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            formatIndianPrice(singleVariant.regularPrice),
                            style: CustomTextStyles.regularPrice,
                          ),
                          if (singleVariant.regularPrice <
                              singleVariant.sellingPrice) ...[
                            const SizedBox(width: 8),
                            Text(
                              formatIndianPrice(singleVariant.sellingPrice),
                              style: CustomTextStyles.sellingPrice,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '$discount% OFF',
                              style: CustomTextStyles.discount,
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 16),
                      ...singleVariant.variantAttributes.entries.map((entry) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            '${entry.key}: ${entry.value}',
                            style: CustomTextStyles.variantAttribute,
                          ),
                        );
                      }),
                      SizedBox(height: 16),
                      Text(
                        'Product Description',
                        style: CustomTextStyles.sectionTitle,
                      ),
                      const SizedBox(height: 8),
                      AnimatedReadMoreText(
                        product.productDescription,
                        maxLines: 2,

                        textStyle: CustomTextStyles.description,
                        buttonTextStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),

                      BlocBuilder<CartBloc, CartState>(
                        builder: (context, state) {
                          bool isInCart = false;
                          if (state is CartLoaded) {
                            isInCart = state.isCartAdded(
                              singleVariant.varientId!,
                              product.productId,
                            );
                          }
                          return CustemButton(
                            Label: isInCart ? 'Go to Cart' : 'Add to Cart',
                            onpressed: () {
                              if (!isInCart) {
                                final ProductCartModel cartModel =
                                    ProductCartModel(
                                      productName: product.productName,
                                      productId: product.productId,
                                      varientId: singleVariant.varientId!,
                                      quatity: 1,
                                      regularPrice:
                                          singleVariant.regularPrice.toString(),
                                      sellingPrice:
                                          singleVariant.sellingPrice.toString(),
                                      varientAttribute:
                                          singleVariant.variantAttributes,
                                      imageUrl:
                                          singleVariant.variantImageUrls!.first,
                                    );
                                context.read<CartBloc>().add(
                                  AddToCartEvent(cartModel: cartModel),
                                );
                              }
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            }

            final variantGroups = ProductUtils.groupVariants(state.vairents);

            final effectiveVariant = ProductUtils.getEffectiveVariant(
              variantGroups,
              selectedVariant,
              state.vairents,
            );

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
                                          effectiveVariant.varientId!,
                                        );
                                  },
                                ),
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
                      style: CustomTextStyles.productName,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        AnimatedFlipCounter(
                          value: effectiveVariant.regularPrice,
                          thousandSeparator: ",",
                          prefix: '₹',
                          textStyle: CustomTextStyles.regularPrice,

                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeOut,
                        ),
                        const SizedBox(width: 8),
                        AnimatedFlipCounter(
                          value: effectiveVariant.sellingPrice,
                          thousandSeparator: ",",
                          prefix: '₹',
                          textStyle: CustomTextStyles.sellingPrice,

                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        ),
                        const SizedBox(width: 8),
                        AnimatedFlipCounter(
                          duration: Duration(milliseconds: 500),
                          value: discount,
                          suffix: "% off",
                          textStyle: CustomTextStyles.discount,
                        ),
                      ],
                    ),
                    if (effectiveVariant.regularPrice > 100)
                      Text(
                        "Free Delivery",
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    const SizedBox(height: 16),
                    ...variantGroups.entries.map((entry) {
                      final attributeName = entry.key;
                      final valueToVariants = entry.value;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Choose ${attributeName[0].toUpperCase()}${attributeName.substring(1)}',
                            style: CustomTextStyles.sectionTitle,
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            children:
                                valueToVariants.entries.map((valueEntry) {
                                  final value = valueEntry.key;
                                  final variants = valueEntry.value;
                                  // Select the first variant for this value as the representative
                                  final representativeVariant = variants
                                      .firstWhere(
                                        (v) =>
                                            v.variantAttributes[attributeName] ==
                                            value,
                                        orElse: () => variants.first,
                                      );

                                  return Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: varient_button_widget(
                                      variants: variants,
                                      effectiveVariant: effectiveVariant,
                                      representativeVariant:
                                          representativeVariant,
                                      value: value,
                                    ),
                                  );
                                }).toList(),
                          ),
                          const SizedBox(height: 16),
                        ],
                      );
                    }),
                    Text(
                      'Product Description',
                      style: CustomTextStyles.sectionTitle,
                    ),
                    const SizedBox(height: 8),
                    AnimatedReadMoreText(
                      product.productDescription,
                      maxLines: 2,

                      textStyle: CustomTextStyles.description,
                      buttonTextStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),

                    BlocBuilder<CartBloc, CartState>(
                      builder: (context, state) {
                        bool isInCart = false;
                        if (state is CartLoaded) {
                          isInCart = state.isCartAdded(
                            effectiveVariant.varientId!,
                            product.productId,
                          );
                        }
                        return AddToCart(
                          isInCart: isInCart,
                          product: product,
                          effectiveVariant: effectiveVariant,
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
