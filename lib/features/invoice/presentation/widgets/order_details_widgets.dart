import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:techmart/features/invoice/model/invoice_model.dart';
import 'package:techmart/features/orders/model/order_model.dart';

pw.Widget buildOrderDetails(InvoiceModel invoice, pw.Font invoiceFont) {
  return pw.Table(
    border: pw.TableBorder.all(),
    columnWidths: {
      0: pw.FlexColumnWidth(4),
      1: pw.FlexColumnWidth(2),
      2: pw.FlexColumnWidth(2),
      3: pw.FlexColumnWidth(2),
      4: pw.FixedColumnWidth(2),
    },
    children: [
      pw.TableRow(
        decoration: pw.BoxDecoration(color: PdfColors.grey300),
        children: [
          pw.Padding(
            padding: const pw.EdgeInsets.all(8),
            child: pw.Text(
              "Description",
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            ),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.all(8),
            child: pw.Text(
              "Price",
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            ),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.all(8),
            child: pw.Text(
              "Qty",
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            ),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.all(8),
            child: pw.Text(
              "Tax",
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            ),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.all(8),
            child: pw.Text(
              "Total Amount",
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            ),
          ),
        ],
      ),

      pw.TableRow(
        children: [
          pw.Padding(
            padding: const pw.EdgeInsets.all(8),
            child: pw.Text(invoice.productDiscription),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.all(8),
            child: pw.Text(
              "₹${(invoice.orderModel.total - invoice.taxAmount).toString()}",
              style: pw.TextStyle(font: invoiceFont),
            ),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.all(8),
            child: pw.Text("${invoice.orderModel.quantity}"),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.all(8),
            child: pw.Text(
              "₹${invoice.taxAmount.toStringAsFixed(2)}",
              style: pw.TextStyle(font: invoiceFont),
            ),
          ),

          pw.Padding(
            padding: const pw.EdgeInsets.all(8),
            child: pw.Text(
              "₹${invoice.orderModel.total.toStringAsFixed(2)}",
              style: pw.TextStyle(font: invoiceFont),
            ),
          ),
        ],
      ),
    ],
  );
}
