import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:techmart/features/address/models/address_model.dart';
import 'package:techmart/features/invoice/model/invoice_model.dart';
import 'package:techmart/features/invoice/presentation/screens/invoice.dart';
import 'package:techmart/features/orders/model/order_model.dart';

class InvoiceService {
  static Future<Uint8List> generateInvoice(InvoiceModel invoice) async {
    final data = await rootBundle.load("assets/GeneralSans-Semibold.otf");
    final custemfont = pw.Font.ttf(data.buffer.asByteData());
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return invoiceStructure(invoice, custemfont);
        },
      ),
    );
    return pdf.save();
  }

  static saveInvoice(String invoiceName, Uint8List invoiceData) async {
    Directory? directPath = await getDownloadsDirectory();

    directPath ??= await getExternalStorageDirectory();
    directPath ??= await getTemporaryDirectory();

    String filePath = "${directPath.path}/Invoice$invoiceName.pdf";
    File file = File(filePath);
    Logger().d(filePath);
    await file.writeAsBytes(invoiceData);
    await OpenFile.open(filePath);
  }
}
