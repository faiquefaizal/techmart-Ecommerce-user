// import 'package:flutter/material.dart';

// import 'package:techmart/features/track_order/model/order_status.dart';
// import 'package:timeline_tile/timeline_tile.dart';

// class OrderTrackingTimeline extends StatelessWidget {
//   final String status;
//   final String updatedAt;

//   OrderTrackingTimeline({
//     super.key,
//     required this.status,
//     required this.updatedAt,
//   });

//   final List<String> steps = [
//     "Pending",
//     "proccessing",
//     "shipped",
//     "outfordelivery",
//     "delivery",
//   ];

//   @override
//   Widget build(BuildContext context) {
//     int currentIndex = getIndexWithStatus(status);

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
//               child: Icon(
//                 isCompleted
//                     ? Icons.check
//                     : (isCurrent
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
//                   steps[index].toUpperCase(),
//                   style: TextStyle(
//                     fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
//                     fontSize: 16,
//                   ),
//                 ),
//                 if (isCurrent)
//                   Text(
//                     _formatTime(updatedAt),
//                     style: const TextStyle(fontSize: 12, color: Colors.grey),
//                   ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   String _formatTime(String dateStr) {
//     try {
//       final date = DateTime.parse(dateStr).toLocal();
//       return "${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}";
//     } catch (_) {
//       return dateStr;
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:techmart/features/orders/model/order_model.dart';
import 'package:techmart/features/track_order/model/order_status.dart';
import 'package:techmart/features/track_order/utils/helper_funtions.dart';
import 'package:techmart/features/track_order/widgets/tracking_widget.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:intl/intl.dart'; // Added for date formatting

class OrderTrackingTimeline extends StatelessWidget {
  final OrderModel data;

  OrderTrackingTimeline({super.key, required this.data});

  final List<String> steps = [
    "Pending",
    "proccessing",
    "shipped",
    "outfordelivery",
    "delivery",
  ];

  @override
  Widget build(BuildContext context) {
    int currentIndex = getIndexWithStatus(data.status);

    return ListView.builder(
      itemCount: steps.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        bool isCompleted = index < currentIndex;
        bool isCurrent = index == currentIndex;

        return TimelineTile(
          alignment: TimelineAlign.start,
          // lineXY: 0.0,
          isFirst: index == 0,
          isLast: index == steps.length - 1,
          beforeLineStyle: LineStyle(
            color: index <= currentIndex ? Colors.black : Colors.grey.shade300,
            thickness: 2,
          ),
          afterLineStyle: LineStyle(
            color: index < currentIndex ? Colors.black : Colors.grey.shade300,
            thickness: (isCompleted || isCurrent) ? 2 : 1,
          ),
          indicatorStyle: IndicatorStyle(
            drawGap: true,
            width: 40,
            indicatorXY: 0,
            height: 50,
            indicator: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    isCompleted
                        ? Colors.black
                        : (isCurrent ? Colors.black : Colors.grey.shade300),
              ),
              child:
                  isCompleted
                      ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: imageIcons[index],
                      )
                      : Icon(
                        (isCurrent)
                            ? Icons.radio_button_checked
                            : Icons.circle_outlined,
                        color: Colors.white,
                        size: 18,
                      ),
            ),
          ),
          endChild: Container(
            height: 100,
            padding: const EdgeInsets.only(left: 10, top: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  displayLabels[index],
                  style: TextStyle(
                    fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                    fontSize: 16,
                  ),
                ),
                if (isCurrent)
                  Text(
                    formatTime(data.updateTime ?? data.createTime),
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
