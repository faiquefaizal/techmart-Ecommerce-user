import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:techmart/features/address/service/user_current_location.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  LatLng currentPos;
  AssetMapBitmap bitmap;
  Placemark address;
  MapCubit(this.currentPos, this.bitmap, this.address)
    : super(
        MapState(
          address: address,
          currentLocation: currentPos,
          marker: Marker(
            markerId: MarkerId(currentPos.toString()),
            position: currentPos,
            draggable: true,
            icon: bitmap,
          ),
        ),
      );
  addMarker(LatLng markedLoc) async {
    emit(state.copywith(loading: true));
    final address = await UserCurrentLocationService.getAddressBasedOnLatLog(
      markedLoc.latitude,
      markedLoc.longitude,
    );
    emit(
      state.copywith(
        loading: false,
        marker: Marker(
          icon: bitmap,
          markerId: MarkerId(markedLoc.toString()),
          position: markedLoc,
          draggable: true,
        ),
        address: address,
      ),
    );
  }
}
