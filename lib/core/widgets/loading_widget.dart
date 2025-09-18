// import 'package:flutter/material.dart';

// class CustomLoadingIndicator extends StatelessWidget {
//   const CustomLoadingIndicator({super.key, this.label});

//   final String? label;

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Container(color: Colors.black45),
//         Center(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               CircularProgressIndicator(
//                 valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
//                 strokeWidth: 4.0,
//               ),
//               if (label != null) ...[
//                 SizedBox(height: 16),
//                 Text(
//                   label!,
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ],
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CustomLoadingIndicator extends StatelessWidget {
  const CustomLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.beat(color: Colors.black, size: 60),
    );
  }
}
