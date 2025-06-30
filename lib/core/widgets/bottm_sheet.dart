import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techmart/core/widgets/button_widgets.dart';
import 'package:techmart/features/home_page/features/product_filter/cubit/price_range_cubic_cubit.dart';
import 'package:techmart/features/home_page/features/product_filter/cubit/price_sort_cubit.dart';
import 'package:techmart/features/home_page/features/product_filter/widgets/price_slider_widget.dart';
import 'package:techmart/features/home_page/features/product_filter/widgets/price_sort_chip.dart';

custemBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => PriceSortCubit()),
          BlocProvider(create: (context) => PriceRangeCubicCubit()),
        ],
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  "Filter",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                SizedBox(height: 8),
                Divider(),
                SizedBox(height: 8),
                Text(
                  "Sort By",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                SizedBox(height: 8),
                PriceSortChip(),
                SizedBox(height: 8),
                Divider(),
                SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      "Price",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Spacer(),
                    Text("₹ 0 - ₹ 1,00,000"),
                  ],
                ),
                SizedBox(height: 8),
                PriceSliderWidget(),
                SizedBox(height: 8),
                Divider(),
                SizedBox(height: 8),
                Text(
                  "Brands ",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),

                SizedBox(height: 8),
                CustemButton(Label: "Apply Filters", onpressed: () {}),
              ],
            ),
          ),
        ),
      );
    },
    barrierColor: Colors.black.withAlpha(120),
    backgroundColor: Colors.white,
    clipBehavior: Clip.antiAlias,
  );
}
