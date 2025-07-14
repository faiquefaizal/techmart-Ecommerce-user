import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:techmart/features/home_page/features/image_preview/cubit/image_index_cubit.dart';
import 'package:techmart/features/wishlist_page/cubit/wishlist_cubit.dart';

class ProductCarouselWidgetUpdated extends StatelessWidget {
  final List<String>? imageUrls;
  final corosel = CarouselSliderController();
  ProductCarouselWidgetUpdated({super.key, required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    final index = context.watch<ImageIndexCubit>().state;
    return SizedBox(
      height: 300,
      child: Stack(
        children: [
          CarouselSlider(
            carouselController: corosel,
            options: CarouselOptions(
              onPageChanged: (index, reason) {
                context.read<ImageIndexCubit>().chageIndex(index);
              },
              height: 300,
              aspectRatio: 16 / 9,
              viewportFraction: 1.0,
            ),
            items:
                imageUrls?.map((url) {
                  return Hero(
                    tag: imageUrls!.first,
                    child: Material(
                      type: MaterialType.transparency,
                      child: Image.network(
                        url,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 300,
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
                    ),
                  );
                }).toList() ??
                [const Center(child: Text('No images'))],
          ),
          Positioned(
            bottom: 10,

            child: AnimatedSmoothIndicator(
              activeIndex: index,
              effect: SwapEffect(
                activeDotColor: Colors.black,
                spacing: 10,
                type: SwapType.yRotation,
                dotColor: Colors.white,
              ),
              count: imageUrls?.length ?? 0,
              onDotClicked: (index) => corosel.animateToPage(index),
            ),
          ),
        ],
      ),
    );
  }
}
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:photo_view/photo_view.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';
// import 'package:techmart/features/home_page/features/image_preview/cubit/image_index_cubit.dart';
// import 'package:techmart/features/wishlist_page/cubit/wishlist_cubit.dart';

// class ProductCarouselWidgetUpdated extends StatelessWidget {
//   final List<String>? imageUrls;
//   final CarouselController corosel = CarouselController();

//   ProductCarouselWidgetUpdated({super.key, required this.imageUrls});

//   @override
//   Widget build(BuildContext context) {
//     final index = context.watch<ImageIndexCubit>().state;

//     return SizedBox(
//       height: 300,
//       child: Stack(
//         children: [
//           // Main Carousel
//           CarouselSlider(
//             carouselController: corosel,
//             options: CarouselOptions(
//               onPageChanged: (index, reason) {
//                 context.read<ImageIndexCubit>().changeIndex(index);
//               },
//               height: 300,
//               aspectRatio: 16 / 9,
//               viewportFraction: 1.0,
//               enableInfiniteScroll: imageUrls?.length ?? 0 > 1,
//             ),
//             items:
//                 imageUrls?.map((url) {
//                   return GestureDetector(
//                     onTap: () => _showImagePreview(context, url),
//                     child: Hero(
//                       tag: url, // Unique tag for each image
//                       child: Material(
//                         type: MaterialType.transparency,
//                         child: Image.network(
//                           url,
//                           fit: BoxFit.contain,
//                           width: double.infinity,
//                           errorBuilder: (context, error, stackTrace) {
//                             return Container(
//                               height: 300,
//                               width: double.infinity,
//                               color: Colors.grey[200],
//                               child: const Icon(
//                                 Icons.image,
//                                 color: Colors.grey,
//                                 size: 50,
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     ),
//                   );
//                 }).toList() ??
//                 [const Center(child: Text('No images'))],
//           ),

//           // Indicator Position
//           if (imageUrls != null && imageUrls!.length > 1)
//             Positioned(
//               bottom: 10,
//               left: 0,
//               right: 0,
//               child: Center(
//                 child: AnimatedSmoothIndicator(
//                   activeIndex: index,
//                   effect: const ScrollingDotsEffect(
//                     activeDotColor: Colors.black,
//                     dotColor: Colors.white70,
//                     dotHeight: 8,
//                     dotWidth: 8,
//                     spacing: 6,
//                   ),
//                   count: imageUrls!.length,
//                   onDotClicked: (index) => corosel.animateToPage(index),
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }

//   void _showImagePreview(BuildContext context, String imageUrl) {
//     Navigator.of(context).push(
//       PageRouteBuilder(
//         opaque: false,
//         pageBuilder: (BuildContext context, _, __) {
//           return Scaffold(
//             backgroundColor: Colors.black.withOpacity(0.9),
//             body: Stack(
//               children: [
//                 Center(
//                   child: PhotoView(
//                     imageProvider: NetworkImage(imageUrl),
//                     heroAttributes: PhotoViewHeroAttributes(tag: imageUrl),
//                     minScale: PhotoViewComputedScale.contained,
//                     maxScale: PhotoViewComputedScale.covered * 3,
//                     backgroundDecoration: const BoxDecoration(
//                       color: Colors.transparent,
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   top: MediaQuery.of(context).padding.top + 16,
//                   right: 16,
//                   child: IconButton(
//                     icon: const Icon(
//                       Icons.close,
//                       color: Colors.white,
//                       size: 30,
//                     ),
//                     onPressed: () => Navigator.of(context).pop(),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
