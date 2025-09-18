part of 'banner_cubit.dart';

sealed class BannerState extends Equatable {
  const BannerState();

  @override
  List<Object> get props => [];
}

final class BannerInitial extends BannerState {}

final class BannerLoading extends BannerState {}

class BannerLoaded extends BannerState {
  final List<String> imageUrls;
  const BannerLoaded({required this.imageUrls});

  @override
  List<Object> get props => [imageUrls];
}

class BannerError extends BannerState {
  final String message;
  const BannerError({required this.message});

  @override
  List<Object> get props => [message];
}
