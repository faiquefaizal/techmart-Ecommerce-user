part of 'map_cubit.dart';

final class MapState extends Equatable {
  final LatLng currentLocation;
  final Marker marker;
  final bool loading;
  final Placemark address;
  const MapState({
    required this.currentLocation,
    required this.marker,
    required this.address,
    this.loading = false,
  });

  @override
  List<Object?> get props => [marker];
  MapState copywith({
    LatLng? currentLocation,
    Marker? marker,
    bool? loading,
    Placemark? address,
  }) {
    return MapState(
      loading: loading ?? this.loading,
      address: address ?? this.address,
      currentLocation: currentLocation ?? this.currentLocation,
      marker: marker ?? this.marker,
    );
  }
}
