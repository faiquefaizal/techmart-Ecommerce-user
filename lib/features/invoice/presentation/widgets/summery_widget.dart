import 'package:pdf/widgets.dart' as pw;
import 'package:techmart/features/orders/model/order_model.dart';

pw.Widget buildSummary(OrderModel order, pw.Font invoiceFont) {
  final delivery = order.deliveryCharge ?? 0;
  final total = order.total + delivery;

  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.end,
    children: [
      pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text("Subtotal:"),
          pw.Text(
            "₹${order.total.toStringAsFixed(2)}",
            style: pw.TextStyle(font: invoiceFont),
          ),
        ],
      ),
      pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text("Delivery:"),
          pw.Text(
            "₹${delivery.toStringAsFixed(2)}",
            style: pw.TextStyle(font: invoiceFont),
          ),
        ],
      ),
      if (order.couponCode != null)
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text("Coupon (${order.couponCode}):"),
            pw.Text("- Applied"),
          ],
        ),
      pw.Divider(),
      pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            "Total:",
            style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
          ),
          pw.Text(
            "₹${total.toStringAsFixed(2)}",
            style: pw.TextStyle(
              font: invoiceFont,
              fontSize: 16,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
        ],
      ),
    ],
  );
}
