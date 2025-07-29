import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techmart/core/widgets/bottm_sheet.dart';

import 'package:techmart/features/home_page/bloc/product_bloc.dart';
import 'package:techmart/features/home_page/features/product_filter/cubit/filter_cubit.dart';

import 'package:techmart/features/home_page/features/product_filter/widgets/price_sort_chip.dart';
import 'package:techmart/features/home_page/features/visual_search/service/viusal_search.dart';
import 'package:techmart/core/widgets/snakbar_widgert.dart';
import 'package:techmart/features/home_page/presentation/widgets/visual_search_loading.dart';

class CustemSearchField extends StatelessWidget {
  final Function(String)? onChanged;
  final TextEditingController searchController;

  const CustemSearchField({
    super.key,
    required this.searchController,
    this.onChanged,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Card(
            color: Colors.white,
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: SizedBox(
                height: 60,
                child: Row(
                  children: [
                    const Icon(Icons.search, color: Colors.grey),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        onChanged: onChanged,
                        decoration: InputDecoration(
                          hintText: "Search electronics...",
                          hintStyle: TextStyle(
                            color: Colors.grey.shade400,
                            fontWeight: FontWeight.w500,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.camera_alt_outlined, color: Colors.grey),
                      onPressed: () async {
                        context.read<ProductBloc>().add(
                          SearchVisually(controller: searchController),
                        );
                        // visualSearchLoading(context);
                        final result = await runVisualSearch();

                        if (result != null) {
                          final query =
                              "${result.safeCategory} ${result.safeModel} ${result.brandName}"
                                  .trim();

                          searchController.text = query;

                          context.read<ProductBloc>().add(
                            SearchProduct(productName: query),
                          );
                        } else {
                          custemSnakbar(
                            context: context,
                            message: "Viaual Serach failed",
                            color: Colors.red,
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            final filterCubic = context.read<FilterCubit>();
            final productBloc = context.read<ProductBloc>();
            custemBottomSheet(
              context,
              productBloc,
              filterCubic,
              searchController,
            );
          },
          child: Container(
            height: 60,
            width: 55,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.black,
            ),
            child: Icon(Icons.tune, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
