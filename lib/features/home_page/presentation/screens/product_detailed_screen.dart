import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techmart/core/widgets/button_widgets.dart';
import 'package:techmart/features/cart/cubit/cart_cubit.dart';
import 'package:techmart/features/home_page/bloc/product_bloc.dart';
import 'package:techmart/features/home_page/models/product_variet_model.dart';
import 'package:techmart/features/home_page/presentation/widgets/product_corosel_widget.dart';
import 'package:techmart/features/home_page/service/product_service.dart';
import 'package:techmart/features/home_page/utils/product_color_util.dart';
import 'package:techmart/features/home_page/utils/text_util.dart';
import 'package:techmart/features/wishlist_page/cubit/wishlist_cubit.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [],
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is! ProductLoadSuccess)
            return const Center(child: CircularProgressIndicator());

          final product = state.product;
          final selectedVariant = state.selectedVariant;

          final discount = ProductUtils.calculateDiscount(selectedVariant);

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
                        ProductCarouselWidget(
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
                                          singleVariant.varientId!,
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
                    Text(
                      product.productName,
                      style: CustomTextStyles.productName,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          '₹${singleVariant.sellingPrice}',
                          style: CustomTextStyles.sellingPrice,
                        ),
                        if (singleVariant.regularPrice >
                            singleVariant.sellingPrice) ...[
                          const SizedBox(width: 8),
                          Text(
                            '₹${singleVariant.regularPrice}',
                            style: CustomTextStyles.regularPrice,
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
                    Text(
                      product.productDescription,
                      style: CustomTextStyles.sectionTitle,
                    ),
                  ],
                ),
              ),
            );
          }

          // Multiple variants case
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
                      ProductCarouselWidget(
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
                                  context.read<WishlistCubit>().toggleWishList(
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
                        asyncSnapshot.data ?? "Loading..",
                        style: CustomTextStyles.brandName,
                      );
                    },
                  ),
                  Text(
                    product.productName,
                    style: CustomTextStyles.productName,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        '₹${effectiveVariant.regularPrice.toString()}',
                        style: CustomTextStyles.regularPrice,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '₹${effectiveVariant.sellingPrice.toString()}',
                        style: CustomTextStyles.sellingPrice,
                      ),
                      const SizedBox(width: 8),
                      Text('$discount% off', style: CustomTextStyles.discount),
                    ],
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
                        Row(
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
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (variants.contains(effectiveVariant)) {
                                        context.read<ProductBloc>().add(
                                          VariantSelected(effectiveVariant),
                                        );
                                      } else {
                                        context.read<ProductBloc>().add(
                                          VariantSelected(
                                            representativeVariant,
                                          ),
                                        );
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          variants.contains(effectiveVariant)
                                              ? Colors.black
                                              : Colors.grey,
                                      foregroundColor: Colors.white,
                                    ),
                                    child: Text(value),
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
                  Text(
                    product.productDescription,
                    style: CustomTextStyles.description,
                  ),
                  BlocBuilder<CartCubit, CartState>(
                    builder: (context, state) {
                      if (state is! CartLoaded) {
                        return CustemButton(
                          Label: "Add to Cart ",
                          onpressed: () {
                            context.read<CartCubit>().addToCart(
                              productId: product.productId,
                              varientId: effectiveVariant.varientId!,
                              quatity: 1,
                              regularPrice:
                                  effectiveVariant.regularPrice.toString(),
                              sellingPrice:
                                  effectiveVariant.sellingPrice.toString(),
                              varientAttribute:
                                  effectiveVariant.variantAttributes,
                              imageurl:
                                  effectiveVariant.variantImageUrls!.first,
                              productName: product.productName,
                            );
                          },
                        );
                      } else {
                        bool addedToCart = state.isCartAdded(
                          product.productId,
                          effectiveVariant.varientId!,
                        );
                        return addedToCart
                            ? CustemButton(
                              Label: "Already In Cart",
                              onpressed: () {},
                            )
                            : CustemButton(
                              Label: "Add to Cart",
                              onpressed: () {
                                context.read<CartCubit>().addToCart(
                                  productId: product.productId,
                                  varientId: effectiveVariant.varientId!,
                                  quatity: 1,
                                  regularPrice:
                                      effectiveVariant.regularPrice.toString(),
                                  sellingPrice:
                                      effectiveVariant.sellingPrice.toString(),
                                  varientAttribute:
                                      effectiveVariant.variantAttributes,
                                  imageurl:
                                      effectiveVariant.variantImageUrls!.first,
                                  productName: product.productName,
                                );
                              },
                            );
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
