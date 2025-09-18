import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:techmart/features/home_page/cubit/catogory_cubic_cubit.dart';

import 'package:techmart/screens/catagory_card.dart';
import 'package:techmart/screens/catagory_shimmer.dart';

class CatagoryWidget extends StatelessWidget {
  const CatagoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CatogoryCubicCubit, CatogoryCubicState>(
      builder: (context, state) {
        if (state is CatagoryCubicLoading || state is CatogoryCubicInitial) {
          return CatagoryShimmer();
        }
        if (state is CatagoryCubicLoaded) {
          return SizedBox(
            height: 100,
            child: AnimationLimiter(
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final cat = state.catagoryList[index];

                  return AnimationConfiguration.staggeredList(
                    position: index,

                    duration: Duration(seconds: 2),
                    child: SlideAnimation(
                      horizontalOffset: 100,
                      curve: Curves.easeOut,
                      child: CatagoryCard(cat: cat, state: state),
                    ),
                  );
                },
                itemCount: state.catagoryList.length,
              ),
            ),
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
