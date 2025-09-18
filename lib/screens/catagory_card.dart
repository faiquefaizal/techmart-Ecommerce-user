import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techmart/features/home_page/bloc/product_bloc.dart';
import 'package:techmart/features/home_page/cubit/catogory_cubic_cubit.dart';
import 'package:techmart/features/home_page/features/product_filter/cubit/filter_cubit.dart';
import 'package:techmart/features/home_page/models/catagory_model.dart';

class CatagoryCard extends StatelessWidget {
  final CategoryModel cat;
  final CatagoryCubicLoaded state;
  const CatagoryCard({super.key, required this.cat, required this.state});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              context.read<CatogoryCubicCubit>().selectcatagory(
                cat.categoryuid,
              );
              final filter = context.read<FilterCubit>().state;
              context.read<ProductBloc>().add(
                CombinedSearchAndFilter(
                  query: "",
                  filters: filter,
                  catagoryId:
                      (context.read<CatogoryCubicCubit>().state
                              as CatagoryCubicLoaded)
                          .selectedId,
                ),
              );
            },
            child: Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                // borderRadius: BorderRadius.all(Radius.circular()),
                // borderRadius: BorderRadius.circular(10),
                color:
                    (cat.categoryuid == state.selectedId)
                        ? const Color.fromARGB(255, 0, 0, 0)
                        : Colors.white,
              ),

              child: CachedNetworkImage(
                imageUrl: cat.imageurl,
                placeholder:
                    (context, url) => Container(color: Colors.grey[300]),
                fit: BoxFit.contain,
              ),
            ),
          ),
          Text(
            cat.name,
            style:
                (cat.categoryuid == state.selectedId)
                    ? GoogleFonts.lato(
                      fontWeight: FontWeight.w900,
                      fontSize: 10,
                    )
                    : GoogleFonts.lato(
                      fontWeight: FontWeight.normal,
                      fontSize: 9,
                    ),
          ),
        ],
      ),
    );
  }
}
