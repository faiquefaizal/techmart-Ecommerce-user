import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:techmart/core/widgets/button_widgets.dart';
import 'package:techmart/core/widgets/custem_appbar.dart';
import 'package:techmart/core/widgets/spacing_widget.dart';
import 'package:techmart/features/address/cubit/map_cubit.dart';
import 'package:techmart/features/address/presentation/widgets/google_map_widget.dart';
import 'package:techmart/features/address/presentation/widgets/map_address_widget.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: custemAppbar(heading: "Add new Address", context: context),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Column(
          children: [
            Expanded(flex: 7, child: GoogleMapWidget()),
            Flexible(flex: 3, child: MapAddressWidget()),
          ],
        ),
      ),
    );
  }
}
