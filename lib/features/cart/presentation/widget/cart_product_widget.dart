import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techmart/features/cart/cubit/cart_cubit.dart';
import 'package:techmart/features/cart/model/product_cart_model.dart';
import 'package:techmart/features/home_page/utils/product_color_util.dart';

class CustemProductCard extends StatelessWidget {
  ProductCartModel cartModel;
  CustemProductCard({super.key, required this.cartModel});

  @override
  Widget build(BuildContext context) {
    final dicount = ProductUtils.calculateDiscountFromSellingAndBuyongPrice(
      int.parse(cartModel.sellingPrice),
      int.parse(cartModel.regularPrice),
    );
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.grey, // Border color
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.grey[200],
                image: DecorationImage(
                  image: NetworkImage(cartModel.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 16.0),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min, // Use min to wrap content
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        cartModel.productName,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          context.read<CartCubit>().deleteFromCart(
                            cartModel.cartId!,
                          );
                        },
                        child: const Icon(Icons.delete, color: Colors.red),
                      ),
                    ],
                  ),

                  Text(
                    cartModel.varientAttribute.entries
                        .map((value) => "${value.key} ${value.value}")
                        .join(","),
                    style: TextStyle(fontSize: 14.0, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 12.0),
                  Row(
                    children: [
                      Text(
                        cartModel.regularPrice,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        cartModel.sellingPrice,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      if (dicount > 0)
                        Text(
                          dicount.toString(),
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 12.0),
                  // Quantity controls
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.remove,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                context.read<CartCubit>().decreaseQuatity(
                                  cartModel.cartId!,
                                );
                              },
                            ),
                            Text(
                              cartModel.quatity.toString(),
                              style: const TextStyle(
                                fontSize: 16.0,
                                color: Colors.white,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add, color: Colors.white),
                              onPressed: () {
                                context.read<CartCubit>().increaseQuatity(
                                  cartModel.cartId!,
                                  cartModel.productId,
                                  cartModel.varientId,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
