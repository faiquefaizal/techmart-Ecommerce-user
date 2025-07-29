import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_view/photo_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:techmart/features/home_page/features/image_preview/cubit/image_index_cubit.dart';
import 'package:techmart/features/home_page/features/image_preview/widgets/show_iamge_preview.dart';
import 'package:techmart/features/wishlist_page/cubit/wishlist_cubit.dart';

class HomeCorosal extends StatelessWidget {
  final List<String>? imageUrls;
  final CarouselSliderController corosel = CarouselSliderController();

  HomeCorosal({super.key, required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    final index = context.watch<ImageIndexCubit>().state;

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CarouselSlider(
          carouselController: corosel,
          options: CarouselOptions(
            clipBehavior: Clip.hardEdge,
            onPageChanged: (index, reason) {
              context.read<ImageIndexCubit>().chageIndex(index);
            },
            height: 160,
            reverse: true,
            viewportFraction: 1.0,
            enableInfiniteScroll: true,
            autoPlay: true,
          ),
          items:
              imageUrls?.map((url) {
                return ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(15),
                  child: Image.network(
                    url,
                    height: double.infinity,
                    fit: BoxFit.fill,
                    width: double.infinity,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 200,
                        width: double.infinity,
                        color: Colors.grey[200],
                        child: const Icon(
                          Icons.image,
                          color: Colors.grey,
                          size: 50,
                        ),
                      );
                    },
                  ),
                );
              }).toList() ??
              [const Center(child: Text('No images'))],
        ),

        if (imageUrls != null && imageUrls!.length > 1) ...[
          Positioned(
            bottom: 10,

            child: AnimatedSmoothIndicator(
              activeIndex: index,
              effect: ExpandingDotsEffect(
                activeDotColor: Colors.black,
                dotHeight: 8,
                dotWidth: 8,
                spacing: 6,
                dotColor: Color.fromARGB(108, 152, 152, 152),
              ),
              //  SwapEffect(
              //   type: SwapType.yRotation,

              //   paintStyle: PaintingStyle.fill,
              //   activeDotColor: Colors.black,
              //   dotColor: Color.fromARGB(108, 152, 152, 152),
              //   dotHeight: 8,
              //   dotWidth: 8,
              //   spacing: 6,
              // ),
              count: imageUrls!.length,
              onDotClicked: (index) => corosel.animateToPage(index),
            ),
          ),
        ],
      ],
    );
  }
}
