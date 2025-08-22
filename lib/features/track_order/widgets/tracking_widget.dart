// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:intl/intl.dart';
// import 'package:techmart/features/track_order/model/order_status.dart';
// import 'package:timeline_tile/timeline_tile.dart';

class DummyData {
  String status;
  DateTime updatedTime;
  DummyData({required this.status, required this.updatedTime});
}

// class SampleTimeLine extends StatelessWidget {
//   final DummyData data;
//   const SampleTimeLine({super.key, required this.data});

//   final List<String> steps = const [
//     "Pending",
//     "proccessing",
//     "shipped",
//     "outfordelivery",
//     "delivery",
//   ];

//   final List<String> displayLabels = const [
//     "OrderPlaced",
//     "Processing",
//     "Shipped",
//     "Out for Delivery",
//     "Delivered",
//   ];
  

//   @override
//   Widget build(BuildContext context) {
//     int currentIndex = getIndexWithStatus(data.status);

//     return ListView.builder(
//       itemCount: steps.length,
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       itemBuilder: (context, index) {
//         bool isCompleted = index < currentIndex;
//         bool isCurrent = index == currentIndex;

//         return TimelineTile(
//           isFirst: index == 0,
//           isLast: index == steps.length - 1,
//           beforeLineStyle: LineStyle(
//             color: isCompleted ? Colors.green : Colors.grey.shade300,
//             thickness: 2,
//           ),
//           afterLineStyle: LineStyle(
//             color:
//                 (isCompleted || isCurrent)
//                     ? Colors.green
//                     : Colors.grey.shade300,
//             thickness: 2,
//           ),
//           indicatorStyle: IndicatorStyle(
//             width: 30,
//             height: 30,
//             indicator: Container(
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color:
//                     isCompleted
//                         ? Colors.green
//                         : (isCurrent ? Colors.blue : Colors.grey.shade300),
//               ),
//               child :  isCompleted ? SvgPicture.asset("assets/status_order_placed.svg"): 
                
//                      I(Icons.check) ?
//                     (isCurrent
//                         ? Icons.radio_button_checked
//                         : Icons.circle_outlined),
//                 color: Colors.white,
//                 size: 18,
//               ),
//             ),
//           ),
//           endChild: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 12.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   displayLabels[index],
//                   style: TextStyle(
//                     fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
//                     fontSize: 16,
//                   ),
//                 ),
//                 if (isCurrent)
//                   Text(
//                     _formatTime(data.updatedTime),
//                     style: const TextStyle(fontSize: 12, color: Colors.grey),
//                   ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   String _formatTime(DateTime dateStr) {
//     try {
//       final date = dateStr.toLocal();
//       return DateFormat(
//         'MMM dd, hh:mm a',
//       ).format(date); // e.g., "Aug 13, 09:32 AM"
//     } catch (_) {
//       return "klfa";
//     }
//   }

//   // Placeholder times for completed steps
// }
