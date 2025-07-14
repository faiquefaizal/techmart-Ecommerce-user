import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techmart/core/widgets/button_widgets.dart';
import 'package:techmart/features/home_page/bloc/product_bloc.dart';

import 'package:techmart/features/home_page/features/product_filter/cubit/filter_cubit.dart';

import 'package:techmart/features/home_page/features/product_filter/widgets/brand_choic_chips.dart';
import 'package:techmart/features/home_page/features/product_filter/widgets/price_slider_widget.dart';
import 'package:techmart/features/home_page/features/product_filter/widgets/price_sort_chip.dart';

void custemBottomSheet(
  BuildContext context,
  ProductBloc productBloc,
  FilterCubit filterBloc,
  TextEditingController searchText,
) {
  filterBloc.fetchBrand();
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return MultiBlocProvider(
        providers: [
          BlocProvider.value(value: filterBloc),
          BlocProvider.value(value: productBloc),
        ],
        child: Builder(
          builder: (context) {
            final filterState = context.watch<FilterCubit>().state;
            return SingleChildScrollView(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Filter",
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        TextButton(
                          onPressed: () {
                            context.read<FilterCubit>().clearFilters();
                          },
                          child: Text(
                            "Clear",

                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
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
                    // Align(
                    //   alignment: Alignment.topCenter,
                    //   child: Text(
                    //     "₹${filterState.priceRange.start.toStringAsFixed(0)} - ₹${filterState.priceRange.end.toStringAsFixed(0)}",
                    //     style: TextStyle(
                    //       fontSize: 20,
                    //       fontWeight: FontWeight.w600,
                    //     ),
                    //   ),
                    // ),
                    SizedBox(height: 8),
                    Divider(),
                    SizedBox(height: 8),
                    Text(
                      "Brands ",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),

                    SizedBox(height: 8),

                    BrandChoicChips(),
                    SizedBox(height: 15),
                    CustemButton(
                      Label: "Apply Filters",
                      onpressed: () {
                        final currentfilterState =
                            context.read<FilterCubit>().state;
                        context.read<ProductBloc>().add(
                          CombinedSearchAndFilter(
                            query: searchText.text,
                            filters: currentfilterState,
                          ),
                        );
                        Navigator.of(context).pop();
                      },
                    ),
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
