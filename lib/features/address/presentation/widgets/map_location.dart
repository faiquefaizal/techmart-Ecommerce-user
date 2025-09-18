import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:techmart/features/address/cubit/map_cubit.dart';
import 'package:techmart/features/address/presentation/screens/map_screen.dart';
import 'package:techmart/features/address/service/user_current_location.dart';

class MapLocationButton extends StatelessWidget {
  const MapLocationButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        final Position pos =
            await UserCurrentLocationService.getCurrentLocation();
        final bitmap = await BitmapDescriptor.asset(
          const ImageConfiguration(size: Size(30, 40)),
          'assets/location_pin.png',
        );
        final Placemark address =
            await UserCurrentLocationService.getAddressBasedOnPosition(pos);
        final LatLng curPos = LatLng(pos.latitude, pos.longitude);
        if (context.mounted) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder:
                  (context) => BlocProvider(
                    create: (context) => MapCubit(curPos, bitmap, address),
                    child: MapScreen(),
                  ),
            ),
          );
        }
      },
      child: Text(
        "+ Locate on Map",
        style: Theme.of(context).textTheme.headlineSmall,
      ),
    );
  }
}
