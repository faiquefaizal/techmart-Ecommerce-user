import 'package:pdf/widgets.dart' as pw;
import 'package:techmart/features/invoice/model/invoice_model.dart';
import 'package:techmart/features/invoice/presentation/widgets/address_widget.dart';
import 'package:techmart/features/invoice/presentation/widgets/header_widget.dart';
import 'package:techmart/features/invoice/presentation/widgets/order_details_widgets.dart';
import 'package:techmart/features/invoice/presentation/widgets/summery_widget.dart';
import 'package:techmart/features/orders/model/order_model.dart';

pw.Widget invoiceStructure(InvoiceModel invoice) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      buildHeader(invoice.orderModel),
      pw.SizedBox(height: 20),
      buildOrderDetails(invoice),
      pw.SizedBox(height: 20),
      buildAddress(invoice.orderModel.address),
      pw.Spacer(),
      buildSummary(invoice.orderModel),
      pw.Divider(),
      pw.Center(
        child: pw.Text(
          "Thank you for shopping with us!",
          style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
        ),
      ),
    ],
  );
}
