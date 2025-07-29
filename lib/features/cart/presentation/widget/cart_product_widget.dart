import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techmart/core/utils/price_formater.dart';
import 'package:techmart/core/utils/text_util.dart/capitalizse_text.dart';
import 'package:techmart/core/widgets/custem_alrert_dialog.dart';
import 'package:techmart/features/cart/bloc/cart_bloc.dart';
import 'package:techmart/features/cart/model/product_cart_model.dart';
import 'package:techmart/features/home_page/utils/product_color_util.dart';
import 'package:techmart/features/home_page/utils/text_util.dart';

class CustomProductCard extends StatelessWidget {
  final ProductCartModel cartModel;

  const CustomProductCard({super.key, required this.cartModel});

  @override
  Widget build(BuildContext context) {
    double cardSized = 130;
    final discount = ProductUtils.calculateDiscountFromSellingAndBuyongPrice(
      int.parse(cartModel.sellingPrice),
      int.parse(cartModel.regularPrice),
    );

    return SizedBox(
      height: cardSized,
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey.shade100),
          borderRadius: BorderRadius.circular(12.0),
        ),
        margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        color: Colors.white,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8.0),
                      // border: Border.all(color: Colors.grey, width: 1),
                      image: DecorationImage(
                        image: NetworkImage(cartModel.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          captilize(cartModel.productName),
                          textHeightBehavior: TextHeightBehavior(
                            applyHeightToFirstAscent: false,
                            applyHeightToLastDescent: false,
                          ),
                          style: Theme.of(context).textTheme.labelSmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),

                        Text(
                          cartModel.varientAttribute.entries
                              .map((value) => "${value.key}: ${value.value}")
                              .join(" • "),
                          style: const TextStyle(
                            fontSize: 12.0,
                            color: Colors.black54,
                          ),
                        ),

                        // FittedBox(
                        //   child: Row(
                        //     children: [
                        //       Text(
                        //         '₹${cartModel.sellingPrice}',
                        //         style: const TextStyle(
                        //           fontSize: 18.0,
                        //           fontWeight: FontWeight.bold,
                        //           color: Colors.black,
                        //         ),
                        //       ),
                        //       const SizedBox(width: 8.0),

                        //       Text(
                        //         '₹${cartModel.regularPrice}',
                        //         style: const TextStyle(
                        //           fontSize: 14.0,
                        //           color: Colors.black54,
                        //           decoration: TextDecoration.lineThrough,
                        //         ),
                        //         overflow: TextOverflow.ellipsis,
                        //       ),
                        //       const SizedBox(width: 8.0),

                        //       if (discount > 0)
                        //         Container(
                        //           padding: const EdgeInsets.symmetric(
                        //             horizontal: 6,
                        //             vertical: 2,
                        //           ),
                        //           decoration: BoxDecoration(
                        //             color: Colors.black.withAlpha(25),
                        //             borderRadius: BorderRadius.circular(4),
                        //           ),
                        //           child: Text(
                        //             '$discount% OFF',
                        //             style: const TextStyle(
                        //               fontSize: 12.0,
                        //               color: Colors.black87,
                        //               fontWeight: FontWeight.bold,
                        //             ),
                        //             overflow: TextOverflow.ellipsis,
                        //           ),
                        //         ),
                        //     ],
                        //   ),
                        // ),
                        Spacer(),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                formatIndianPrice(
                                  int.parse(cartModel.sellingPrice),
                                ),
                                style: CustomTextStyles.cartCardPrice,
                              ),
                              Spacer(),
                              Container(
                                height: 35,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  border: Border.all(color: Colors.black26),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.remove, size: 15),
                                      color: Colors.white,
                                      onPressed: () {
                                        context.read<CartBloc>().add(
                                          DecreaseQtyEvent(cartModel),
                                        );
                                      },
                                    ),
                                    Container(
                                      width: 10,
                                      alignment: Alignment.center,
                                      child: Text(
                                        cartModel.quatity.toString(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.add, size: 15),
                                      color: Colors.white,
                                      onPressed: () {
                                        context.read<CartBloc>().add(
                                          IncreaseQtyEvent(cartModel),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: -4,
              top: -2,
              child: IconButton(
                onPressed: () {
                  showDeleteConfirmationDialog(
                    context,
                    () {
                      context.read<CartBloc>().add(
                        DeleteFromCartEvent(cartModel.cartId!),
                      );
                    },
                    "Cart Removed",
                    Colors.red,
                  );
                },
                icon: Icon(Icons.delete_outline_outlined, color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
