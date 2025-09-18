import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:techmart/features/address/cubit/map_cubit.dart';

class GoogleMapWidget extends StatelessWidget {
  const GoogleMapWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final mapCubit = context.watch<MapCubit>().state;
    return GoogleMap(
      markers: {mapCubit.marker},
      onTap: (currentLoc) {
        context.read<MapCubit>().addMarker(currentLoc);
      },
      initialCameraPosition: CameraPosition(
        target: mapCubit.currentLocation,
        zoom: 16,
      ),
    );
  }
}
