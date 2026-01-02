import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techmart/core/widgets/spacing_widget.dart';
import 'package:techmart/features/home_page/bloc/product_bloc.dart';
import 'package:techmart/features/home_page/cubit/catogory_cubic_cubit.dart';
import 'package:techmart/features/home_page/cubit/cubit/banner_cubit.dart';
import 'package:techmart/features/home_page/features/banners/widget/home_corosal.dart';
import 'package:techmart/features/home_page/features/product_filter/cubit/filter_cubit.dart';
import 'package:techmart/features/home_page/presentation/widgets/animated_grid_view.dart';
import 'package:techmart/features/home_page/presentation/widgets/bacnner_shimmers.dart';
import 'package:techmart/features/home_page/presentation/widgets/header_widget.dart';
import 'package:techmart/features/home_page/presentation/widgets/loading_product_card.dart';
import 'package:techmart/features/home_page/presentation/screens/search_not_found.dart';
import 'package:techmart/features/home_page/presentation/widgets/custem_search_field.dart';
import 'package:techmart/features/home_page/presentation/widgets/staggerd_colomn_animater.dart';
import 'package:techmart/features/home_page/presentation/widgets/visual_search_loading.dart';
import 'package:techmart/features/home_page/utils/helper_funtion.dart';
import 'package:techmart/screens/sample.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final availableHeight = screenHeight - getHeaderHieght();
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 15),
          child: StaggerdColomnAnimater(
            availableHeight: availableHeight,
            children: [
              HeaderWidget(),
              const VerticalSpaceWisget(5),
              CustemSearchField(
                searchController: searchController,
                onChanged: (quary) {
                  final filter = context.read<FilterCubit>().state;
                  context.read<ProductBloc>().add(
                    CombinedSearchAndFilter(
                      query: quary,
                      filters: filter,
                      catagoryId: null,
                      // (context.read<CatogoryCubicCubit>().state
                      //         as CatagoryCubicLoaded)
                      //     .selectedId,
                    ),
                  );
                },
              ),
              if (searchController.text.isEmpty) ...[
                VerticalSpaceWisget(3),
                CatagoryWidget(),
                BlocBuilder<BannerCubit, BannerState>(
                  builder: (context, state) {
                    if (state is BannerInitial || state is BannerLoading) {
                      return bannerShimmerPlaceholder();
                    }
                    if (state is BannerLoaded) {
                      return HomeCorosal(imageUrls: state.imageUrls);
                    }
                    return SizedBox.shrink();
                  },
                ),
              ] else
                SizedBox.shrink(),
              SizedBox(
                height: availableHeight,
                child: BlocConsumer<ProductBloc, ProductState>(
                  listenWhen: (previous, current) {
                    return previous is VisualSearchLoading ||
                        current is VisualSearchLoading;
                  },
                  listener: (context, state) {
                    Navigator.of(context, rootNavigator: true).maybePop();

                    if (state is VisualSearchLoading) {
                      visualSearchLoading(context);
                    }
                  },
                  builder: (context, state) {
                    if (state is ProductInitial) {
                      log("waiting reached");
                      return loadingShimmerGrid();
                    }
                    if (state is ProductSearchError) {
                      log("error state");
                      return SearchNotFound(error: state.message);
                    }
                    if (state is ProductSearchNotFound) {
                      log("search not found state callled");
                      return SearchNotFound();
                    }
                    if (state is ProductLoading) {
                      final products = state.products;
                      return AnimatedGridView(products: products);
                    }
                    return SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
