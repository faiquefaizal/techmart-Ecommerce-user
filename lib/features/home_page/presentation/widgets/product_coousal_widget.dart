// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';

// class ProductCarouselWidget extends StatelessWidget {
//   final List<String> urls;

//   const ProductCarouselWidget({super.key, required this.urls});

//   @override
//   Widget build(BuildContext context) {
//     return CarouselSlider(
//       options: CarouselOptions(
//         height: 300,
//         aspectRatio: 16 / 9,
//         viewportFraction: 1.0,
//         autoPlay: true,
//         autoPlayCurve: Curves.fastOutSlowIn,
//         enableInfiniteScroll: true,
//         autoPlayAnimationDuration: const Duration(milliseconds: 800),
//       ),
//       items:
//           urls.isNotEmpty
//               ? urls.map((url) {
//                 return Builder(
//                   builder: (BuildContext context) {
//                     return Image.network(
//                       url,
//                       fit: BoxFit.cover,
//                       width: double.infinity,
//                       errorBuilder: (context, error, stackTrace) {
//                         return Container(
//                           height: 300,
//                           width: double.infinity,
//                           color: Colors.grey[200],
//                           child: const Icon(
//                             Icons.image,
//                             color: Colors.grey,
//                             size: 50,
//                           ),
//                         );
//                       },
//                     );
//                   },
//                 );
//               }).toList()
//               : [const Center(child: Text('No images'))],
//     );
//   }
// }
