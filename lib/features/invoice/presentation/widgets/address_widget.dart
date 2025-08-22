import 'package:pdf/widgets.dart' as pw;
import 'package:techmart/features/address/models/address_model.dart';

pw.Widget buildAddress(AddressModel address) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Text(
        "Shipping Address:",
        style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
      ),
      pw.SizedBox(height: 5),
      pw.Text(address.fullName),

      pw.Text(address.fulladdress),
      pw.Text("Phone: ${address.phoneNumber}"),
    ],
  );
}
