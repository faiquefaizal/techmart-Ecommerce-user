import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:techmart/features/orders/model/order_model.dart';

pw.Widget buildHeader(OrderModel order) {
  return pw.Row(
    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
    children: [
      pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            "TechMart",
            style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
          ),
          pw.Text(
            "Invoice",
            style: pw.TextStyle(fontSize: 16, color: PdfColors.grey600),
          ),
          pw.SizedBox(height: 5),
          pw.Text("Order ID: ${order.orderId}"),
          pw.Text("Date: ${order.createTime.toLocal()}"),
          pw.Text("Payment Mode: ${order.paymentMode}"),
          pw.Text("Status: ${order.status}"),
        ],
      ),
      pw.BarcodeWidget(
        data: order.orderId,
        barcode: pw.Barcode.qrCode(),
        width: 70,
        height: 70,
      ),
    ],
  );
}
