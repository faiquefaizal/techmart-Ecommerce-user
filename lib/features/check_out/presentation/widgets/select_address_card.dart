import 'package:flutter/material.dart';
import 'package:techmart/core/widgets/spacing_widget.dart';
import 'package:techmart/features/check_out/cubit/selected_address_cubit.dart';

class SelectAddressCard extends StatelessWidget {
  final String title;
  final String address;
  bool isDefault;
  String value;
  String groupvalue;
  SelectedAddressCubit addresscubic;
  SelectAddressCard({
    required this.groupvalue,
    required this.value,
    super.key,
    required this.title,
    required this.address,
    required this.isDefault,
    required this.addresscubic,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300, width: 1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: Icon(Icons.location_on_outlined, color: Colors.grey, size: 35),
        title: Row(
          children: [
            Text(title, style: Theme.of(context).textTheme.labelLarge),
            HorizontalSpaceWisget(5),
            (isDefault)
                ? Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),

                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(4),
                  ),

                  child: Text(
                    "DEFAULT",
                    style: TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.5,
                      color: Colors.black,
                    ),
                  ),
                )
                : SizedBox(),
          ],
        ),
        subtitle: Text(
          address,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w300,
            color: Colors.grey.shade400,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Transform.scale(
          scale: 1.4,
          child: Radio<String>(
            activeColor: Colors.black,
            value: value,
            groupValue: groupvalue,
            onChanged: (_) {
              addresscubic.selectId(value);
            },
          ),
        ),
      ),
    );
  }
}
