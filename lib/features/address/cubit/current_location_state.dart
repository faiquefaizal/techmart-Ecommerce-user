part of 'current_location_cubit.dart';

sealed class CurrentLocationState extends Equatable {
  const CurrentLocationState();

  @override
  List<Object> get props => [];
}

final class CurrentLocationInitial extends CurrentLocationState {}

final class LoadingState extends CurrentLocationState {}

final class LocationSuccess extends CurrentLocationState {}

final class ErrorState extends CurrentLocationState {
  final String error;
  const ErrorState(this.error);
}
