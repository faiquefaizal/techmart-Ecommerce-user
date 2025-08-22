import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:techmart/core/widgets/button_widgets.dart';
import 'package:techmart/core/widgets/cusetmrouded_button.dart';
import 'package:techmart/core/widgets/holder_widget.dart';
import 'package:techmart/core/widgets/spacing_widget.dart';
import 'package:techmart/features/home_page/bloc/product_bloc.dart';

import 'package:techmart/features/home_page/features/product_filter/cubit/filter_cubit.dart';

import 'package:techmart/features/home_page/features/product_filter/widgets/brand_choic_chips.dart';
import 'package:techmart/features/home_page/features/product_filter/widgets/price_slider_widget.dart';
import 'package:techmart/features/home_page/features/product_filter/widgets/price_sort_chip.dart';
import 'package:techmart/features/home_page/utils/text_util.dart';
import 'package:techmart/features/orders/bloc/order_bloc.dart';
import 'package:techmart/features/rating/cubit/rating_cubit.dart';
import 'package:techmart/features/rating/presentation/widget/rating_message.dart';
import 'package:techmart/features/rating/presentation/widget/rating_widget.dart';

ratingBottonSheet(BuildContext context, String id) {
  final GlobalKey<FormState> validateKey = GlobalKey<FormState>();
  final TextEditingController controller = TextEditingController();
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return BlocProvider(
        create: (context) => RatingCubit(),
        child: Builder(
          builder: (context) {
            return SingleChildScrollView(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 20,

                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    HolderWIdget(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Leave a Review",
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),

                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(Icons.close, size: 30),
                        ),
                      ],
                    ),

                    Divider(),
                    SizedBox(height: 5),
                    Text(
                      "How was your order?",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    VerticalSpaceWisget(5),
                    Text(
                      "Please give your rating and also your review.",
                      style: CustomTextStyles.description,
                    ),
                    VerticalSpaceWisget(10),
                    Align(
                      alignment: Alignment.center,
                      child: ratingWidget(context),
                    ),
                    HorizontalSpaceWisget(20),
                    ratingTextfield(validateKey),
                    VerticalSpaceWisget(15),
                    CusetmroudedButton(
                      textcolor: Colors.white,
                      Label: "Submit",
                      onpressed: () {
                        final ratingCount = context.read<RatingCubit>().state;
                        final ratingText = controller.text.trim();
                        context.read<FetchOrderBloc>().add(
                          AddRating(
                            count: ratingCount,
                            id: id,
                            message: ratingText,
                          ),
                        );
                      },
                    ),
                    VerticalSpaceWisget(15),
                  ],
                ),
              ),
            );
          },
        ),
      );
    },
    barrierColor: Colors.black.withAlpha(120),
    backgroundColor: Colors.white,
    clipBehavior: Clip.antiAlias,
  );
}
